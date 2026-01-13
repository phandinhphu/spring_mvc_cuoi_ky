package com.cuoi_ky.dto;

/**
 * DTO for translation API request from browser extension
 */
public class TranslationRequest {

    private String text;
    private Integer userId; // Optional, for tracking user if logged in

    public TranslationRequest() {
    }

    public TranslationRequest(String text, Integer userId) {
        this.text = text;
        this.userId = userId;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
}
