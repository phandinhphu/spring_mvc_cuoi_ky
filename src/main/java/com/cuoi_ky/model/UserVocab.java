package com.cuoi_ky.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "user_vocab")
public class UserVocab {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(name = "user_id", nullable = false)
    private Integer userId;
    
    @Column(name = "vocab_id", nullable = false)
    private Integer vocabId;
    
    @Column(name = "status", length = 50)
    private String status; // active, sleep, learning, mastered, review
    
    @Column(name = "added_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addedAt;

    public UserVocab() {
    }

    public UserVocab(Integer id, Integer userId, Integer vocabId, String status, Date addedAt) {
        this.id = id;
        this.userId = userId;
        this.vocabId = vocabId;
        this.status = status;
        this.addedAt = addedAt;
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

    public Integer getVocabId() {
        return vocabId;
    }

    public void setVocabId(Integer vocabId) {
        this.vocabId = vocabId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getAddedAt() {
        return addedAt;
    }

    public void setAddedAt(Date addedAt) {
        this.addedAt = addedAt;
    }
}
