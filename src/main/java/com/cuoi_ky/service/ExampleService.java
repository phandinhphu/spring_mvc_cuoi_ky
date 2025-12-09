package com.cuoi_ky.service;

import com.cuoi_ky.model.Example;
import java.util.List;

/**
 * Example Service Interface
 */
public interface ExampleService {
    
    /**
     * Get examples by vocabulary ID
     */
    List<Example> getExamplesByVocabId(Integer vocabId);
    
    /**
     * Save example
     */
    Example saveExample(Example example);
}
