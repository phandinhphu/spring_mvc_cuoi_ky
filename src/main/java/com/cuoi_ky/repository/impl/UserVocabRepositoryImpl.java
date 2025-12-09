package com.cuoi_ky.repository.impl;

import com.cuoi_ky.model.UserVocab;
import com.cuoi_ky.repository.UserVocabRepository;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

/**
 * UserVocab Repository Implementation
 */
@Repository
@Transactional
public class UserVocabRepositoryImpl extends BaseRepositoryImpl<UserVocab, Integer> 
        implements UserVocabRepository {

    @Override
    public List<UserVocab> findByUserId(Integer userId) {
        String hql = "FROM UserVocab uv WHERE uv.userId = :userId ORDER BY uv.addedAt DESC";
        Query<UserVocab> query = getSession().createQuery(hql, UserVocab.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }

    @Override
    public Optional<UserVocab> findByUserIdAndVocabId(Integer userId, Integer vocabId) {
        String hql = "FROM UserVocab uv WHERE uv.userId = :userId AND uv.vocabId = :vocabId";
        Query<UserVocab> query = getSession().createQuery(hql, UserVocab.class);
        query.setParameter("userId", userId);
        query.setParameter("vocabId", vocabId);
        return query.uniqueResultOptional();
    }

    @Override
    public List<UserVocab> findByUserIdAndStatus(Integer userId, String status) {
        String hql = "FROM UserVocab uv WHERE uv.userId = :userId AND uv.status = :status ORDER BY uv.addedAt DESC";
        Query<UserVocab> query = getSession().createQuery(hql, UserVocab.class);
        query.setParameter("userId", userId);
        query.setParameter("status", status);
        return query.getResultList();
    }

    @Override
    public long countByUserId(Integer userId) {
        String hql = "SELECT COUNT(uv) FROM UserVocab uv WHERE uv.userId = :userId";
        Query<Long> query = getSession().createQuery(hql, Long.class);
        query.setParameter("userId", userId);
        return query.getSingleResult();
    }

    @Override
    public long countByUserIdAndStatus(Integer userId, String status) {
        String hql = "SELECT COUNT(uv) FROM UserVocab uv WHERE uv.userId = :userId AND uv.status = :status";
        Query<Long> query = getSession().createQuery(hql, Long.class);
        query.setParameter("userId", userId);
        query.setParameter("status", status);
        return query.getSingleResult();
    }
}
