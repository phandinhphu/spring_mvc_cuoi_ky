package com.cuoi_ky.controller;

import com.cuoi_ky.model.PracticeHistory;
import com.cuoi_ky.model.Vocabulary;
import com.cuoi_ky.service.VocabularyService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.cuoi_ky.service.UserVocabService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Practice Controller
 * Following Dependency Inversion Principle
 */
@Controller
@RequestMapping("/practice")
public class PracticeController {

    private final VocabularyService vocabularyService;
    private final UserVocabService userVocabService;

    @Autowired
    public PracticeController(VocabularyService vocabularyService,
                             UserVocabService userVocabService) {
        this.vocabularyService = vocabularyService;
        this.userVocabService = userVocabService;
    }

    @GetMapping("/")
    public String practice(Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        long totalWords = userVocabService.getTotalVocabularyCount(userId);
        model.addAttribute("totalWords", totalWords);
        model.addAttribute("todayPracticed", 0); // Will track this later
        return "practice/index";
    }

    @GetMapping("/flashcard")
    public String flashcard(@RequestParam(value = "mode", required = false) String mode, 
                           Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        // Get user's vocabulary or random vocabs for practice
        List<Vocabulary> vocabs = userVocabService.getUserVocabulariesWithDetails(userId);
        
        if (vocabs.isEmpty()) {
            // If user has no vocabulary, use random ones
            vocabs = vocabularyService.getRandomVocabularies(10);
        }
        
        model.addAttribute("vocabularies", vocabs);
        model.addAttribute("currentIndex", 0);
        model.addAttribute("totalCards", vocabs.size());
        model.addAttribute("mode", mode != null ? mode : "meaning");
        return "practice/flashcard";
    }

    @GetMapping("/listening")
    public String listening(Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        List<Map<String, Object>> vocabularies = userVocabService.getUserActiveVocabulariesWithDetails(userId);
        List<Vocabulary> distractors = vocabularyService.getRandomVocabularies(100);
        
        model.addAttribute("vocabularies", vocabularies);
        model.addAttribute("distractors", distractors);
        return "practice/listening";
    }

    @GetMapping("/typing")
    public String typing(Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        List<Vocabulary> vocabs = userVocabService.getUserVocabulariesWithDetails(userId);
        
        if (vocabs.isEmpty()) {
            vocabs = vocabularyService.getRandomVocabularies(10);
        }
        
        model.addAttribute("vocabularies", vocabs);
        model.addAttribute("currentIndex", 0);
        model.addAttribute("score", 0);
        return "practice/typing";
    }
    
    @PostMapping("/save-result")
    public String saveResult(@RequestParam("resultsJson") String resultsJson, 
                             @RequestParam("totalScore") Integer totalScore, 
                             Model model) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            List<Map<String, Object>> results = mapper.readValue(resultsJson, 
                    new TypeReference<List<Map<String, Object>>>(){});
            
            List<PracticeHistory> historyToSave = new ArrayList<>();
            Date now = new Date(); // Thời điểm luyện tập

            for (Map<String, Object> item : results) {
                PracticeHistory history = new PracticeHistory();
                
                // Trích xuất dữ liệu từ Map và ép kiểu về đúng loại
                history.setUserVocabId((Integer) item.get("userVocabId"));
                history.setCorrectCount((Integer) item.get("correctCount"));
                history.setWrongCount((Integer) item.get("wrongCount"));
                history.setMode((String) item.get("mode"));
                history.setPracticeDate(now);

                historyToSave.add(history);
            }
            
            int totalItems = results.size();

            // Thực hiện lưu vào Database
            userVocabService.saveHistoryPractice(historyToSave);
            
            model.addAttribute("score", totalScore);
            model.addAttribute("total", totalItems);
            model.addAttribute("percent", (int)(totalScore*100/totalItems));
            model.addAttribute("results", results); 

            return "practice/result";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/practice/";
        }
    }
}

