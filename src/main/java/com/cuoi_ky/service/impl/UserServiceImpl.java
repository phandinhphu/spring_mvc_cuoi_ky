package com.cuoi_ky.service.impl;

import com.cuoi_ky.model.User;
import com.cuoi_ky.repository.UserRepository;
import com.cuoi_ky.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.Optional;

/**
 * User Service Implementation
 * Following Single Responsibility Principle
 */
@Service
@Transactional
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserServiceImpl(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
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
			
			if(passwordEncoder.matches(oldPassword, user.getPassword())) {
				userRepository.changePassword(id, passwordEncoder.encode(newPassword));
				return true;
			}
		}
		return false;
	}

	@Override
	public boolean updateAvatar(Integer id, String avatar) {
		return userRepository.updateAvatar(id, avatar);
	}
}
