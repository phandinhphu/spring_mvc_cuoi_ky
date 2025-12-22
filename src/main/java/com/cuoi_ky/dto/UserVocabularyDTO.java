package com.cuoi_ky.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserVocabularyDTO {
	private Integer vocabId;
	private Integer userVocabId;
	private String word;
	private String meaning;
	private String romaji;
	private String hiragana;
	private String katakana;
	private String kanji;
	private String audioUrl;
	private String status;
}
