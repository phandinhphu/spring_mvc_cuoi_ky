package com.cuoi_ky.repository;

import java.io.Serializable;
import java.util.List;
import java.util.Optional;

/**
 * Generic Repository Interface
 * Following Interface Segregation Principle (ISP)
 * @param <T> Entity type
 * @param <ID> ID type
 */
public interface BaseRepository<T, ID extends Serializable> {
    
    /**
     * Save or update entity
     */
    T save(T entity);
    
    /**
     * Find entity by ID
     */
    Optional<T> findById(ID id);
    
    /**
     * Find all entities
     */
    List<T> findAll();
    
    /**
     * Delete entity by ID
     */
    void deleteById(ID id);
    
    /**
     * Check if entity exists by ID
     */
    boolean existsById(ID id);
    
    /**
     * Count all entities
     */
    long count();
}
