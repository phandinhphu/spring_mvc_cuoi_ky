package com.cuoi_ky.repository;

import com.cuoi_ky.model.PracticeHistory;
import java.util.Date;
import java.util.List;

/**
 * PracticeHistory Repository Interface
 */
public interface PracticeHistoryRepository extends BaseRepository<PracticeHistory, Integer> {
    
    /**
     * Check user vocab practice history exists
     */
    boolean existsByUserVocabId(Integer userVocabId);

    /**
     * Get total correct count for a user vocab
     */
    int getCorrectCountByUserVocabId(Integer userVocabId);

    /**
     * Get total wrong count for a user vocab
     */
    int getWrongCountByUserVocabId(Integer userVocabId);

    /**
     * Find practice history by user vocab ID
     */
    PracticeHistory findByUserVocabId(Integer userVocabId);
    
    /**
     * Find practice history by user vocab ID and mode
     */
    PracticeHistory findByUserVocabIdAndMode(Integer userVocabId, String mode);
    
    /**
     * Find recent practice history
     */
    List<PracticeHistory> findRecentByUserVocabId(Integer userVocabId, int limit);
    
    /**
     * Find practice history by date range
     */
    List<PracticeHistory> findByDateRange(Date startDate, Date endDate);

    /**
     * Update practice history record correct_count
     */
    void updateCorrectCount(Integer userVocabId, int correctCount);

    /**
     * Update practice history record wrong_count
     */
    void updateWrongCount(Integer userVocabId, int wrongCount);
}
