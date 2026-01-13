package com.cuoi_ky.controller;

import com.cuoi_ky.dto.TranslationRequest;
import com.cuoi_ky.dto.TranslationResponse;
import com.cuoi_ky.service.TranslationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

/**
 * Translation API Controller for Browser Extension
 * Handles translation requests from the Japanese learning extension
 */
@RestController
@RequestMapping("/api/translate")
@CrossOrigin(origins = "*", allowedHeaders = "*") // Allow CORS for extension
public class TranslationController {

    private final TranslationService translationService;

    @Autowired
    public TranslationController(TranslationService translationService) {
        this.translationService = translationService;
    }

    /**
     * Translate Japanese text endpoint
     * POST /api/translate
     * Request body: { "text": "日本語", "userId": 123 }
     * Response: { "success": true, "words": [...], "fullTranslation": "..." }
     */
    @PostMapping(produces = org.springframework.http.MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<TranslationResponse> translate(
            @RequestBody TranslationRequest request,
            HttpSession session) {

        try {
            // Get user ID from request or session
            Integer userId = request.getUserId();
            if (userId == null) {
                userId = (Integer) session.getAttribute("userId");
            }

            // Process translation
            TranslationResponse response = translationService.translateAndProcess(
                    request.getText(),
                    userId);

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            e.printStackTrace();
            TranslationResponse errorResponse = new TranslationResponse();
            errorResponse.setSuccess(false);
            errorResponse.setMessage("Server error: " + e.getMessage());
            return ResponseEntity.status(500).body(errorResponse);
        }
    }

    /**
     * Health check endpoint for extension
     */
    @GetMapping("/health")
    public ResponseEntity<String> health() {
        return ResponseEntity.ok("{\"status\":\"ok\"}");
    }
}
