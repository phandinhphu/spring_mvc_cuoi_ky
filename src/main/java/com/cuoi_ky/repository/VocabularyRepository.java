package com.cuoi_ky.repository;

import com.cuoi_ky.model.Vocabulary;
import java.util.List;

/**
 * Vocabulary Repository Interface
 * Following Interface Segregation Principle
 */
public interface VocabularyRepository extends BaseRepository<Vocabulary, Integer> {
    
    /**
     * Search vocabulary by keyword in word, meaning, hiragana, katakana, or kanji
     */
    List<Vocabulary> searchByKeyword(String keyword);
    
    /**
     * Find vocabulary by specific field
     */
    List<Vocabulary> findByWord(String word);
    List<Vocabulary> findByMeaning(String meaning);
    List<Vocabulary> findByHiragana(String hiragana);
    List<Vocabulary> findByKatakana(String katakana);
    List<Vocabulary> findByKanji(String kanji);
    List<Vocabulary> findByRomaji(String romaji);
    
    /**
     * Get random vocabularies for practice
     */
    List<Vocabulary> findRandomVocabularies(int limit);
}
