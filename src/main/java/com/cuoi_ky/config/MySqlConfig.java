package com.cuoi_ky.config;

import java.util.Properties;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@PropertySource("classpath:db.properties")
@EnableTransactionManagement
public class MySqlConfig {

	@Autowired
	private Environment env;

	@Bean
	public DataSource dataSource() {
		HikariConfig config = new HikariConfig();
		config.setDriverClassName(env.getProperty("db.driverClassName"));
		config.setJdbcUrl(env.getProperty("db.url"));
		config.setUsername(env.getProperty("db.username"));
		config.setPassword(env.getProperty("db.password"));

		// Pool settings
		config.setMaximumPoolSize(Integer.parseInt(env.getProperty("jdbc.pool.size", "10")));
		config.setIdleTimeout(Long.parseLong(env.getProperty("jdbc.idleTimeout", "30000")));
		config.setMaxLifetime(Long.parseLong(env.getProperty("jdbc.maxLifetime", "1800000")));
		config.setConnectionTimeout(Long.parseLong(env.getProperty("jdbc.connectionTimeout", "30000")));

		return new HikariDataSource(config);
	}

	// Hibernate SessionFactory
	@Bean
	public LocalSessionFactoryBean sessionFactory() {

		LocalSessionFactoryBean sf = new LocalSessionFactoryBean();
		sf.setDataSource(dataSource());
		sf.setPackagesToScan("com.cuoi_ky.model");

		Properties props = new Properties();
		props.put("hibernate.dialect", env.getProperty("hibernate.dialect"));
		props.put("hibernate.show_sql", env.getProperty("hibernate.show_sql"));
		props.put("hibernate.hbm2ddl.auto", env.getProperty("hibernate.hbm2ddl.auto"));

		sf.setHibernateProperties(props);
		return sf;
	}

	// Quản lý transaction
	@Bean
	public HibernateTransactionManager transactionManager() {
		HibernateTransactionManager tx = new HibernateTransactionManager();
		tx.setSessionFactory(sessionFactory().getObject());
		return tx;
	}

	@Bean
	public JdbcTemplate jdbcTemplate(DataSource dataSource) {
		return new JdbcTemplate(dataSource);
	}

}
