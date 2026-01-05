package com.cuoi_ky.repository;

import com.cuoi_ky.model.User;

import java.time.LocalDateTime;
import java.util.Optional;

/**
 * User Repository Interface
 */
public interface UserRepository extends BaseRepository<User, Integer> {
    
    /**
     * Find user by username
     */
    Optional<User> findByUsername(String username);
    
    /**
     * Find user by email
     */
    Optional<User> findByEmail(String email);
    
    /**
     * Find user by forgot password token
     */
    Optional<User> findByForgotPasswordToken(String token);
    
    /**
     * Check if username exists
     */
    boolean existsByUsername(String username);
    
    /**
     * Check if email exists
     */
    boolean existsByEmail(String email);
    
    /**
     * Update profile
     */
    public boolean updateProfile(Integer id, String fullname);
    
    /**
     * Change password
     */
    public boolean changePassword(Integer id, String password);
    
    /**
     * Update avatar
     */
    public boolean updateAvatar(Integer id, String avatar);
    
    /**
     * Update forgot password token and expiry
     */
    public boolean updateForgotPasswordToken(Integer id, String token, 
			LocalDateTime expiry);
    
    /**
     * Reset password using token
     */
    public boolean resetPassword(String token, String newPassword);
}
