package com.cuoi_ky.repository.impl;

import com.cuoi_ky.model.DailyStreak;
import com.cuoi_ky.repository.DailyStreakRepository;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Optional;

/**
 * DailyStreak Repository Implementation
 */
@Repository
@Transactional
public class DailyStreakRepositoryImpl extends BaseRepositoryImpl<DailyStreak, Integer> 
        implements DailyStreakRepository {

    @Override
    public Optional<DailyStreak> findByUserIdAndDate(Integer userId, Date date) {
        String hql = "FROM DailyStreak ds WHERE ds.userId = :userId AND ds.date = :date";
        Query<DailyStreak> query = getSession().createQuery(hql, DailyStreak.class);
        query.setParameter("userId", userId);
        query.setParameter("date", date);
        return query.uniqueResultOptional();
    }

    @Override
    public List<DailyStreak> findByUserId(Integer userId) {
        String hql = "FROM DailyStreak ds WHERE ds.userId = :userId ORDER BY ds.date DESC";
        Query<DailyStreak> query = getSession().createQuery(hql, DailyStreak.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }

    @Override
    public List<DailyStreak> findRecentByUserId(Integer userId, int days) {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, -days);
        Date startDate = cal.getTime();
        
        String hql = "FROM DailyStreak ds WHERE ds.userId = :userId AND ds.date >= :startDate ORDER BY ds.date DESC";
        Query<DailyStreak> query = getSession().createQuery(hql, DailyStreak.class);
        query.setParameter("userId", userId);
        query.setParameter("startDate", startDate);
        return query.getResultList();
    }

    @Override
    public int calculateCurrentStreak(Integer userId) {
        List<DailyStreak> streaks = findByUserId(userId);
        if (streaks.isEmpty()) {
            return 0;
        }
        
        int currentStreak = 0;
        Calendar cal = Calendar.getInstance();
        Date today = cal.getTime();
        
        for (DailyStreak streak : streaks) {
            if (isSameDay(streak.getDate(), today) || isSameDay(streak.getDate(), getYesterday(today))) {
                currentStreak++;
                today = getYesterday(today);
            } else {
                break;
            }
        }
        
        return currentStreak;
    }
    
    private boolean isSameDay(Date date1, Date date2) {
        Calendar cal1 = Calendar.getInstance();
        Calendar cal2 = Calendar.getInstance();
        cal1.setTime(date1);
        cal2.setTime(date2);
        return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) &&
               cal1.get(Calendar.DAY_OF_YEAR) == cal2.get(Calendar.DAY_OF_YEAR);
    }
    
    private Date getYesterday(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DAY_OF_MONTH, -1);
        return cal.getTime();
    }
}
