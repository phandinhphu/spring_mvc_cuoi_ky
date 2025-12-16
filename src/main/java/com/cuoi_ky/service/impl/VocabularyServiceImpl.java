package com.cuoi_ky.service.impl;

import com.cuoi_ky.model.Vocabulary;
import com.cuoi_ky.repository.VocabularyRepository;
import com.cuoi_ky.service.VocabularyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

/**
 * Vocabulary Service Implementation
 * Following Single Responsibility Principle - handles only business logic for vocabulary
 * Following Dependency Inversion Principle - depends on VocabularyRepository interface
 */
@Service
@Transactional
public class VocabularyServiceImpl implements VocabularyService {

    private final VocabularyRepository vocabularyRepository;

    @Autowired
    public VocabularyServiceImpl(VocabularyRepository vocabularyRepository) {
        this.vocabularyRepository = vocabularyRepository;
    }

    @Override
    public List<Vocabulary> getAllVocabularies() {
        return vocabularyRepository.findAll();
    }

    @Override
    public Optional<Vocabulary> getVocabularyById(Integer id) {
        return vocabularyRepository.findById(id);
    }

    @Override
    public List<Vocabulary> searchVocabularies(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllVocabularies();
        }
        return vocabularyRepository.searchByKeyword(keyword.trim());
    }

    @Override
    public List<Vocabulary> searchByType(String type, String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllVocabularies();
        }
        
        String cleanKeyword = keyword.trim();
        
        switch (type.toLowerCase()) {
            case "word":
                return vocabularyRepository.findByWord(cleanKeyword);
            case "meaning":
                return vocabularyRepository.findByMeaning(cleanKeyword);
            case "hiragana":
                return vocabularyRepository.findByHiragana(cleanKeyword);
            case "katakana":
                return vocabularyRepository.findByKatakana(cleanKeyword);
            case "kanji":
                return vocabularyRepository.findByKanji(cleanKeyword);
            case "romaji":
                return vocabularyRepository.findByRomaji(cleanKeyword);
            default:
                return vocabularyRepository.searchByKeyword(cleanKeyword);
        }
    }

    @Override
    public List<Vocabulary> getRandomVocabularies(int limit) {
        return vocabularyRepository.findRandomVocabularies(limit);
    }

    @Override
    public Vocabulary saveVocabulary(Vocabulary vocabulary) {
        return vocabularyRepository.save(vocabulary);
    }

    @Override
    public long getTotalCount() {
        return vocabularyRepository.count();
    }
}
