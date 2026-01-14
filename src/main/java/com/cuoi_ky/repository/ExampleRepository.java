package com.cuoi_ky.repository;

import com.cuoi_ky.model.Example;
import java.util.List;

/**
 * Example Repository Interface
 */
public interface ExampleRepository extends BaseRepository<Example, Integer> {

    /**
     * Find examples by vocabulary ID
     */
    List<Example> findByVocabId(Integer vocabId);

    /**
     * Tìm ví dụ theo từ khóa trong câu ví dụ hoặc bản dịch
     */
    List<Example> searchByKeyword(String keyword);
}
