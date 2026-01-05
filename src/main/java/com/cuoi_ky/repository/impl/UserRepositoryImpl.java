package com.cuoi_ky.repository.impl;

import com.cuoi_ky.model.User;
import com.cuoi_ky.repository.UserRepository;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Optional;

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
    public Optional<User> findByForgotPasswordToken(String token) {
		String hql = "FROM User u WHERE u.forgotPasswordToken = :token";
		Query<User> query = getSession().createQuery(hql, User.class);
		query.setParameter("token", token);
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

	@Override
	public boolean updateProfile(Integer id, String fullname) {
		String hql = "UPDATE User u SET u.fullname = :fullname WHERE u.id = :id";
		
		Query query = getSession().createQuery(hql);
		query.setParameter("fullname", fullname);
		query.setParameter("id", id);
		
		return query.executeUpdate() > 0;
 	}

	@Override
	public boolean changePassword(Integer id, String password) {
		String hql = "UPDATE User u SET u.password = :password WHERE u.id = :id";
		
		Query query = getSession().createQuery(hql);
		query.setParameter("password", password);
		query.setParameter("id", id);
		
		return query.executeUpdate() > 0;
		
	}

	@Override
	public boolean updateAvatar(Integer id, String avatar) {
		String hql = "UPDATE User u SET u.avatar = :avatar WHERE u.id = :id";
		
		Query query = getSession().createQuery(hql);
		query.setParameter("avatar", avatar);
		query.setParameter("id", id);
		
		return query.executeUpdate() > 0;
	}

	@Override
	public boolean updateForgotPasswordToken(Integer id, String token, LocalDateTime expiry) {
		String hql = "UPDATE User u SET u.forgotPasswordToken = :token, "
				+ "u.forgotPasswordTokenExpiry = :expiry WHERE u.id = :id";
		
		Query query = getSession().createQuery(hql);
		query.setParameter("token", token);
		query.setParameter("expiry", expiry);
		query.setParameter("id", id);
		
		return query.executeUpdate() > 0;
	}

	@Override
	public boolean resetPassword(String token, String newPassword) {
		String hql = "UPDATE User u SET u.password = :newPassword, "
				+ "u.forgotPasswordToken = null, u.forgotPasswordTokenExpiry = null "
				+ "WHERE u.forgotPasswordToken = :token";
		
		Query query = getSession().createQuery(hql);
		query.setParameter("newPassword", newPassword);
		query.setParameter("token", token);
		
		return query.executeUpdate() > 0;
	}
}
