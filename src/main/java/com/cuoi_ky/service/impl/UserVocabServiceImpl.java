package com.cuoi_ky.service.impl;

import com.cuoi_ky.dto.UserVocabularyDTO;
import com.cuoi_ky.model.PracticeHistory;
import com.cuoi_ky.model.UserVocab;
import com.cuoi_ky.model.Vocabulary;
import com.cuoi_ky.repository.PracticeHistoryRepository;
import com.cuoi_ky.repository.UserVocabRepository;
import com.cuoi_ky.repository.VocabularyRepository;
import com.cuoi_ky.repository.impl.BaseRepositoryImpl;
import com.cuoi_ky.service.UserVocabService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * UserVocab Service Implementation Following Single Responsibility Principle
 */
@Service
@Transactional
public class UserVocabServiceImpl extends BaseRepositoryImpl<UserVocab, Integer> implements UserVocabService {

	private final UserVocabRepository userVocabRepository;
	private final VocabularyRepository vocabularyRepository;
	private final PracticeHistoryRepository practiceHistoryRepository;

	@Autowired
	public UserVocabServiceImpl(UserVocabRepository userVocabRepository, VocabularyRepository vocabularyRepository,
			PracticeHistoryRepository practiceHistoryRepository) {
		this.userVocabRepository = userVocabRepository;
		this.vocabularyRepository = vocabularyRepository;
		this.practiceHistoryRepository = practiceHistoryRepository;
	}

	@Override
	public List<UserVocab> getUserVocabularyList(Integer userId) {
		return userVocabRepository.findByUserId(userId);
	}

	@Override
	public List<UserVocabularyDTO> getUserVocabulariesWithDetails(Integer userId) {
		List<UserVocab> userVocabs = userVocabRepository.findByUserId(userId);
		List<UserVocabularyDTO> vocabularies = new ArrayList<>();

		for (UserVocab userVocab : userVocabs) {
			Optional<Vocabulary> vocabOpt = vocabularyRepository.findById(userVocab.getVocabId());
			vocabOpt.ifPresent(vocab -> {
				UserVocabularyDTO dto = new UserVocabularyDTO();
				dto.setUserVocabId(userVocab.getId());
				dto.setVocabId(vocab.getId());
				dto.setWord(vocab.getWord());
				dto.setMeaning(vocab.getMeaning());
				dto.setRomaji(vocab.getRomaji());
				dto.setHiragana(vocab.getHiragana());
				dto.setKatakana(vocab.getKatakana());
				dto.setKanji(vocab.getKanji());
				dto.setAudioUrl(vocab.getAudioUrl());
				dto.setStatus(userVocab.getStatus());
				vocabularies.add(dto);
			});
		}

		return vocabularies;
	}

	@Override
	public List<UserVocab> getUserVocabulariesByStatus(Integer userId, String status) {
		return userVocabRepository.findByUserIdAndStatus(userId, status);
	}

	@Override
	public UserVocab addVocabularyToUser(Integer userId, Integer vocabId) {
		// Check if already exists
		Optional<UserVocab> existing = userVocabRepository.findByUserIdAndVocabId(userId, vocabId);
		if (existing.isPresent()) {
			return existing.get();
		}

		// Create new user vocab
		UserVocab userVocab = new UserVocab();
		userVocab.setUserId(userId);
		userVocab.setVocabId(vocabId);
		userVocab.setStatus("active");
		userVocab.setAddedAt(new Date());

		return userVocabRepository.save(userVocab);
	}

	@Override
	public void removeVocabularyFromUser(Integer userId, Integer vocabId) {
		Optional<UserVocab> userVocabOpt = userVocabRepository.findByUserIdAndVocabId(userId, vocabId);

		if (userVocabOpt.isPresent()) {
			UserVocab userVocab = userVocabOpt.get();
			userVocabRepository.deleteById(userVocab.getId());
		}
		// If not found, silently ignore (idempotent operation)
	}

	@Override
	public UserVocab updateVocabularyStatus(Integer userId, Integer vocabId, String status) {
		Optional<UserVocab> userVocabOpt = userVocabRepository.findByUserIdAndVocabId(userId, vocabId);

		if (userVocabOpt.isPresent()) {
			UserVocab userVocab = userVocabOpt.get();
			userVocab.setStatus(status);
			return userVocabRepository.save(userVocab);
		}

		throw new RuntimeException("UserVocab not found for userId: " + userId + " and vocabId: " + vocabId);
	}

	@Override
	public Optional<UserVocab> getUserVocab(Integer userId, Integer vocabId) {
		return userVocabRepository.findByUserIdAndVocabId(userId, vocabId);
	}

	@Override
	public long getTotalVocabularyCount(Integer userId) {
		return userVocabRepository.countByUserId(userId);
	}

	@Override
	public long getMasteredCount(Integer userId) {
		// Lấy tất cả từ vựng mà người dùng đã thêm vào
		List<UserVocab> userVocabs = userVocabRepository.findByUserId(userId);
		long masteredCount = 0;
		for (UserVocab uv : userVocabs) {
			// Kiểm tra trong bảng practice_history xem từ vựng này đã được học thuộc chưa
			boolean isMastered = practiceHistoryRepository.existsByUserVocabId(uv.getId());
			if (isMastered) {
				masteredCount++;
			}
		}
		return masteredCount;
	}

	@Override
	public long getLearningCount(Integer userId) {
		return userVocabRepository.countByUserIdAndStatus(userId, "learning");
	}

