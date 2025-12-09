package com.cuoi_ky.service;

import com.cuoi_ky.model.QuizQuestion;
import java.util.List;

/**
 * Quiz Service Interface
 */
public interface QuizService {
    
    /**
     * Get random quiz questions
     */
    List<QuizQuestion> getRandomQuizQuestions(int limit);
    
    /**
     * Get questions by vocabulary ID
     */
    List<QuizQuestion> getQuestionsByVocabId(Integer vocabId);
    
    /**
     * Calculate quiz score
     */
    int calculateScore(List<Integer> questionIds, List<String> answers);
    
    /**
     * Get total questions count
     */
    long getTotalQuestionsCount();
}
