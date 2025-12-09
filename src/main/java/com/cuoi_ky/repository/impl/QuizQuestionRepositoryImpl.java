package com.cuoi_ky.repository.impl;

import com.cuoi_ky.model.QuizQuestion;
import com.cuoi_ky.repository.QuizQuestionRepository;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * QuizQuestion Repository Implementation
 */
@Repository
@Transactional
public class QuizQuestionRepositoryImpl extends BaseRepositoryImpl<QuizQuestion, Integer> 
        implements QuizQuestionRepository {

    @Override
    public List<QuizQuestion> findByVocabId(Integer vocabId) {
        String hql = "FROM QuizQuestion q WHERE q.vocabId = :vocabId";
        Query<QuizQuestion> query = getSession().createQuery(hql, QuizQuestion.class);
        query.setParameter("vocabId", vocabId);
        return query.getResultList();
    }

    @Override
    public List<QuizQuestion> findRandomQuestions(int limit) {
        String hql = "FROM QuizQuestion q ORDER BY RAND()";
        Query<QuizQuestion> query = getSession().createQuery(hql, QuizQuestion.class);
        query.setMaxResults(limit);
        return query.getResultList();
    }
}
