package com.cuoi_ky.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "users")
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "username", nullable = false, unique = true, length = 50)
	private String username;

	@Column(name = "password", nullable = true, length = 255)
	private String password;

	@Column(name = "email", nullable = false, unique = true, length = 100)
	private String email;

	@Column(name = "created_at")
	@Temporal(TemporalType.TIMESTAMP)
	private Date createdAt;

	@Column(name = "fullname", length = 100)
	private String fullname;

	@Column(name = "avatar", length = 100)
	private String avatar;
	
	@Column(name = "avatar_public_id", length = 100)
	private String avatarPublicId;

	@Column(name = "google_id", length = 100)
	private String googleId;

	public User() {
	}

	public User(Integer id, String username, String password, String email, Date createdAt) {
		this.id = id;
		this.username = username;
		this.password = password;
		this.email = email;
		this.createdAt = createdAt;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getGoogleId() {
		return googleId;
	}

	public void setGoogleId(String googleId) {
		this.googleId = googleId;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getAvatarPublicId() {
		return avatarPublicId;
	}

	public void setAvatarPublicId(String avater_public_id) {
		this.avatarPublicId = avater_public_id;
	}
}
