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
        int streak = statisticsService.getCurrentStreak(userId);
        double accuracy = statisticsService.getOverallAccuracy(userId);
        long totalWords = userVocabService.getTotalVocabularyCount(userId);
        
        model.addAttribute("streak", streak);
        model.addAttribute("accuracy", String.format("%.1f", accuracy));
        model.addAttribute("totalWords", totalWords);
        
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
        
        return "statistics/index";
    }
}

