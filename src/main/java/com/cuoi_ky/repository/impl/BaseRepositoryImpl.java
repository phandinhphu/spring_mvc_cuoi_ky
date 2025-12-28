package com.cuoi_ky.repository.impl;

import com.cuoi_ky.repository.BaseRepository;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;
import java.util.Optional;

/**
 * Base Repository Implementation using Hibernate
 * Following Single Responsibility Principle (SRP) - handles only data access
 * Following Dependency Inversion Principle (DIP) - depends on SessionFactory abstraction
 * @param <T> Entity type
 * @param <ID> ID type
 */
public abstract class BaseRepositoryImpl<T, ID extends Serializable> implements BaseRepository<T, ID> {

    @Autowired
    protected SessionFactory sessionFactory;

    private Class<T> entityClass;

    @SuppressWarnings("unchecked")
    public BaseRepositoryImpl() {
        this.entityClass = (Class<T>) ((ParameterizedType) getClass()
                .getGenericSuperclass()).getActualTypeArguments()[0];
    }

    protected Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public T save(T entity) {
        getSession().saveOrUpdate(entity);
        return entity;
    }

    @Override
    public T update(T entity) {
        getSession().update(entity);
        return entity;
    }

    @Override
    public Optional<T> findById(ID id) {
        T entity = getSession().get(entityClass, id);
        return Optional.ofNullable(entity);
    }

    @Override
    public List<T> findAll() {
        CriteriaBuilder cb = getSession().getCriteriaBuilder();
        CriteriaQuery<T> cq = cb.createQuery(entityClass);
        Root<T> root = cq.from(entityClass);
        cq.select(root);
        return getSession().createQuery(cq).getResultList();
    }

    @Override
    public void deleteById(ID id) {
        T entity = getSession().get(entityClass, id);
        if (entity != null) {
            getSession().delete(entity);
        }
    }

    @Override
    public boolean existsById(ID id) {
        return findById(id).isPresent();
    }

    @Override
    public long count() {
        CriteriaBuilder cb = getSession().getCriteriaBuilder();
        CriteriaQuery<Long> cq = cb.createQuery(Long.class);
        Root<T> root = cq.from(entityClass);
        cq.select(cb.count(root));
        return getSession().createQuery(cq).getSingleResult();
    }
}
