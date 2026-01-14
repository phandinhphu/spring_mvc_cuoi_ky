package com.cuoi_ky.service.impl;

import com.cuoi_ky.model.Example;
import com.cuoi_ky.model.Vocabulary;
import com.cuoi_ky.repository.ExampleRepository;
import com.cuoi_ky.repository.VocabularyRepository;
import com.cuoi_ky.service.RAGService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Implementation của RAGService
 * Sử dụng VocabularyRepository và ExampleRepository để tìm dữ liệu liên quan
 */
@Service
public class RAGServiceImpl implements RAGService {

    @Autowired
    private VocabularyRepository vocabularyRepository;

    @Autowired
    private ExampleRepository exampleRepository;

    @Override
    public String findContext(String query) {
        StringBuilder context = new StringBuilder();

        // 1. Tìm từ vựng liên quan (Search relevant vocabulary)
        List<Vocabulary> vocabList = vocabularyRepository.searchByKeyword(query);

        if (!vocabList.isEmpty()) {
            context.append("Thông tin từ vựng tìm thấy:\n");
            for (Vocabulary vocab : vocabList) {
                context.append(String.format("- Từ: %s (%s)\n  Nghĩa: %s\n",
                        vocab.getWord(),
                        vocab.getHiragana() != null ? vocab.getHiragana() : "",
                        vocab.getMeaning()));

                if (vocab.getKanji() != null) {
                    context.append(String.format("  Kanji: %s\n", vocab.getKanji()));
                }
            }
            context.append("\n");
        }

        // 2. Tìm câu ví dụ liên quan (Search relevant examples)
        List<Example> exampleList = exampleRepository.searchByKeyword(query);

        if (!exampleList.isEmpty()) {
            context.append("Các câu ví dụ liên quan:\n");
            for (Example ex : exampleList) {
                context.append(String.format("- Câu: %s\n  Dịch: %s\n",
                        ex.getExampleSentence(),
                        ex.getTranslation()));
            }
            context.append("\n");
        }

        if (context.length() == 0) {
            return "";
        }

        return "Dựa trên dữ liệu trong cơ sở dữ liệu:\n" + context.toString();
    }
}
