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
}
