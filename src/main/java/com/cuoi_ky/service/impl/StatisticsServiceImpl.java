package com.cuoi_ky.service.impl;

import com.cuoi_ky.model.DailyStreak;
import com.cuoi_ky.model.UserVocab;
import com.cuoi_ky.repository.DailyStreakRepository;
import com.cuoi_ky.repository.PracticeHistoryRepository;
import com.cuoi_ky.repository.UserVocabRepository;
import com.cuoi_ky.service.StatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Statistics Service Implementation
 * Following Single Responsibility Principle
 */
@Service
@Transactional
public class StatisticsServiceImpl implements StatisticsService {

    private final DailyStreakRepository dailyStreakRepository;
    private final UserVocabRepository userVocabRepository;
    private final PracticeHistoryRepository practiceHistoryRepository;

    @Autowired
    public StatisticsServiceImpl(DailyStreakRepository dailyStreakRepository,
                                 UserVocabRepository userVocabRepository,
                                 PracticeHistoryRepository practiceHistoryRepository) {
        this.dailyStreakRepository = dailyStreakRepository;
        this.userVocabRepository = userVocabRepository;
        this.practiceHistoryRepository = practiceHistoryRepository;
    }

    @Override
    public List<DailyStreak> getDailyStreaks(Integer userId) {
        return dailyStreakRepository.findByUserId(userId);
    }

    @Override
    public List<DailyStreak> getRecentStreaks(Integer userId, int days) {
        return dailyStreakRepository.findRecentByUserId(userId, days);
    }

    @Override
    public DailyStreak recordDailyLearning(Integer userId, int learnedWords) {
        Date today = new Date();
        Optional<DailyStreak> existingOpt = dailyStreakRepository.findByUserIdAndDate(userId, today);
        
        DailyStreak streak;
        if (existingOpt.isPresent()) {
            streak = existingOpt.get();
            streak.setLearnedWords(streak.getLearnedWords() + learnedWords);
        } else {
            streak = new DailyStreak();
            streak.setUserId(userId);
            streak.setDate(today);
            streak.setLearnedWords(learnedWords);
        }
        
        return dailyStreakRepository.save(streak);
    }

    @Override
    public int getCurrentStreak(Integer userId) {
        return dailyStreakRepository.calculateCurrentStreak(userId);
    }

    @Override
    public Map<String, Integer> getWeeklyProgress(Integer userId) {
        Map<String, Integer> weeklyData = new LinkedHashMap<>();
        List<DailyStreak> recentStreaks = dailyStreakRepository.findRecentByUserId(userId, 7);
        
        SimpleDateFormat sdf = new SimpleDateFormat("EEE");
        Calendar cal = Calendar.getInstance();
        
        // Initialize last 7 days with 0
        for (int i = 6; i >= 0; i--) {
            cal.setTime(new Date());
            cal.add(Calendar.DAY_OF_MONTH, -i);
            String dayName = sdf.format(cal.getTime());
            weeklyData.put(dayName, 0);
        }
        
        // Fill with actual data
        for (DailyStreak streak : recentStreaks) {
            String dayName = sdf.format(streak.getDate());
            weeklyData.put(dayName, streak.getLearnedWords());
        }
        
        return weeklyData;
    }

    @Override
    public Map<String, Long> getVocabularyDistribution(Integer userId) {
        Map<String, Long> distribution = new HashMap<>();
        
        long masteredCount = userVocabRepository.countByUserIdAndStatus(userId, "mastered");
        long learningCount = userVocabRepository.countByUserIdAndStatus(userId, "learning");
        long reviewCount = userVocabRepository.countByUserIdAndStatus(userId, "review");
        
        distribution.put("mastered", masteredCount);
        distribution.put("learning", learningCount);
        distribution.put("review", reviewCount);
        
        return distribution;
    }
    
    @Override
    public double getOverallAccuracy(Integer userId) {
        Object[] results = practiceHistoryRepository.getTotalCorrectAndWrong(userId);
        
        // results[0] là tổng đúng, results[1] là tổng sai
        long correct = (results[0] != null) ? (long) results[0] : 0;
        long wrong = (results[1] != null) ? (long) results[1] : 0;
        long total = correct + wrong;

        if (total == 0) {
            return 0.0;
        }

        return (double) correct / total * 100;
    }
}
