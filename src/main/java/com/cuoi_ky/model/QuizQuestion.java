package com.cuoi_ky.model;

import javax.persistence.*;

@Entity
@Table(name = "quiz_questions")
public class QuizQuestion {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(name = "vocab_id", nullable = false)
    private Integer vocabId;
    
    @Column(name = "question_text", nullable = false, length = 500)
    private String questionText;
    
    @Column(name = "option_a", nullable = false, length = 255)
    private String optionA;
    
    @Column(name = "option_b", nullable = false, length = 255)
    private String optionB;
    
    @Column(name = "option_c", nullable = false, length = 255)
    private String optionC;
    
    @Column(name = "option_d", nullable = false, length = 255)
    private String optionD;
    
    @Column(name = "correct_answer", nullable = false, length = 1)
    private String correctAnswer;

    public QuizQuestion() {
    }

    public QuizQuestion(Integer id, Integer vocabId, String questionText, String optionA, 
                       String optionB, String optionC, String optionD, String correctAnswer) {
        this.id = id;
        this.vocabId = vocabId;
        this.questionText = questionText;
        this.optionA = optionA;
        this.optionB = optionB;
        this.optionC = optionC;
        this.optionD = optionD;
        this.correctAnswer = correctAnswer;
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

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public String getOptionA() {
        return optionA;
    }

    public void setOptionA(String optionA) {
        this.optionA = optionA;
    }

    public String getOptionB() {
        return optionB;
    }

    public void setOptionB(String optionB) {
        this.optionB = optionB;
    }

    public String getOptionC() {
        return optionC;
    }

    public void setOptionC(String optionC) {
        this.optionC = optionC;
    }

    public String getOptionD() {
        return optionD;
    }

    public void setOptionD(String optionD) {
        this.optionD = optionD;
    }

    public String getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(String correctAnswer) {
        this.correctAnswer = correctAnswer;
    }
}
