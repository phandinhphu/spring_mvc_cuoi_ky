package com.cuoi_ky.service.impl;

import com.cuoi_ky.model.Example;
import com.cuoi_ky.repository.ExampleRepository;
import com.cuoi_ky.service.ExampleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Example Service Implementation
 * Following Single Responsibility Principle
 */
@Service
@Transactional
public class ExampleServiceImpl implements ExampleService {

    private final ExampleRepository exampleRepository;

    @Autowired
    public ExampleServiceImpl(ExampleRepository exampleRepository) {
        this.exampleRepository = exampleRepository;
    }

    @Override
    public List<Example> getExamplesByVocabId(Integer vocabId) {
        return exampleRepository.findByVocabId(vocabId);
    }

    @Override
    public Example saveExample(Example example) {
        return exampleRepository.save(example);
    }
}
