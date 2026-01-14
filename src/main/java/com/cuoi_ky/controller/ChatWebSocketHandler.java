package com.cuoi_ky.controller;

import com.cuoi_ky.service.AIService;
import com.cuoi_ky.service.RAGService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;

/**
 * WebSocket Handler xử lý tin nhắn chat từ người dùng
 */
@Component
public class ChatWebSocketHandler extends TextWebSocketHandler {

    @Autowired
    private RAGService ragService;

    @Autowired
    private AIService aiService;

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) throws IOException {
        String userMessage = message.getPayload();

        try {
            // 1. Lấy context từ database (RAG)
            String context = ragService.findContext(userMessage);

            // 2. Gọi AI để sinh câu trả lời
            String aiResponse = aiService.generateResponse(userMessage, context);

            // 3. Gửi câu trả lời về cho client
            session.sendMessage(new TextMessage(aiResponse));

        } catch (Exception e) {
            e.printStackTrace();
            session.sendMessage(new TextMessage("Đã xảy ra lỗi hệ thống: " + e.getMessage()));
        }
    }
}
