package com.cuoi_ky.service.impl;

import com.cuoi_ky.model.UserVocab;
import com.cuoi_ky.model.Vocabulary;
import com.cuoi_ky.repository.UserVocabRepository;
import com.cuoi_ky.repository.VocabularyRepository;
import com.cuoi_ky.service.UserVocabService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

/**
 * UserVocab Service Implementation
 * Following Single Responsibility Principle
 */
@Service
@Transactional
public class UserVocabServiceImpl implements UserVocabService {

    private final UserVocabRepository userVocabRepository;
    private final VocabularyRepository vocabularyRepository;

    @Autowired
    public UserVocabServiceImpl(UserVocabRepository userVocabRepository,
                                VocabularyRepository vocabularyRepository) {
        this.userVocabRepository = userVocabRepository;
        this.vocabularyRepository = vocabularyRepository;
    }

    @Override
    public List<UserVocab> getUserVocabularyList(Integer userId) {
        return userVocabRepository.findByUserId(userId);
    }

    @Override
    public List<Vocabulary> getUserVocabulariesWithDetails(Integer userId) {
        List<UserVocab> userVocabs = userVocabRepository.findByUserId(userId);
        List<Vocabulary> vocabularies = new ArrayList<>();
        
        for (UserVocab userVocab : userVocabs) {
            Optional<Vocabulary> vocabOpt = vocabularyRepository.findById(userVocab.getVocabId());
            vocabOpt.ifPresent(vocabularies::add);
        }
        
        return vocabularies;
    }

    @Override
    public List<UserVocab> getUserVocabulariesByStatus(Integer userId, String status) {
        return userVocabRepository.findByUserIdAndStatus(userId, status);
    }

    @Override
    public UserVocab addVocabularyToUser(Integer userId, Integer vocabId) {
        // Check if already exists
        Optional<UserVocab> existing = userVocabRepository.findByUserIdAndVocabId(userId, vocabId);
        if (existing.isPresent()) {
            return existing.get();
        }
        
        // Create new user vocab
        UserVocab userVocab = new UserVocab();
        userVocab.setUserId(userId);
        userVocab.setVocabId(vocabId);
        userVocab.setStatus("learning");
        userVocab.setAddedAt(new Date());
        
        return userVocabRepository.save(userVocab);
    }

    @Override
    public UserVocab updateVocabularyStatus(Integer userId, Integer vocabId, String status) {
        Optional<UserVocab> userVocabOpt = userVocabRepository.findByUserIdAndVocabId(userId, vocabId);
        
        if (userVocabOpt.isPresent()) {
            UserVocab userVocab = userVocabOpt.get();
            userVocab.setStatus(status);
            return userVocabRepository.save(userVocab);
        }
        
        throw new RuntimeException("UserVocab not found for userId: " + userId + " and vocabId: " + vocabId);
    }

    @Override
    public Optional<UserVocab> getUserVocab(Integer userId, Integer vocabId) {
        return userVocabRepository.findByUserIdAndVocabId(userId, vocabId);
    }

    @Override
    public long getTotalVocabularyCount(Integer userId) {
        return userVocabRepository.countByUserId(userId);
    }

    @Override
    public long getMasteredCount(Integer userId) {
        return userVocabRepository.countByUserIdAndStatus(userId, "mastered");
    }

    @Override
    public long getLearningCount(Integer userId) {
        return userVocabRepository.countByUserIdAndStatus(userId, "learning");
    }
}
