package com.cuoi_ky.repository;

import com.cuoi_ky.model.DailyStreak;
import java.util.Date;
import java.util.List;
import java.util.Optional;

/**
 * DailyStreak Repository Interface
 */
public interface DailyStreakRepository extends BaseRepository<DailyStreak, Integer> {
    
    /**
     * Find streak by user ID and date
     */
    Optional<DailyStreak> findByUserIdAndDate(Integer userId, Date date);
    
    /**
     * Find streaks by user ID
     */
    List<DailyStreak> findByUserId(Integer userId);
    
    /**
     * Find recent streaks by user ID
     */
    List<DailyStreak> findRecentByUserId(Integer userId, int days);
    
    /**
     * Calculate current streak for user
     */
    int calculateCurrentStreak(Integer userId);
}
