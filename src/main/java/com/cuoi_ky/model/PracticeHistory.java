package com.cuoi_ky.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "practice_history")
public class PracticeHistory {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(name = "user_vocab_id", nullable = false)
    private Integer userVocabId;
    
    @Column(name = "practice_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date practiceDate;
    
    @Column(name = "correct_count")
    private Integer correctCount;
    
    @Column(name = "wrong_count")
    private Integer wrongCount;
    
    @Column(name = "mode", length = 50)
    private String mode; // quiz, listening, fill

    public PracticeHistory() {
    }

    public PracticeHistory(Integer id, Integer userVocabId, Date practiceDate, 
                          Integer correctCount, Integer wrongCount, String mode) {
        this.id = id;
        this.userVocabId = userVocabId;
        this.practiceDate = practiceDate;
        this.correctCount = correctCount;
        this.wrongCount = wrongCount;
        this.mode = mode;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserVocabId() {
        return userVocabId;
    }

    public void setUserVocabId(Integer userVocabId) {
        this.userVocabId = userVocabId;
    }

    public Date getPracticeDate() {
        return practiceDate;
    }

    public void setPracticeDate(Date practiceDate) {
        this.practiceDate = practiceDate;
    }

    public Integer getCorrectCount() {
        return correctCount;
    }

    public void setCorrectCount(Integer correctCount) {
        this.correctCount = correctCount;
    }

    public Integer getWrongCount() {
        return wrongCount;
    }

    public void setWrongCount(Integer wrongCount) {
        this.wrongCount = wrongCount;
    }

    public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }
}
