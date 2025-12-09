package com.cuoi_ky.repository.impl;

import com.cuoi_ky.model.Example;
import com.cuoi_ky.repository.ExampleRepository;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Example Repository Implementation
 */
@Repository
@Transactional
public class ExampleRepositoryImpl extends BaseRepositoryImpl<Example, Integer> 
        implements ExampleRepository {

    @Override
    public List<Example> findByVocabId(Integer vocabId) {
        String hql = "FROM Example e WHERE e.vocabId = :vocabId";
        Query<Example> query = getSession().createQuery(hql, Example.class);
        query.setParameter("vocabId", vocabId);
        return query.getResultList();
    }
}
