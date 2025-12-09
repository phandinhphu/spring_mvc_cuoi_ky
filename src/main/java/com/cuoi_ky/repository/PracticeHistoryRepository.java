package com.cuoi_ky.repository;

import com.cuoi_ky.model.PracticeHistory;
import java.util.Date;
import java.util.List;

/**
 * PracticeHistory Repository Interface
 */
public interface PracticeHistoryRepository extends BaseRepository<PracticeHistory, Integer> {
    
    /**
     * Find practice history by user vocab ID
     */
    List<PracticeHistory> findByUserVocabId(Integer userVocabId);
    
    /**
     * Find practice history by user vocab ID and mode
     */
    List<PracticeHistory> findByUserVocabIdAndMode(Integer userVocabId, String mode);
    
    /**
     * Find recent practice history
     */
    List<PracticeHistory> findRecentByUserVocabId(Integer userVocabId, int limit);
    
    /**
     * Find practice history by date range
     */
    List<PracticeHistory> findByDateRange(Date startDate, Date endDate);
}
