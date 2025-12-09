package com.cuoi_ky.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "daily_streak")
public class DailyStreak {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(name = "user_id", nullable = false)
    private Integer userId;
    
    @Column(name = "date", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date date;
    
    @Column(name = "learned_words")
    private Integer learnedWords;

    public DailyStreak() {
    }

    public DailyStreak(Integer id, Integer userId, Date date, Integer learnedWords) {
        this.id = id;
        this.userId = userId;
        this.date = date;
        this.learnedWords = learnedWords;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Integer getLearnedWords() {
        return learnedWords;
    }

    public void setLearnedWords(Integer learnedWords) {
        this.learnedWords = learnedWords;
    }
}
