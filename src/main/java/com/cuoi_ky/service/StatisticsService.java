package com.cuoi_ky.service;

import com.cuoi_ky.dto.RecentPracticeDTO;
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
     * Get total accuracy statistics (of all practiced vocabularies)
     */
    Double getTotalAccuracy(Integer userId);
    
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
     * 
     * Caculate percent
     */
	double getOverallAccuracy(Integer userId);
	
	/**
	 * Get count mode practice
	 */
	Map<String, Long> getPracticeModeDistribution(Integer userId);
	
	/**
	 * Get recent practice history
	 */
	List<RecentPracticeDTO> getRecentPracticeHistory(Integer userId);
}
