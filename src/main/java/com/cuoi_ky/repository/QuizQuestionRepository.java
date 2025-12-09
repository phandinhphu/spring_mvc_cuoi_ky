package com.cuoi_ky.repository;

import com.cuoi_ky.model.QuizQuestion;
import java.util.List;

/**
 * QuizQuestion Repository Interface
 */
public interface QuizQuestionRepository extends BaseRepository<QuizQuestion, Integer> {
    
    /**
     * Find questions by vocabulary ID
     */
    List<QuizQuestion> findByVocabId(Integer vocabId);
    
    /**
     * Get random questions for quiz
     */
    List<QuizQuestion> findRandomQuestions(int limit);
}
