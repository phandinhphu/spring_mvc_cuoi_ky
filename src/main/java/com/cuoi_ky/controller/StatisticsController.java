package com.cuoi_ky.controller;

import com.cuoi_ky.service.StatisticsService;
import com.cuoi_ky.service.UserVocabService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Statistics Controller
 * Following Dependency Inversion Principle
 */
@Controller
@RequestMapping("/statistics")
public class StatisticsController {

    private final StatisticsService statisticsService;
    private final UserVocabService userVocabService;

    @Autowired
    public StatisticsController(StatisticsService statisticsService,
                               UserVocabService userVocabService) {
        this.statisticsService = statisticsService;
        this.userVocabService = userVocabService;
    }

    @GetMapping("/")
    public String statistics(Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        // Get real statistics from database
        int currentStreak = statisticsService.getCurrentStreak(userId);
        long totalWords = userVocabService.getTotalVocabularyCount(userId);
        long masteredWords = userVocabService.getMasteredCount(userId);
        double accuracy = totalWords > 0 ? (masteredWords * 100.0) / totalWords : 0;
        
        model.addAttribute("currentStreak", currentStreak);
        model.addAttribute("longestStreak", currentStreak); // Will track longest separately later
        model.addAttribute("totalWords", totalWords);
        model.addAttribute("learnedWords", masteredWords);
        model.addAttribute("accuracy", String.format("%.1f", accuracy));
        model.addAttribute("totalPracticeTime", 0); // Will track this later
        
        // Get weekly progress from database
        Map<String, Integer> weeklyData = statisticsService.getWeeklyProgress(userId);
        List<Map<String, Object>> weeklyProgress = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : weeklyData.entrySet()) {
            Map<String, Object> day = new HashMap<>();
            day.put("day", entry.getKey());
            day.put("words", entry.getValue());
            weeklyProgress.add(day);
        }
        model.addAttribute("weeklyProgress", weeklyProgress);
        
        // Get vocabulary distribution
        Map<String, Long> distribution = statisticsService.getVocabularyDistribution(userId);
        Map<String, Integer> practiceDistribution = new HashMap<>();
        practiceDistribution.put("Mastered", distribution.get("mastered").intValue());
        practiceDistribution.put("Learning", distribution.get("learning").intValue());
        practiceDistribution.put("Review", distribution.get("review").intValue());
        model.addAttribute("practiceDistribution", practiceDistribution);
        
        return "statistics/index";
    }
}

