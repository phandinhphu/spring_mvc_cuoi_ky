package com.cuoi_ky.dto;

import java.util.List;

/**
 * DTO for translation API response to browser extension
 */
public class TranslationResponse {

    private boolean success;
    private String message;
    private List<WordTranslation> words;
    private String fullTranslation;

    public TranslationResponse() {
    }

    public TranslationResponse(boolean success, String message, List<WordTranslation> words, String fullTranslation) {
        this.success = success;
        this.message = message;
        this.words = words;
        this.fullTranslation = fullTranslation;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<WordTranslation> getWords() {
        return words;
    }

    public void setWords(List<WordTranslation> words) {
        this.words = words;
    }

    public String getFullTranslation() {
        return fullTranslation;
    }

    public void setFullTranslation(String fullTranslation) {
        this.fullTranslation = fullTranslation;
    }
}
