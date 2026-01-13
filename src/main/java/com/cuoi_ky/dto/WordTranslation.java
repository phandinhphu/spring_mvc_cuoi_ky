package com.cuoi_ky.dto;

/**
 * DTO for individual word translation result
 */
public class WordTranslation {

    private String word;
    private String meaning;
    private String romaji;
    private String hiragana;
    private String katakana;
    private String kanji;
    private boolean existsInDb;
    private Integer vocabularyId;

    public WordTranslation() {
    }

    public WordTranslation(String word, String meaning, String romaji, String hiragana,
            String katakana, String kanji, boolean existsInDb, Integer vocabularyId) {
        this.word = word;
        this.meaning = meaning;
        this.romaji = romaji;
        this.hiragana = hiragana;
        this.katakana = katakana;
        this.kanji = kanji;
        this.existsInDb = existsInDb;
        this.vocabularyId = vocabularyId;
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

    public boolean isExistsInDb() {
        return existsInDb;
    }

    public void setExistsInDb(boolean existsInDb) {
        this.existsInDb = existsInDb;
    }

    public Integer getVocabularyId() {
        return vocabularyId;
    }

    public void setVocabularyId(Integer vocabularyId) {
        this.vocabularyId = vocabularyId;
    }
}
