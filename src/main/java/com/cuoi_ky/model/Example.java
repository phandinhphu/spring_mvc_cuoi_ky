package com.cuoi_ky.model;

import javax.persistence.*;

@Entity
@Table(name = "examples")
public class Example {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(name = "vocab_id", nullable = false)
    private Integer vocabId;
    
    @Column(name = "example_sentence", nullable = false, columnDefinition = "TEXT")
    private String exampleSentence;
    
    @Column(name = "translation", nullable = false, columnDefinition = "TEXT")
    private String translation;

    public Example() {
    }

    public Example(Integer id, Integer vocabId, String exampleSentence, String translation) {
        this.id = id;
        this.vocabId = vocabId;
        this.exampleSentence = exampleSentence;
        this.translation = translation;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getVocabId() {
        return vocabId;
    }

    public void setVocabId(Integer vocabId) {
        this.vocabId = vocabId;
    }

    public String getExampleSentence() {
        return exampleSentence;
    }

    public void setExampleSentence(String exampleSentence) {
        this.exampleSentence = exampleSentence;
    }

    public String getTranslation() {
        return translation;
    }

    public void setTranslation(String translation) {
        this.translation = translation;
    }
}
