package com.cuoi_ky.controller;

import com.cuoi_ky.model.Vocabulary;
import com.cuoi_ky.dto.UserVocabularyDTO;
import com.cuoi_ky.model.Example;
import com.cuoi_ky.service.VocabularyService;
import com.cuoi_ky.service.ExampleService;
import com.cuoi_ky.service.UserVocabService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
        
        List<Vocabulary> vocabularies = null;
        
        if (query != null && !query.trim().isEmpty()) {
            String trimmedQuery = query.trim();
            // Search by type or all
            if (searchType != null && !searchType.equals("all")) {
                vocabularies = vocabularyService.searchByType(searchType, trimmedQuery);
            } else {
                vocabularies = vocabularyService.searchVocabularies(trimmedQuery);
            }
            model.addAttribute("query", trimmedQuery);
            model.addAttribute("results", vocabularies);
        } else {
            // If no query, show empty results
            model.addAttribute("results", null);
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
    public String myList(@RequestParam(value = "status", required = false) String status,
                         @RequestParam(value = "keyword", required = false) String keyword,
                         Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) return "redirect:/login";

        // Trường hợp ƯU TIÊN: Có từ khóa tìm kiếm
        if (keyword != null && !keyword.trim().isEmpty()) {
            List<UserVocabularyDTO> searchResults = userVocabService.searchMyList(userId, keyword.trim());
            model.addAttribute("vocabularies", searchResults);
            model.addAttribute("viewMode", "LIST");
            model.addAttribute("totalWords", searchResults.size());
            return "vocabulary/my-list";
        }

        // Trường hợp 2: Click vào thẻ Ôn tập / Ngủ đông
        if (status != null && !status.trim().isEmpty()) {
            List<UserVocabularyDTO> vocabList = userVocabService.getNotebookVocabulariesByStatus(userId, status);
            model.addAttribute("vocabularies", vocabList);
            model.addAttribute("currentStatus", status);
            model.addAttribute("viewMode", "LIST");
            model.addAttribute("totalWords", vocabList.size());
        } 
        // Trường hợp 3: Dashboard mặc định
        else {
            model.addAttribute("reviewCount", userVocabService.getReviewCount(userId));
            model.addAttribute("sleepCount", userVocabService.getSleepCount(userId));
            model.addAttribute("viewMode", "DASHBOARD");
        }

        return "vocabulary/my-list";
    }
    @PostMapping("/update-notebook-status")
    public String updateNotebookStatus(
            @RequestParam("currentStatus") String currentStatus,
            @RequestParam(value = "allIds", required = false) List<Integer> allIds,
            @RequestParam(value = "tickedIds", required = false) List<Integer> tickedIds,
            HttpSession session) {
        
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null || allIds == null) return "redirect:/login";

        if (tickedIds == null) tickedIds = new java.util.ArrayList<>();

        // US-3.5: Đang ở Ôn tập (active)
        if ("active".equals(currentStatus)) {
            for (Integer id : tickedIds) {
                // Lấy vocabId từ userVocabId hoặc update trực tiếp theo id của bảng user_vocab
                // Ở đây tôi giả định bạn có hàm update theo userVocabId hoặc dùng loop
                userVocabService.updateVocabularyStatusById(id, "sleep");
            }
        } 
        // US-3.6: Đang ở Ngủ đông (sleep)
        else if ("sleep".equals(currentStatus)) {
            for (Integer id : allIds) {
                // Nếu id nằm trong danh sách hiển thị nhưng KHÔNG nằm trong danh sách được tick
                // Nghĩa là người dùng đã bỏ chọn -> chuyển về active
                if (!tickedIds.contains(id)) {
                    userVocabService.updateVocabularyStatusById(id, "active");
                }
            }
        }

        return "redirect:/vocabulary/my-list?status=" + currentStatus;
    }

    @PostMapping("/toggle-list/{id}")
    @ResponseBody
    public ResponseEntity<java.util.Map<String, Object>> toggleVocabularyList(@PathVariable Integer id, 
                                                                               HttpSession session) {
        java.util.Map<String, Object> response = new java.util.HashMap<>();
        
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            response.put("success", false);
            response.put("message", "Vui lòng đăng nhập để sử dụng chức năng này");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }
        
        // Check if vocabulary exists
        Optional<Vocabulary> vocabOpt = vocabularyService.getVocabularyById(id);
        if (!vocabOpt.isPresent()) {
            response.put("success", false);
            response.put("message", "Từ vựng không tồn tại");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        }
        
        // Check if already in list
        boolean isInList = userVocabService.getUserVocab(userId, id).isPresent();
        
        try {
            if (isInList) {
                // Remove from list
                userVocabService.removeVocabularyFromUser(userId, id);
                response.put("success", true);
                response.put("inList", false);
                response.put("message", "Đã xóa từ khỏi sổ tay");
            } else {
                // Add to list
                userVocabService.addVocabularyToUser(userId, id);
                response.put("success", true);
                response.put("inList", true);
                response.put("message", "Đã thêm từ vào sổ tay");
            }
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Có lỗi xảy ra: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
}

