package com.cuoi_ky.repository.impl;

import com.cuoi_ky.dto.RecentPracticeDTO;
import com.cuoi_ky.model.PracticeHistory;
import com.cuoi_ky.repository.PracticeHistoryRepository;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        String hql = "SELECT SUM(ph.correctCount) FROM PracticeHistory ph WHERE ph.userVocabId = :userVocabId";
        Query<Long> query = getSession().createQuery(hql, Long.class);
        query.setParameter("userVocabId", userVocabId);
        Long totalCorrect = query.uniqueResult();
        return totalCorrect != null ? totalCorrect.intValue() : 0;
    }

    @Override
    public int getWrongCountByUserVocabId(Integer userVocabId) {
        String hql = "SELECT SUM(ph.wrongCount) FROM PracticeHistory ph WHERE ph.userVocabId = :userVocabId";
        Query<Long> query = getSession().createQuery(hql, Long.class);
        query.setParameter("userVocabId", userVocabId);
        Long totalWrong = query.uniqueResult();
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

    @Override
    public Map<String, Long> getPracticeCountByMode(Integer userId) {
        String hql = "SELECT ph.mode, COUNT(ph.id) FROM PracticeHistory ph, UserVocab uv " +
                "WHERE ph.userVocabId = uv.id AND uv.userId = :userId " +
                "GROUP BY ph.mode";

        Query<Object[]> query = getSession().createQuery(hql, Object[].class);
        query.setParameter("userId", userId);
        List<Object[]> results = query.getResultList();

        Map<String, Long> modeStats = new HashMap<>();
        for (Object[] result : results) {
            modeStats.put((String) result[0], (Long) result[1]);
        }
        return modeStats;
    }

    @Override
    public List<RecentPracticeDTO> getRecentPracticeHistory(Integer userId) {
        String hql = "SELECT ph.mode, MAX(ph.practiceDate) as latestDate " +
                "FROM PracticeHistory ph " +
                "JOIN UserVocab uv ON ph.userVocabId = uv.id " +
                "WHERE uv.userId = :userId " +
                "AND ph.mode IN ('quiz', 'listening', 'fill', 'flashcard') " +
                "GROUP BY ph.mode " +
                "ORDER BY latestDate ASC";

        Query<Object[]> query = getSession().createQuery(hql, Object[].class);
        query.setParameter("userId", userId);
        query.setMaxResults(4); // Limit to 4 most recent activities

        List<Object[]> results = query.getResultList();
        List<RecentPracticeDTO> recentPractices = new ArrayList<>();

        for (Object[] result : results) {
            String mode = (String) result[0];
            Date practiceDate = (Date) result[1];

            RecentPracticeDTO dto = new RecentPracticeDTO();
            dto.setMode(mode);
            dto.setPracticeDate(practiceDate);
            dto.setDescription(getDescriptionByMode(mode));
            dto.setTimeAgo(calculateTimeAgo(practiceDate));

            recentPractices.add(dto);
        }

        return recentPractices;
    }

    private String getDescriptionByMode(String mode) {
        switch (mode) {
            case "flashcard":
                return "Luyện tập Flashcard";
            case "quiz":
                return "Hoàn thành Quiz";
            case "listening":
                return "Luyện nghe";
            case "fill":
                return "Điền từ";
            default:
                return "Luyện tập";
        }
    }

    private String calculateTimeAgo(Date practiceDate) {
        long practiceTime = practiceDate.getTime();
        long offset = java.util.TimeZone.getDefault().getOffset(practiceTime);
        long adjustedTime = practiceTime + offset;

        long diffInMillis = System.currentTimeMillis() - adjustedTime;

        // Handle case where time difference is negative (clock skew or future date)
        if (diffInMillis < 0) {
            diffInMillis = 0;
        }

        long diffInMinutes = diffInMillis / (60 * 1000);
        long diffInHours = diffInMillis / (60 * 60 * 1000);
        long diffInDays = diffInMillis / (24 * 60 * 60 * 1000);

        if (diffInMinutes < 1) {
            return "Vừa xong";
        } else if (diffInMinutes < 60) {
            return diffInMinutes + " phút trước";
        } else if (diffInHours < 24) {
            return diffInHours + " giờ trước";
        } else if (diffInDays == 1) {
            return "Hôm qua";
        } else {
            return diffInDays + " ngày trước";
        }
    }
}
