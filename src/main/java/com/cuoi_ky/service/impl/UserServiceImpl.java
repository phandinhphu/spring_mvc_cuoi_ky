package com.cuoi_ky.service.impl;

import com.cuoi_ky.dto.GoogleUser;
import com.cuoi_ky.model.User;
import com.cuoi_ky.repository.UserRepository;
import com.cuoi_ky.service.CloudinaryService;
import com.cuoi_ky.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.Map;
import java.util.Optional;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final CloudinaryService cloudinaryService;

    @Autowired
    public UserServiceImpl(UserRepository userRepository, PasswordEncoder passwordEncoder, CloudinaryService cloudinaryService) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.cloudinaryService = cloudinaryService;
    }

    @Override
    public User registerUser(User user) {
        // Set created date
        user.setCreatedAt(new Date());

		// Hash the password before saving
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        
        return userRepository.save(user);
    }
    
    @Override
    public User registerUserWithGoogle(GoogleUser googleUser) {
    	User user = userRepository.findByEmail(googleUser.getEmail()).orElse(null);
    	if (user == null) {
			user = new User();
			user.setUsername(googleUser.getEmail());
			user.setEmail(googleUser.getEmail());
			user.setFullname(googleUser.getName());
			user.setAvatar(googleUser.getPicture());
			user.setGoogleId(googleUser.getId());
			user.setCreatedAt(new Date());
			
			user = userRepository.save(user);
		} else if (user.getGoogleId() == null) {
    		user.setAvatar(googleUser.getPicture());
    		user.setGoogleId(googleUser.getId());
    		userRepository.save(user);
    	}
    	
    	return user;
	}

    @Override
    public Optional<User> authenticate(String username, String password) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (passwordEncoder.matches(password, user.getPassword())) {
                return Optional.of(user);
            }
        }
        
        return Optional.empty();
    }

    @Override
    public Optional<User> getUserById(Integer id) {
        return userRepository.findById(id);
    }

    @Override
    public Optional<User> getUserByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    public boolean isUsernameExists(String username) {
        return userRepository.existsByUsername(username);
    }

    @Override
    public boolean isEmailExists(String email) {
        return userRepository.existsByEmail(email);
    }

	@Override
	public boolean updateProfile(Integer id, String fullname) {
		return userRepository.updateProfile(id, fullname);
	}

	@Override
	public boolean changePassword(Integer id, String oldPassword, String newPassword) {
		Optional<User> userOpt = userRepository.findById(id);
		
		if(userOpt.isPresent()) {
			User user = userOpt.get();
			
			// Nếu oldPassword = "" và user có password null và googleId khác null thì cho đổi
			if(oldPassword.isEmpty() && user.getPassword() == null && user.getGoogleId() != null) {
				userRepository.changePassword(id, passwordEncoder.encode(newPassword));
				return true;
			}
			
			// Nếu oldPassword đúng thì mới cho đổi
			if(passwordEncoder.matches(oldPassword, user.getPassword())) {
				userRepository.changePassword(id, passwordEncoder.encode(newPassword));
				return true;
			}
		}
		return false;
	}

	@Override
	public String updateAvatar(Integer id, MultipartFile file) throws Exception {
		User user = userRepository.findById(id).orElseThrow(() -> new Exception("User not found"));
		
		if (user.getAvatarPublicId() != null) {
			cloudinaryService.deleteImage(user.getAvatarPublicId());
		}
		
		Map uploadResult = cloudinaryService.uploadImage(file.getBytes());

        user.setAvatar(uploadResult.get("secure_url").toString());
        user.setAvatarPublicId(uploadResult.get("public_id").toString());

        userRepository.save(user);
        
        return user.getAvatar();
	}
}
