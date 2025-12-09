package com.cuoi_ky.service;

import com.cuoi_ky.model.Vocabulary;
import java.util.List;
import java.util.Optional;

/**
 * Vocabulary Service Interface
 * Following Interface Segregation Principle
 */
public interface VocabularyService {
    
    /**
     * Get all vocabularies
     */
    List<Vocabulary> getAllVocabularies();
    
    /**
     * Get vocabulary by ID
     */
    Optional<Vocabulary> getVocabularyById(Integer id);
    
    /**
     * Search vocabularies by keyword
     */
    List<Vocabulary> searchVocabularies(String keyword);
    
    /**
     * Search by specific type
     */
    List<Vocabulary> searchByType(String type, String keyword);
    
    /**
     * Get random vocabularies for practice
     */
    List<Vocabulary> getRandomVocabularies(int limit);
    
    /**
     * Save vocabulary
     */
    Vocabulary saveVocabulary(Vocabulary vocabulary);
    
    /**
     * Get total vocabulary count
     */
    long getTotalCount();
}
