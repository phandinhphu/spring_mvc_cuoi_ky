package com.cuoi_ky.controller;

import com.cuoi_ky.model.Vocabulary;
import com.cuoi_ky.service.VocabularyService;
import com.cuoi_ky.service.UserVocabService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

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
        
        List<Vocabulary> vocabs = userVocabService.getUserVocabulariesWithDetails(userId);
        
        if (vocabs.isEmpty()) {
            vocabs = vocabularyService.getRandomVocabularies(10);
        }
        
        model.addAttribute("vocabularies", vocabs);
        model.addAttribute("currentIndex", 0);
        model.addAttribute("score", 0);
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
}

