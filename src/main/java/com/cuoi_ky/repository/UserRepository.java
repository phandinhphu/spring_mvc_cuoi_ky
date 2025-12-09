package com.cuoi_ky.repository;

import com.cuoi_ky.model.User;
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
     * Check if username exists
     */
    boolean existsByUsername(String username);
    
    /**
     * Check if email exists
     */
    boolean existsByEmail(String email);
}
