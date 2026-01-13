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
     * Search by specific type (word, meaning, hiragana, katakana, kanji, romaji)
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

    /**
     * Find vocabulary by exact word match (for translation extension)
     */
    Optional<Vocabulary> findByWordExact(String word);

    /**
     * Create new vocabulary (for translation extension)
     */
    Vocabulary createVocabulary(Vocabulary vocabulary);
}
