package com.cuoi_ky.repository.impl;

import com.cuoi_ky.model.PracticeHistory;
import com.cuoi_ky.repository.PracticeHistoryRepository;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * PracticeHistory Repository Implementation
 */
@Repository
@Transactional
public class PracticeHistoryRepositoryImpl extends BaseRepositoryImpl<PracticeHistory, Integer> 
        implements PracticeHistoryRepository {

    @Override
    public List<PracticeHistory> findByUserVocabId(Integer userVocabId) {
        String hql = "FROM PracticeHistory ph WHERE ph.userVocabId = :userVocabId ORDER BY ph.practiceDate DESC";
        Query<PracticeHistory> query = getSession().createQuery(hql, PracticeHistory.class);
        query.setParameter("userVocabId", userVocabId);
        return query.getResultList();
    }

    @Override
    public List<PracticeHistory> findByUserVocabIdAndMode(Integer userVocabId, String mode) {
        String hql = "FROM PracticeHistory ph WHERE ph.userVocabId = :userVocabId AND ph.mode = :mode ORDER BY ph.practiceDate DESC";
        Query<PracticeHistory> query = getSession().createQuery(hql, PracticeHistory.class);
        query.setParameter("userVocabId", userVocabId);
        query.setParameter("mode", mode);
        return query.getResultList();
    }

    @Override
    public List<PracticeHistory> findRecentByUserVocabId(Integer userVocabId, int limit) {
        String hql = "FROM PracticeHistory ph WHERE ph.userVocabId = :userVocabId ORDER BY ph.practiceDate DESC";
        Query<PracticeHistory> query = getSession().createQuery(hql, PracticeHistory.class);
        query.setParameter("userVocabId", userVocabId);
        query.setMaxResults(limit);
        return query.getResultList();
    }

    @Override
    public List<PracticeHistory> findByDateRange(Date startDate, Date endDate) {
        String hql = "FROM PracticeHistory ph WHERE ph.practiceDate BETWEEN :startDate AND :endDate ORDER BY ph.practiceDate DESC";
        Query<PracticeHistory> query = getSession().createQuery(hql, PracticeHistory.class);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
        return query.getResultList();
    }
}
