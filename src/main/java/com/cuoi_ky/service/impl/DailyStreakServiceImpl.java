package com.cuoi_ky.service.impl;

import com.cuoi_ky.model.DailyStreak;
import com.cuoi_ky.repository.DailyStreakRepository;
import com.cuoi_ky.service.DailyStreakService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class DailyStreakServiceImpl implements DailyStreakService {
    
    private final DailyStreakRepository dailyStreakRepository;
    
    @Autowired
    public DailyStreakServiceImpl(DailyStreakRepository dailyStreakRepository) {
        this.dailyStreakRepository = dailyStreakRepository;
    }
    
    @Override
    public boolean recordPracticeToday(Integer userId, Integer wordsLearned) {
        Date today = getTodayDate();
        
        // Check if already practiced today
        Optional<DailyStreak> existingStreak = dailyStreakRepository.findByUserIdAndDate(userId, today);
        
        if (existingStreak.isPresent()) {
            // Already practiced today, just update the learned words count
            DailyStreak streak = existingStreak.get();
            streak.setLearnedWords(streak.getLearnedWords() + wordsLearned);
            dailyStreakRepository.update(streak);
            return false; // Already practiced, no new streak
        } else {
            // First practice of the day, create new streak
            DailyStreak newStreak = new DailyStreak();
            newStreak.setUserId(userId);
            newStreak.setDate(today);
            newStreak.setLearnedWords(wordsLearned);
            dailyStreakRepository.save(newStreak);
            return true; // New streak recorded
        }
    }
    
    /**
     * Get today's date with time set to 00:00:00
     */
    private Date getTodayDate() {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        return cal.getTime();
    }
}
