package com.cuoi_ky.service.impl;

import com.cuoi_ky.model.QuizQuestion;
import com.cuoi_ky.repository.QuizQuestionRepository;
import com.cuoi_ky.service.QuizService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

/**
 * Quiz Service Implementation
 * Following Single Responsibility Principle
 */
@Service
@Transactional
public class QuizServiceImpl implements QuizService {

    private final QuizQuestionRepository quizQuestionRepository;

    @Autowired
    public QuizServiceImpl(QuizQuestionRepository quizQuestionRepository) {
        this.quizQuestionRepository = quizQuestionRepository;
    }

    @Override
    public List<QuizQuestion> getRandomQuizQuestions(int limit) {
        return quizQuestionRepository.findRandomQuestions(limit);
    }

    @Override
    public List<QuizQuestion> getQuestionsByVocabId(Integer vocabId) {
        return quizQuestionRepository.findByVocabId(vocabId);
    }

    @Override
    public int calculateScore(List<Integer> questionIds, List<String> answers) {
        if (questionIds == null || answers == null || questionIds.size() != answers.size()) {
            return 0;
        }
        
        int correctCount = 0;
        
        for (int i = 0; i < questionIds.size(); i++) {
            Optional<QuizQuestion> questionOpt = quizQuestionRepository.findById(questionIds.get(i));
            
            if (questionOpt.isPresent()) {
                QuizQuestion question = questionOpt.get();
                if (question.getCorrectAnswer().equalsIgnoreCase(answers.get(i))) {
                    correctCount++;
                }
            }
        }
        
        return (int) Math.round((correctCount * 100.0) / questionIds.size());
    }

    @Override
    public long getTotalQuestionsCount() {
        return quizQuestionRepository.count();
    }
}
