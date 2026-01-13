package com.cuoi_ky.service;

import com.cuoi_ky.dto.TranslationResponse;
import com.cuoi_ky.dto.WordTranslation;
import java.util.List;

/**
 * Translation Service Interface
 * Handles Japanese text translation and vocabulary management
 */
public interface TranslationService {

    /**
     * Translate Japanese text and process vocabulary
     * 
     * @param japaneseText - Japanese text to translate (word or sentence)
     * @param userId       - Optional user ID for tracking
     * @return TranslationResponse with word translations and full text translation
     */
    TranslationResponse translateAndProcess(String japaneseText, Integer userId);

    /**
     * Tokenize Japanese text into words
     * 
     * @param text - Japanese text
     * @return List of tokenized words
     */
    List<String> tokenizeJapanese(String text);

    /**
     * Translate Japanese word to Vietnamese/English
     * 
     * @param word - Japanese word
     * @return Translated meaning
     */
    String translateWord(String word);

    /**
     * Get or create vocabulary entry
     * If word exists in database, return it
     * If not, translate and create new entry
     * 
     * @param word   - Japanese word
     * @param userId - Optional user ID
     * @return WordTranslation DTO
     */
    WordTranslation getOrCreateVocabulary(String word, Integer userId);
}
