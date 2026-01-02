package com.cuoi_ky.service;

import com.cuoi_ky.model.DailyStreak;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Statistics Service Interface
 */
public interface StatisticsService {
    
    /**
     * Get user's daily streaks
     */
    List<DailyStreak> getDailyStreaks(Integer userId);
    
    /**
     * Get recent daily streaks
     */
    List<DailyStreak> getRecentStreaks(Integer userId, int days);
    
    /**
     * Record daily learning
     */
    DailyStreak recordDailyLearning(Integer userId, int learnedWords);
    
    /**
     * Calculate current streak
     */
    int getCurrentStreak(Integer userId);
    
    /**
     * Get weekly progress data
     */
    Map<String, Integer> getWeeklyProgress(Integer userId);
    
    /**
     * Get vocabulary distribution by status
     */
    Map<String, Long> getVocabularyDistribution(Integer userId);

    /**
     * 
     * Caculate percent
     */
	double getOverallAccuracy(Integer userId);
}
