package com.cuoi_ky.repository;

import com.cuoi_ky.model.UserVocab;
import java.util.List;
import java.util.Optional;

/**
 * UserVocab Repository Interface
 */
public interface UserVocabRepository extends BaseRepository<UserVocab, Integer> {
    
    /**
     * Find all vocabularies by user ID
     */
    List<UserVocab> findByUserId(Integer userId);
    
    /**
     * Find user vocab by user ID and vocab ID
     */
    Optional<UserVocab> findByUserIdAndVocabId(Integer userId, Integer vocabId);
    
    /**
     * Find by user ID and status
     */
    List<UserVocab> findByUserIdAndStatus(Integer userId, String status);
    
    /**
     * Count vocabularies by user ID
     */
    long countByUserId(Integer userId);
    
    /**
     * Count vocabularies by user ID and status
     */
    long countByUserIdAndStatus(Integer userId, String status);
    
    /**
     * Find random vocabularies for a user
     */
    List<UserVocab> findRandomByUserId(Integer userId, int limit);
}
