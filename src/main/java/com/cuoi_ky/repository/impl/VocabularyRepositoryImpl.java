package com.cuoi_ky.repository.impl;

import com.cuoi_ky.model.Vocabulary;
import com.cuoi_ky.repository.VocabularyRepository;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Vocabulary Repository Implementation
 * Following Single Responsibility Principle - handles only vocabulary data access
 */
@Repository
@Transactional
public class VocabularyRepositoryImpl extends BaseRepositoryImpl<Vocabulary, Integer> 
        implements VocabularyRepository {

    @Override
    public List<Vocabulary> searchByKeyword(String keyword) {
        String hql = "FROM Vocabulary v WHERE " +
                "LOWER(v.word) LIKE LOWER(:keyword) OR " +
                "LOWER(v.meaning) LIKE LOWER(:keyword) OR " +
                "LOWER(v.hiragana) LIKE LOWER(:keyword) OR " +
                "LOWER(v.katakana) LIKE LOWER(:keyword) OR " +
                "LOWER(v.kanji) LIKE LOWER(:keyword)";
        
        Query<Vocabulary> query = getSession().createQuery(hql, Vocabulary.class);
        query.setParameter("keyword", "%" + keyword + "%");
        return query.getResultList();
    }

    @Override
    public List<Vocabulary> findByWord(String word) {
        String hql = "FROM Vocabulary v WHERE LOWER(v.word) LIKE LOWER(:word)";
        Query<Vocabulary> query = getSession().createQuery(hql, Vocabulary.class);
        query.setParameter("word", "%" + word + "%");
        return query.getResultList();
    }

    @Override
    public List<Vocabulary> findByMeaning(String meaning) {
        String hql = "FROM Vocabulary v WHERE LOWER(v.meaning) LIKE LOWER(:meaning)";
        Query<Vocabulary> query = getSession().createQuery(hql, Vocabulary.class);
        query.setParameter("meaning", "%" + meaning + "%");
        return query.getResultList();
    }

    @Override
    public List<Vocabulary> findByHiragana(String hiragana) {
        String hql = "FROM Vocabulary v WHERE LOWER(v.hiragana) LIKE LOWER(:hiragana)";
        Query<Vocabulary> query = getSession().createQuery(hql, Vocabulary.class);
        query.setParameter("hiragana", "%" + hiragana + "%");
        return query.getResultList();
    }

    @Override
    public List<Vocabulary> findByKatakana(String katakana) {
        String hql = "FROM Vocabulary v WHERE LOWER(v.katakana) LIKE LOWER(:katakana)";
        Query<Vocabulary> query = getSession().createQuery(hql, Vocabulary.class);
        query.setParameter("katakana", "%" + katakana + "%");
        return query.getResultList();
    }

    @Override
    public List<Vocabulary> findByKanji(String kanji) {
        String hql = "FROM Vocabulary v WHERE LOWER(v.kanji) LIKE LOWER(:kanji)";
        Query<Vocabulary> query = getSession().createQuery(hql, Vocabulary.class);
        query.setParameter("kanji", "%" + kanji + "%");
        return query.getResultList();
    }

    @Override
    public List<Vocabulary> findRandomVocabularies(int limit) {
        String hql = "FROM Vocabulary v ORDER BY RAND()";
        Query<Vocabulary> query = getSession().createQuery(hql, Vocabulary.class);
        query.setMaxResults(limit);
        return query.getResultList();
    }
}
