package com.cuoi_ky.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "vocabulary")
public class Vocabulary {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(name = "word", nullable = false, length = 100)
    private String word;
    
    @Column(name = "meaning", nullable = false, length = 255)
    private String meaning;
    
    @Column(name = "romaji", length = 100)
    private String romaji;
    
    @Column(name = "hiragana", length = 100)
    private String hiragana;
    
    @Column(name = "katakana", length = 100)
    private String katakana;
    
    @Column(name = "kanji", length = 100)
    private String kanji;
    
    @Column(name = "audio_url", length = 255)
    private String audioUrl;
    
    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    public Vocabulary() {
    }

    public Vocabulary(Integer id, String word, String meaning, String romaji, String hiragana, 
                     String katakana, String kanji, String audioUrl, Date createdAt) {
        this.id = id;
        this.word = word;
        this.meaning = meaning;
        this.romaji = romaji;
        this.hiragana = hiragana;
        this.katakana = katakana;
        this.kanji = kanji;
        this.audioUrl = audioUrl;
        this.createdAt = createdAt;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }

    public String getMeaning() {
        return meaning;
    }

    public void setMeaning(String meaning) {
        this.meaning = meaning;
    }

    public String getRomaji() {
        return romaji;
    }

    public void setRomaji(String romaji) {
        this.romaji = romaji;
    }

    public String getHiragana() {
        return hiragana;
    }

    public void setHiragana(String hiragana) {
        this.hiragana = hiragana;
    }

    public String getKatakana() {
        return katakana;
    }

    public void setKatakana(String katakana) {
        this.katakana = katakana;
    }

    public String getKanji() {
        return kanji;
    }

    public void setKanji(String kanji) {
        this.kanji = kanji;
    }

    public String getAudioUrl() {
        return audioUrl;
    }

    public void setAudioUrl(String audioUrl) {
        this.audioUrl = audioUrl;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
