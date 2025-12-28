package com.cuoi_ky.controller;

import com.cuoi_ky.dto.UserVocabularyDTO;
import com.cuoi_ky.model.PracticeHistory;
import com.cuoi_ky.model.Vocabulary;
import com.cuoi_ky.service.VocabularyService;
import com.cuoi_ky.service.DailyStreakService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

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
@Slf4j
public class PracticeController {

    private final VocabularyService vocabularyService;
    private final UserVocabService userVocabService;
    private final DailyStreakService dailyStreakService;

    @Autowired
    public PracticeController(VocabularyService vocabularyService,
                             UserVocabService userVocabService,
                             DailyStreakService dailyStreakService) {
        this.vocabularyService = vocabularyService;
        this.userVocabService = userVocabService;
        this.dailyStreakService = dailyStreakService;
    }

    @GetMapping("/")
    public String practice(Model model, HttpSession session) {
    	System.out.println("Accessing /practice/");
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
        List<UserVocabularyDTO> vocabs = userVocabService.getRandomUserVocabularies(userId, 10);
        
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
        
        List<UserVocabularyDTO> vocabs = userVocabService.getUserVocabulariesWithDetails(userId);
        
        if (vocabs.isEmpty()) {
            // If user has no vocabulary, use random ones
            List<Vocabulary> randomVocabs = vocabularyService.getRandomVocabularies(10);
            vocabs = new ArrayList<>();
            for (Vocabulary vocab : randomVocabs) {
                UserVocabularyDTO dto = new UserVocabularyDTO();
                dto.setVocabId(vocab.getId());
                dto.setUserVocabId(null); // Không có userVocabId vì chưa lưu
                dto.setWord(vocab.getWord());
                dto.setMeaning(vocab.getMeaning());
                dto.setRomaji(vocab.getRomaji());
                dto.setHiragana(vocab.getHiragana());
                dto.setKatakana(vocab.getKatakana());
                dto.setKanji(vocab.getKanji());
                dto.setAudioUrl(vocab.getAudioUrl());
                dto.setStatus("active");
                vocabs.add(dto);
            }
        }
        
        model.addAttribute("vocabularies", vocabs);
        model.addAttribute("currentIndex", 0);
        model.addAttribute("score", 0);
        return "practice/typing";
    }

    @GetMapping("/quiz")
    public String quiz(Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        List<Map<String, Object>> vocabularies = userVocabService.getUserActiveVocabulariesWithDetails(userId);
        List<Vocabulary> distractors = vocabularyService.getRandomVocabularies(100);
        
        model.addAttribute("vocabularies", vocabularies);
        model.addAttribute("distractors", distractors);
        return "practice/quiz";
    }
    
    @PostMapping("/save-result")
    public String saveResult(@RequestParam("resultsJson") String resultsJson, 
                             @RequestParam("totalScore") Integer totalScore, 
                             Model model, HttpSession session) {
        try {
            Integer userId = (Integer) session.getAttribute("userId");
            ObjectMapper mapper = new ObjectMapper();
            List<Map<String, Object>> results = mapper.readValue(resultsJson, 
                    new TypeReference<List<Map<String, Object>>>(){});
            
            // Lấy toàn bộ user vocabularies một lần
            List<UserVocabularyDTO> allUserVocabs = userVocabService.getUserVocabulariesWithDetails(userId);
            Map<Integer, UserVocabularyDTO> vocabMap = new java.util.HashMap<>();
            for (UserVocabularyDTO vocab : allUserVocabs) {
                vocabMap.put(vocab.getUserVocabId(), vocab);
            }
            
            List<PracticeHistory> historyToSave = new ArrayList<>();
            List<Map<String, Object>> detailedResults = new ArrayList<>();
            Date now = new Date(); // Thời điểm luyện tập
            
            int correctCount = 0;

            for (Map<String, Object> item : results) {
                PracticeHistory history = new PracticeHistory();
                
                // Trích xuất dữ liệu từ Map và ép kiểu về đúng loại
                Integer userVocabId = (Integer) item.get("userVocabId");
                Integer correct = (Integer) item.get("correctCount");
                Integer wrong = (Integer) item.get("wrongCount");
                String mode = (String) item.get("mode");
                
                history.setUserVocabId(userVocabId);
                history.setCorrectCount(correct);
                history.setWrongCount(wrong);
                history.setMode(mode);
                history.setPracticeDate(now);

                historyToSave.add(history);
                
                // Đếm số câu đúng
                if (correct > 0) {
                    correctCount++;
                }
                
                // Lấy thông tin từ vựng để hiển thị
                UserVocabularyDTO vocab = vocabMap.get(userVocabId);
                if (vocab != null) {
                    Map<String, Object> detailedItem = new java.util.HashMap<>();
                    detailedItem.put("word", vocab.getWord());
                    detailedItem.put("meaning", vocab.getMeaning());
                    detailedItem.put("romaji", vocab.getRomaji());
                    detailedItem.put("correctCount", correct);
                    detailedItem.put("wrongCount", wrong);
                    detailedResults.add(detailedItem);
                }
            }
            
            int totalItems = results.size();

            // Thực hiện lưu vào Database
            userVocabService.saveHistoryPractice(historyToSave);
            
            // Cập nhật daily streak (chỉ 1 lần trong ngày)
            boolean isNewStreak = dailyStreakService.recordPracticeToday(userId, totalItems);
            if (isNewStreak) {
                log.info("Daily streak recorded for user: {}", userId);
            }
            
            // Tính tỷ lệ chính xác dựa trên số câu đúng
            int percent = totalItems > 0 ? (correctCount * 100 / totalItems) : 0;
            
            model.addAttribute("score", correctCount);
            model.addAttribute("total", totalItems);
            model.addAttribute("percent", percent);
            model.addAttribute("results", detailedResults); 

            return "practice/result";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/practice/";
        }
    }
}

