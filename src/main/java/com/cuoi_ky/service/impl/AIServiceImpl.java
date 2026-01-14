package com.cuoi_ky.service.impl;

import com.cuoi_ky.service.AIService;
import com.google.genai.Client;
import com.google.genai.types.GenerateContentResponse;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

/**
 * Implementation của AIService sử dụng Google Gemini API
 */
@Service
public class AIServiceImpl implements AIService {

    @Value("${gemini.api.key}")
    private String apiKey;

    private Client client;

    @PostConstruct
    public void init() {
        if (apiKey == null || apiKey.isEmpty()) {
            throw new RuntimeException("API Key chưa được cấu hình");
        }

        client = Client.builder().apiKey(apiKey).build();
    }

    @Override
    public String generateResponse(String userMessage, String context) {
        try {
            // Xây dựng prompt system + context + user message
            String systemPrompt = "Bạn là một trợ lý ảo hỗ trợ học tiếng Nhật vui tính và hữu ích. " +
                    "Hãy trả lời câu hỏi của người dùng bằng tiếng Việt đan xen tiếng Nhật nếu cần thiết. " +
                    "Sử dụng thông tin ngữ cảnh được cung cấp bên dưới để trả lời chính xác hơn nếu có. " +
                    "Nếu ngữ cảnh không có thông tin, hãy dùng kiến thức của bạn để trả lời.";

            String finalPrompt = systemPrompt + "\n\n[Ngữ cảnh người học]\n" + context
                    + "\n\n[Câu hỏi của người dùng]\n" + userMessage;

            GenerateContentResponse response = client.models.generateContent(
                    "gemini-2.5-flash",
                    finalPrompt,
                    null);

            return response.text();

        } catch (Exception e) {
            e.printStackTrace();
            return "Đã xảy ra lỗi kết nối đến AI Service: " + e.getMessage();
        }
    }

    @PreDestroy
    public void shutdown() {
        if (client != null) {
            client.close();
        }
    }
}
