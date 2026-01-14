package com.cuoi_ky.service;

import com.cuoi_ky.dto.TranslationResponse;
import com.cuoi_ky.dto.WordTranslation;
import java.util.List;

/**
 * Translation Service Interface
 * Xử lý dịch thuật và quản lý từ vựng
 */
public interface TranslationService {

    /**
     * Dùng để dịch và xử lý văn bản tiếng Nhật
     * 
     * @param japaneseText - Japanese text to translate (word or sentence)
     * @param userId       - Optional user ID for tracking
     * @return TranslationResponse with word translations and full text translation
     */
    TranslationResponse translateAndProcess(String japaneseText, Integer userId);

    /**
     * Dùng để tách từ trong văn bản tiếng Nhật
     * 
     * @param text - Japanese text
     * @return List of tokenized words
     */
    List<String> tokenizeJapanese(String text);

    /**
     * Dịch một từ tiếng Nhật
     * 
     * @param word - Japanese word
     * @return Translated meaning
     */
    String translateWord(String word);

    /**
     * Lấy hoặc tạo mới từ vựng trong database
     * Nếu từ đã tồn tại, trả về bản dịch
     * Không thì tạo mới từ và trả về bản dịch
     * 
     * @param word   - Japanese word
     * @param userId - Optional user ID
     * @return WordTranslation DTO
     */
    WordTranslation getOrCreateVocabulary(String word, Integer userId);
}
