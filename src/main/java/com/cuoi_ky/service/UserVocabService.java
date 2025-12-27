package com.cuoi_ky.service;

import com.cuoi_ky.dto.UserVocabularyDTO;
import com.cuoi_ky.model.PracticeHistory;
import com.cuoi_ky.model.UserVocab;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * UserVocab Service Interface
 */
public interface UserVocabService {
    
    /**
     * Get user's vocabulary list
     */
    List<UserVocab> getUserVocabularyList(Integer userId);
    
    /**
     * Get user's vocabulary list with full vocabulary details
     */
    List<UserVocabularyDTO> getUserVocabulariesWithDetails(Integer userId);
    
    /**
     * Get user vocabularies by status
     */
    List<UserVocab> getUserVocabulariesByStatus(Integer userId, String status);
    
    /**
     * Add vocabulary to user's list
     */
    UserVocab addVocabularyToUser(Integer userId, Integer vocabId);
    
    /**
     * Remove vocabulary from user's list
     */
    void removeVocabularyFromUser(Integer userId, Integer vocabId);
    
    /**
     * Update vocabulary status
     */
    UserVocab updateVocabularyStatus(Integer userId, Integer vocabId, String status);
    
    /**
     * Get user vocab by user ID and vocab ID
     */
    Optional<UserVocab> getUserVocab(Integer userId, Integer vocabId);
    
    /**
     * Get statistics
     */
    long getTotalVocabularyCount(Integer userId);
    long getMasteredCount(Integer userId);
    long getLearningCount(Integer userId);
    
    /**
     * Get user vocabularies by active status, return detail list vocabularies
     */
    List<Map<String, Object>> getUserActiveVocabulariesWithDetails(Integer userId);
    
    /**
     * save history practice
     */
    public void saveHistoryPractice(List<PracticeHistory> histories);
    
    /**
     * Get random user vocabularies (10)
     */
    List<UserVocabularyDTO> getRandomUserVocabularies(Integer userId, int limit);
    
    /**
     * Các hàm dành riêng cho Epic 3: Sổ tay lưu từ
     */
    long getReviewCount(Integer userId); // Đếm từ 'active' (Ôn tập)
    long getSleepCount(Integer userId);  // Đếm từ 'sleep' (Ngủ đông)
    List<UserVocabularyDTO> getNotebookVocabulariesByStatus(Integer userId, String status); // Lấy danh sách theo status
    void updateVocabularyStatusById(Integer userVocabId, String status);
    List<UserVocabularyDTO> searchMyList(Integer userId, String keyword);
}
