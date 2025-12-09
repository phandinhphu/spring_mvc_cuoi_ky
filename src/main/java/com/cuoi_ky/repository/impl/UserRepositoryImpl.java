package com.cuoi_ky.repository.impl;

import com.cuoi_ky.model.User;
import com.cuoi_ky.repository.UserRepository;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

/**
 * User Repository Implementation
 */
@Repository
@Transactional
public class UserRepositoryImpl extends BaseRepositoryImpl<User, Integer> 
        implements UserRepository {

    @Override
    public Optional<User> findByUsername(String username) {
        String hql = "FROM User u WHERE u.username = :username";
        Query<User> query = getSession().createQuery(hql, User.class);
        query.setParameter("username", username);
        return query.uniqueResultOptional();
    }

    @Override
    public Optional<User> findByEmail(String email) {
        String hql = "FROM User u WHERE u.email = :email";
        Query<User> query = getSession().createQuery(hql, User.class);
        query.setParameter("email", email);
        return query.uniqueResultOptional();
    }

    @Override
    public boolean existsByUsername(String username) {
        String hql = "SELECT COUNT(u) FROM User u WHERE u.username = :username";
        Query<Long> query = getSession().createQuery(hql, Long.class);
        query.setParameter("username", username);
        return query.getSingleResult() > 0;
    }

    @Override
    public boolean existsByEmail(String email) {
        String hql = "SELECT COUNT(u) FROM User u WHERE u.email = :email";
        Query<Long> query = getSession().createQuery(hql, Long.class);
        query.setParameter("email", email);
        return query.getSingleResult() > 0;
    }
}
