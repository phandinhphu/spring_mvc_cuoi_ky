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
    public boolean existsByUserVocabId(Integer userVocabId) {
        String hql = "SELECT COUNT(ph.id) FROM PracticeHistory ph WHERE ph.userVocabId = :userVocabId";
        Query<Long> query = getSession().createQuery(hql, Long.class);
        query.setParameter("userVocabId", userVocabId);
        Long count = query.uniqueResult();
        return count != null && count > 0;
    }

    @Override
    public int getCorrectCountByUserVocabId(Integer userVocabId) {
        String hql = "SELECT ph.correctCount FROM PracticeHistory ph WHERE ph.userVocabId = :userVocabId";
        Query<Integer> query = getSession().createQuery(hql, Integer.class);
        query.setParameter("userVocabId", userVocabId);
        Integer totalCorrect = query.uniqueResult();
        return totalCorrect != null ? totalCorrect.intValue() : 0;
    }

    @Override
    public int getWrongCountByUserVocabId(Integer userVocabId) {
        String hql = "SELECT ph.wrongCount FROM PracticeHistory ph WHERE ph.userVocabId = :userVocabId";
        Query<Integer> query = getSession().createQuery(hql, Integer.class);
        query.setParameter("userVocabId", userVocabId);
        Integer totalWrong = query.uniqueResult();
        return totalWrong != null ? totalWrong.intValue() : 0;
    }

    @Override
    public PracticeHistory findByUserVocabId(Integer userVocabId) {
        String hql = "FROM PracticeHistory ph WHERE ph.userVocabId = :userVocabId ORDER BY ph.practiceDate DESC";
        Query<PracticeHistory> query = getSession().createQuery(hql, PracticeHistory.class);
        query.setParameter("userVocabId", userVocabId);
        return query.uniqueResult();
    }

    @Override
    public PracticeHistory findByUserVocabIdAndMode(Integer userVocabId, String mode) {
        String hql = "FROM PracticeHistory ph WHERE ph.userVocabId = :userVocabId AND ph.mode = :mode ORDER BY ph.practiceDate DESC";
        Query<PracticeHistory> query = getSession().createQuery(hql, PracticeHistory.class);
        query.setParameter("userVocabId", userVocabId);
        query.setParameter("mode", mode);
        return query.uniqueResult();
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

    @Override
    public void updateCorrectCount(Integer userVocabId, int correctCount) {
        String hql = "UPDATE PracticeHistory ph SET " +
        "ph.correctCount = :correctCount, " +
        "ph.practiceDate = CURRENT_TIMESTAMP " +
        "WHERE ph.userVocabId = :userVocabId";
        Query<?> query = getSession().createQuery(hql);
        query.setParameter("correctCount", correctCount);
        query.setParameter("userVocabId", userVocabId);
        query.executeUpdate();
    }

    @Override
    public void updateWrongCount(Integer userVocabId, int wrongCount) {
        String hql = "UPDATE PracticeHistory ph SET " +
        "ph.wrongCount = :wrongCount, " +
        "ph.practiceDate = CURRENT_TIMESTAMP " +
        "WHERE ph.userVocabId = :userVocabId";
        Query<?> query = getSession().createQuery(hql);
        query.setParameter("wrongCount", wrongCount);
        query.setParameter("userVocabId", userVocabId);
        query.executeUpdate();
    }
    
    @Override
    public Object[] getTotalCorrectAndWrong(Integer userId) {
        String hql = "SELECT SUM(ph.correctCount), SUM(ph.wrongCount) " +
                     "FROM PracticeHistory ph " +
                     "JOIN UserVocab uv ON ph.userVocabId = uv.id " +
                     "WHERE uv.userId = :userId";
        
        Query<Object[]> query = getSession().createQuery(hql, Object[].class);
        query.setParameter("userId", userId);
        
        return query.getSingleResult(); 
    }
}