	@Override
	public List<Map<String, Object>> getUserActiveVocabulariesWithDetails(Integer userId) {
		List<UserVocab> activeVocabularies = userVocabRepository.findByUserIdAndStatus(userId, "active");
		List<Map<String, Object>> vocabularies = new ArrayList<>();

		for (UserVocab userVocab : activeVocabularies) {
			vocabularyRepository.findById(userVocab.getVocabId()).ifPresent(vocab -> {
				Map<String, Object> map = new HashMap<>();
				// Lưu id của bảng user_vocab để sau này ghi vào practice_history
				map.put("userVocabId", userVocab.getId());
				map.put("vocabulary", vocab);
				vocabularies.add(map);
			});
		}
		return vocabularies;
	}

	@Override
	public void saveHistoryPractice(List<PracticeHistory> histories) {
		for (PracticeHistory history : histories) {
			PracticeHistory exitHistory = practiceHistoryRepository.findByUserVocabId(history.getUserVocabId());
			// Nếu đã có lịch sử và trùng mode thì cập nhật lại
			if (exitHistory != null && exitHistory.getMode().equals(history.getMode())) {
				// Cập nhật lại số lần đúng/sai
				int newCorrectCount = exitHistory.getCorrectCount() + history.getCorrectCount();
				int newWrongCount = exitHistory.getWrongCount() + history.getWrongCount();

				practiceHistoryRepository.updateCorrectCount(history.getUserVocabId(), newCorrectCount);
				practiceHistoryRepository.updateWrongCount(history.getUserVocabId(), newWrongCount);
			} else {
				// Lưu mới nếu chưa có lịch sử
				practiceHistoryRepository.save(history);
			}
		}
	}

	@Override
	public List<UserVocabularyDTO> getRandomUserVocabularies(Integer userId, int limit) {
		List<UserVocab> userVocabs = userVocabRepository.findRandomByUserId(userId, limit);
		List<UserVocabularyDTO> vocabularies = new ArrayList<>();

		for (UserVocab userVocab : userVocabs) {
			Optional<Vocabulary> vocabOpt = vocabularyRepository.findById(userVocab.getVocabId());
			vocabOpt.ifPresent(vocab -> {
				UserVocabularyDTO dto = new UserVocabularyDTO();
				dto.setUserVocabId(userVocab.getId());
				dto.setVocabId(vocab.getId());
				dto.setWord(vocab.getWord());
				dto.setMeaning(vocab.getMeaning());
				dto.setRomaji(vocab.getRomaji());
				dto.setHiragana(vocab.getHiragana());
				dto.setKatakana(vocab.getKatakana());
				dto.setKanji(vocab.getKanji());
				dto.setAudioUrl(vocab.getAudioUrl());
				dto.setStatus(userVocab.getStatus());
				vocabularies.add(dto);
			});
		}

		return vocabularies;
	}

	@Override
	public List<UserVocabularyDTO> getNotebookVocabulariesByStatus(Integer userId, String status) {
		// Logic lấy từ bảng user_vocab dựa trên status (active/sleep)
		List<UserVocab> userVocabs = userVocabRepository.findByUserIdAndStatus(userId, status);
		List<UserVocabularyDTO> dtos = new ArrayList<>();

		for (UserVocab uv : userVocabs) {
			vocabularyRepository.findById(uv.getVocabId()).ifPresent(v -> {
				UserVocabularyDTO dto = new UserVocabularyDTO();
				dto.setUserVocabId(uv.getId());
				dto.setVocabId(v.getId());
				dto.setWord(v.getWord());
				dto.setMeaning(v.getMeaning());
				dto.setRomaji(v.getRomaji());
				dto.setHiragana(v.getHiragana());
				dto.setStatus(uv.getStatus());
				dtos.add(dto);
			});
		}
		return dtos;
	}

	@Override
	public long getReviewCount(Integer userId) {
		// Gọi Repository để đếm những từ có trạng thái 'active' (Ôn tập)
		return userVocabRepository.countByUserIdAndStatus(userId, "active");
	}

	@Override
	public long getSleepCount(Integer userId) {
		// Gọi Repository để đếm những từ có trạng thái 'sleep' (Ngủ đông)
		return userVocabRepository.countByUserIdAndStatus(userId, "sleep");
	}
	@Override
	public void updateVocabularyStatusById(Integer userVocabId, String status) {
	    UserVocab uv = userVocabRepository.findById(userVocabId).orElse(null);
	    if (uv != null) {
	        uv.setStatus(status);
	        userVocabRepository.save(uv);
	    }
	}
	@Override
	public List<UserVocabularyDTO> searchMyList(Integer userId, String keyword) {
	    // Gọi hàm từ Repository (hàm chúng ta vừa viết ở Bước 2)
	    // Chỗ này KHÔNG CÒN LỖI vì nó gọi sang Repository, không dùng getSession() trực tiếp
	    List<UserVocab> userVocabs = userVocabRepository.searchByRomaji(userId, keyword);
	    List<UserVocabularyDTO> dtos = new java.util.ArrayList<>();
	    for (UserVocab uv : userVocabs) {
	        vocabularyRepository.findById(uv.getVocabId()).ifPresent(v -> {
	            UserVocabularyDTO dto = new UserVocabularyDTO();
	            dto.setUserVocabId(uv.getId());
	            dto.setVocabId(v.getId());
	            dto.setWord(v.getWord());
	            dto.setMeaning(v.getMeaning());
	            dto.setRomaji(v.getRomaji());
	            dto.setHiragana(v.getHiragana());
	            dto.setStatus(uv.getStatus());
	            dtos.add(dto);
	        });
	    }
	    return dtos;
	}
}
