package com.cuoi_ky.controller;

import com.cuoi_ky.service.StatisticsService;
import com.cuoi_ky.service.UserVocabService;
import com.cuoi_ky.service.VocabularyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

/**
 * Home Controller
 * Following Dependency Inversion Principle - depends on service interfaces
 */
@Controller
public class HomeController {

    private final VocabularyService vocabularyService;
    private final UserVocabService userVocabService;
    private final StatisticsService statisticsService;

    @Autowired
    public HomeController(VocabularyService vocabularyService,
                         UserVocabService userVocabService,
                         StatisticsService statisticsService) {
        this.vocabularyService = vocabularyService;
        this.userVocabService = userVocabService;
        this.statisticsService = statisticsService;
    }

    @GetMapping("/")
    public String home(Model model) {
        // Landing page - no authentication required
        model.addAttribute("totalVocab", vocabularyService.getTotalCount());
        return "index";
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        // Get user ID from session - interceptor ensures user is logged in
        Integer userId = (Integer) session.getAttribute("userId");
        String username = (String) session.getAttribute("username");
        
        // Get real statistics from database
        long totalWords = userVocabService.getTotalVocabularyCount(userId);
        long masteredWords = userVocabService.getMasteredCount(userId);
        int currentStreak = statisticsService.getCurrentStreak(userId);
        
        // Calculate accuracy
        double accuracy = totalWords > 0 ? (masteredWords * 100.0) / totalWords : 0;
        
        model.addAttribute("username", username); // Will get from User entity later
        model.addAttribute("streak", currentStreak);
        model.addAttribute("totalWords", totalWords);
        model.addAttribute("learnedWords", masteredWords);
        model.addAttribute("accuracy", String.format("%.1f", accuracy));
        
        return "dashboard/index";
    }
}

