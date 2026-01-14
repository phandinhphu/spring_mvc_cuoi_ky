package com.cuoi_ky.service.impl;

import com.atilika.kuromoji.ipadic.Token;
import com.atilika.kuromoji.ipadic.Tokenizer;
import com.cuoi_ky.dto.TranslationResponse;
import com.cuoi_ky.dto.WordTranslation;
import com.cuoi_ky.model.Vocabulary;
import com.cuoi_ky.service.TranslationService;
import com.cuoi_ky.service.VocabularyService;
import com.cuoi_ky.util.JapaneseUtils;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Translation Service Implementation
 * Xử lý dịch từ tiếng Nhật sang tiếng Việt
 * Sử dung API MyMemory (miễn phí) để dịch
 */
@Service
public class TranslationServiceImpl implements TranslationService {

    private final VocabularyService vocabularyService;
    private final Tokenizer tokenizer;
    private final OkHttpClient httpClient;
    private final ObjectMapper objectMapper;

    @Autowired
    public TranslationServiceImpl(VocabularyService vocabularyService) {
        this.vocabularyService = vocabularyService;
        this.tokenizer = new Tokenizer();
        this.httpClient = new OkHttpClient();
        this.objectMapper = new ObjectMapper();

        System.out.println("[TranslationService] Initialized with MyMemory API (Free)");
    }

    @Override
    public TranslationResponse translateAndProcess(String japaneseText, Integer userId) {
        TranslationResponse response = new TranslationResponse();

        try {
            // Validate input
            if (japaneseText == null || japaneseText.trim().isEmpty()) {
                response.setSuccess(false);
                response.setMessage("Text is empty");
                return response;
            }

            String normalizedText = JapaneseUtils.normalizeText(japaneseText);

            // Check if text contains Japanese
            if (!JapaneseUtils.isJapanese(normalizedText)) {
                response.setSuccess(false);
                response.setMessage("Text does not contain Japanese characters");
                return response;
            }

            // Tách từ
            List<String> tokens = tokenizeJapanese(normalizedText);

            // Xử lý từng từ
            List<WordTranslation> wordTranslations = new ArrayList<>();
            for (String token : tokens) {
                // Bỏ qua từ quá ngắn trừ khi là Kanji
                if (token.length() > 1 || JapaneseUtils.isKanji(token.charAt(0))) {
                    WordTranslation wt = getOrCreateVocabulary(token, userId);
                    if (wt != null) {
                        wordTranslations.add(wt);
                    }
                }
            }

            // Translate full text
            String fullTranslation = translateWord(normalizedText);

            response.setSuccess(true);
            response.setWords(wordTranslations);
            response.setFullTranslation(fullTranslation);
            response.setMessage("Translation successful");

        } catch (Exception e) {
            response.setSuccess(false);
            response.setMessage("Error: " + e.getMessage());
            e.printStackTrace();
        }

        return response;
    }

    @Override
    public List<String> tokenizeJapanese(String text) {
        List<Token> tokens = tokenizer.tokenize(text);
        return tokens.stream()
                .map(Token::getSurface)
                .filter(surface -> !surface.trim().isEmpty())
                .distinct()
                .collect(Collectors.toList());
    }

    @Override
    public String translateWord(String word) {
        try {
            // URL Encode the text
            String encodedText = URLEncoder.encode(word, StandardCharsets.UTF_8.toString());
            String textToTranslate = encodedText.replace("+", "%20"); // MyMemory prefers %20

            // Construct URL: https://api.mymemory.translated.net/get?q=TEXT&langpair=ja|vi
            String url = "https://api.mymemory.translated.net/get?q=" + textToTranslate + "&langpair=ja|vi";

            Request request = new Request.Builder()
                    .url(url)
                    .build();

            try (Response response = httpClient.newCall(request).execute()) {
                if (!response.isSuccessful()) {
                    System.err.println("MyMemory API error: " + response.code());
                    return "[Service Unavailable]";
                }

                String responseBody = response.body().string();
                JsonNode rootNode = objectMapper.readTree(responseBody);

                // MyMemory response structure: { "responseData": { "translatedText": "..." } }
                JsonNode responseData = rootNode.path("responseData");
                if (!responseData.isMissingNode()) {
                    String translatedText = responseData.path("translatedText").asText();
                    return translatedText;
                }

                return "[Translation Error]";
            }
        } catch (IOException e) {
            System.err.println("Translation network error: " + e.getMessage());
            return "[Network Error]";
        }
    }

    @Override
    public WordTranslation getOrCreateVocabulary(String word, Integer userId) {
        try {
            // Check if word exists in database
            Optional<Vocabulary> existingVocab = vocabularyService.findByWordExact(word);

            if (existingVocab.isPresent()) {
                // Word exists, return it
                Vocabulary vocab = existingVocab.get();
                return convertToWordTranslation(vocab, true);
            } else {
                // Word doesn't exist, create new entry
                String meaning = translateWord(word);

                Vocabulary newVocab = new Vocabulary();
                newVocab.setWord(word);
                newVocab.setMeaning(meaning);

                // Cố gắng lấy kana và romaji
                List<Token> tokens = tokenizer.tokenize(word);
                if (!tokens.isEmpty()) {
                    Token token = tokens.get(0);
                    String reading = token.getReading();
                    if (reading != null) {
                        newVocab.setHiragana(convertKatakanaToHiragana(reading));
                        newVocab.setRomaji(token.getBaseForm());
                    }
                }

                // Lấy Kanji nếu có
                String kanji = JapaneseUtils.extractKanji(word);
                if (!kanji.isEmpty()) {
                    newVocab.setKanji(kanji);
                }

                newVocab.setCreatedAt(new Date());
                newVocab.setUserId(userId);

                // Save to database
                Vocabulary savedVocab = vocabularyService.createVocabulary(newVocab);

                return convertToWordTranslation(savedVocab, false);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Convert Vocabulary entity to WordTranslation DTO
     */
    private WordTranslation convertToWordTranslation(Vocabulary vocab, boolean existsInDb) {
        WordTranslation wt = new WordTranslation();
        wt.setWord(vocab.getWord());
        wt.setMeaning(vocab.getMeaning());
        wt.setRomaji(vocab.getRomaji());
        wt.setHiragana(vocab.getHiragana());
        wt.setKatakana(vocab.getKatakana());
        wt.setKanji(vocab.getKanji());
        wt.setExistsInDb(existsInDb);
        wt.setVocabularyId(vocab.getId());
        return wt;
    }

    /**
     * Convert Katakana reading to Hiragana
     */
    private String convertKatakanaToHiragana(String katakana) {
        if (katakana == null)
            return null;

        StringBuilder hiragana = new StringBuilder();
        for (char c : katakana.toCharArray()) {
            if (c >= '\u30A1' && c <= '\u30F6') {
                // Convert Katakana to Hiragana
                hiragana.append((char) (c - 0x60));
            } else {
                hiragana.append(c);
            }
        }
        return hiragana.toString();
    }
}
