package com.cuoi_ky.controller;

import com.cuoi_ky.model.Vocabulary;
import com.cuoi_ky.model.Example;
import com.cuoi_ky.service.VocabularyService;
import com.cuoi_ky.service.ExampleService;
import com.cuoi_ky.service.UserVocabService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;

/**
 * Vocabulary Controller
 * Following Dependency Inversion Principle - depends on service interfaces
 */
@Controller
@RequestMapping("/vocabulary")
public class VocabularyController {

    private final VocabularyService vocabularyService;
    private final ExampleService exampleService;
    private final UserVocabService userVocabService;

    @Autowired
    public VocabularyController(VocabularyService vocabularyService,
                               ExampleService exampleService,
                               UserVocabService userVocabService) {
        this.vocabularyService = vocabularyService;
        this.exampleService = exampleService;
        this.userVocabService = userVocabService;
    }

    @GetMapping("/search")
    public String search(@RequestParam(value = "q", required = false) String query,
                        @RequestParam(value = "type", required = false) String searchType,
                        Model model) {
        
        List<Vocabulary> vocabularies;
        
        if (query != null && !query.isEmpty()) {
            // Search by type or all
            if (searchType != null && !searchType.equals("all")) {
                vocabularies = vocabularyService.searchByType(searchType, query);
            } else {
                vocabularies = vocabularyService.searchVocabularies(query);
            }
            model.addAttribute("query", query);
            model.addAttribute("results", vocabularies);
        }
        
        model.addAttribute("searchType", searchType != null ? searchType : "all");
        return "vocabulary/search";
    }

    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Integer id, Model model, HttpSession session) {
        // Get vocabulary from database
        Optional<Vocabulary> vocabOpt = vocabularyService.getVocabularyById(id);
        
        if (!vocabOpt.isPresent()) {
            return "redirect:/vocabulary/search";
        }
        
        Vocabulary vocab = vocabOpt.get();
        List<Example> examples = exampleService.getExamplesByVocabId(id);
        
        // Check if vocabulary is in user's list
        Integer userId = (Integer) session.getAttribute("userId");
        boolean isInMyList = false;
        if (userId != null) {
            isInMyList = userVocabService.getUserVocab(userId, id).isPresent();
        }
        
        model.addAttribute("vocabulary", vocab);
        model.addAttribute("examples", examples);
        model.addAttribute("isInMyList", isInMyList);
        
        return "vocabulary/detail";
    }

    @GetMapping("/my-list")
    public String myList(Model model, HttpSession session) {
        // Get user ID from session - interceptor ensures user is logged in
        Integer userId = (Integer) session.getAttribute("userId");
        
        // Get user's vocabulary list with full details
        List<Vocabulary> myVocabs = userVocabService.getUserVocabulariesWithDetails(userId);
        
        model.addAttribute("vocabularies", myVocabs);
        model.addAttribute("totalWords", myVocabs.size());
        return "vocabulary/my-list";
    }
}

