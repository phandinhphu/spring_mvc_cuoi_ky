package com.cuoi_ky.service;

/**
 * Service để giao tiếp với AI Provider (ví dụ Google Gemini)
 */
public interface AIService {

    /**
     * Sinh câu trả lời từ AI dựa trên tin nhắn và ngữ cảnh
     */
    String generateResponse(String userMessage, String context);
}
