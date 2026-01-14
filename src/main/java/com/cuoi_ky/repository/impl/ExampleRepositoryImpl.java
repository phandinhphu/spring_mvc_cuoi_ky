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

    @Override
    public List<Example> searchByKeyword(String keyword) {
        // Tìm kiếm ví dụ có chứa từ khóa trong câu tiếng Nhật hoặc bản dịch tiếng Việt
        String hql = "FROM Example e WHERE " +
                "LOWER(e.exampleSentence) LIKE LOWER(:keyword) OR " +
                "LOWER(e.translation) LIKE LOWER(:keyword)";

        Query<Example> query = getSession().createQuery(hql, Example.class);
        query.setParameter("keyword", "%" + keyword + "%");
        // Giới hạn kết quả để tránh quá tải context
        query.setMaxResults(10);
        return query.getResultList();
    }
}
