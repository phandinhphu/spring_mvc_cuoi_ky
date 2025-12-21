package com.cuoi_ky.service;

import com.cuoi_ky.model.User;
import java.util.Optional;

/**
 * User Service Interface
 */
public interface UserService {
    
    /**
     * Register new user
     */
    User registerUser(User user);
    
    /**
     * Authenticate user
     */
    Optional<User> authenticate(String username, String password);
    
    /**
     * Get user by ID
     */
    Optional<User> getUserById(Integer id);
    
    /**
     * Get user by username
     */
    Optional<User> getUserByUsername(String username);
    
    /**
     * Check if username exists
     */
    boolean isUsernameExists(String username);
    
    /**
     * Check if email exists
     */
    boolean isEmailExists(String email);
    
    /**
     * Update profile
     */
    boolean updateProfile(Integer id, String fullname);
    
    /**
     * Change password
     */
    boolean changePassword(Integer id, String oldPassword, String newPassword);
    
    /**
     * Update avatar
     */
    boolean updateAvatar(Integer id, String avatar);
}
