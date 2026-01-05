package com.cuoi_ky.controller;

import com.cuoi_ky.dto.GoogleUser;
import com.cuoi_ky.model.User;
import com.cuoi_ky.service.UserService;
import com.cuoi_ky.util.MailUtil;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Controller
@RequestMapping("/auth")
public class AuthController {

	@Value("${google.client-id}")
	private String GOOGLE_CLIENT_ID;
	@Value("${google.client-secret}")
	private String GOOGLE_CLIENT_SECRET;
	@Value("${google.redirect-uri}")
	private String GOOGLE_REDIRECT_URI;

	private final UserService userService;
	private final MailUtil mailUtil;

	@Autowired
	public AuthController(UserService userService, MailUtil mailUtil) {
		this.userService = userService;
		this.mailUtil = mailUtil;
	}

	@GetMapping("/oauth2/authorize/google")
	public void loginWithGoogle(HttpServletResponse response) throws IOException {
		String googleOAuthUrl = "https://accounts.google.com/o/oauth2/v2/auth" + "?client_id=" + GOOGLE_CLIENT_ID
				+ "&redirect_uri=" + GOOGLE_REDIRECT_URI + "&response_type=code" + "&scope=openid%20email%20profile";

		response.sendRedirect(googleOAuthUrl);
	}

	@GetMapping("/login")
	public String login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "message", required = false) String message, Model model) {
		if (error != null) {
			model.addAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
		}
		if (message != null) {
			if ("logout".equals(message)) {
				model.addAttribute("message", "Bạn đã đăng xuất thành công!");
			} else if ("required".equals(message)) {
				model.addAttribute("message", "Vui lòng đăng nhập để tiếp tục!");
			}
		}
		return "auth/login";
	}

	@GetMapping("/register")
	public String register(Model model) {
		return "auth/register";
	}

	@GetMapping("/google/callback")
	public String callback(@RequestParam("code") String code, HttpSession session) throws Exception {
		// Đổi mã code lấy access token và thông tin người dùng từ Google
		String accessToken = getAccessToken(code);
		
		// Lấy thông tin người dùng từ Google
		GoogleUser googleUser = getUserInfo(accessToken);
		
		// Đăng ký hoặc đăng nhập người dùng
		User user = userService.registerUserWithGoogle(googleUser);
		session.setAttribute("userId", user.getId());
		session.setAttribute("username", user.getUsername());
		session.setAttribute("user", user);
		
		return "redirect:/dashboard";
	}
	
	@GetMapping("/forgot-password")
	public String forgotPassword(Model model) {
		return "auth/forgot-password";
	}
	
	@GetMapping("/reset-password")
	public String resetPassword(@RequestParam("token") String token, Model model) {
		User user = userService.getUserByForgotPasswordToken(token).orElse(null);
		
		if (user == null || user.getForgotPasswordTokenExpiry().isBefore(LocalDateTime.now())) {
			model.addAttribute("error", "Liên kết đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.");
			return "error/404";
		}
		
		
		model.addAttribute("token", token);
		return "auth/reset-password";
	}
	
	@PostMapping("/forgot-password")
	public String processForgotPassword(@RequestParam("email") String email, Model model) {
		Optional<User> userOpt = userService.getUserByUsername(email);
		
		if (userOpt.isPresent()) {
			User user = userOpt.get();
			// Tạo token và expiry
			String token = UUID.randomUUID().toString();
			LocalDateTime expiry = LocalDateTime.now().plusMinutes(15);
			
			userService.updateForgotPasswordToken(user.getId(), token, expiry);

			String resetLink = "http://localhost:8080/cuoi_ky/auth/reset-password?token=" + token;
			
			mailUtil.sendMail(email, "Đặt lại mật khẩu", 
					"Nhấp vào liên kết sau để đặt lại mật khẩu của bạn: " + resetLink);
		}
		
		// Luôn hiển thị thông báo thành công để tránh lộ thông tin người dùng
		model.addAttribute("message", "Nếu email tồn tại trong hệ thống, bạn sẽ nhận được hướng dẫn đặt lại mật khẩu.");
		return "auth/forgot-password";
	}

	@PostMapping("/reset-password")
	public String processResetPassword(@RequestParam("token") String token,
			@RequestParam("password") String password,
			@RequestParam("confirmPassword") String confirmPassword,
			Model model) {
		boolean success = userService.resetPassword(token, password);
		
		if (success) {
			model.addAttribute("message", "Mật khẩu của bạn đã được đặt lại thành công. Vui lòng đăng nhập.");
			return "auth/login";
		} else {
			model.addAttribute("error", "Liên kết đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.");
			return "auth/reset-password";
		}
	}
	
	@PostMapping("/login")
	public String processLogin(@RequestParam String username, @RequestParam String password, Model model,
			HttpSession session) {
		// Authenticate with database
		Optional<User> userOpt = userService.authenticate(username, password);

		if (userOpt.isPresent()) {
			User user = userOpt.get();
			session.setAttribute("userId", user.getId());
			session.setAttribute("username", user.getUsername());
			session.setAttribute("user", user);
			return "redirect:/dashboard";
		}

		return "redirect:/auth/login?error";
	}

	@PostMapping("/register")
	public String processRegister(@RequestParam String username, @RequestParam String email,
			@RequestParam String password, @RequestParam String confirmPassword, Model model) {
		// Validate passwords match
		if (!password.equals(confirmPassword)) {
			model.addAttribute("error", "Mật khẩu xác nhận không khớp!");
			return "auth/register";
		}

		// Check if username exists
		if (userService.isUsernameExists(username)) {
			model.addAttribute("error", "Tên đăng nhập đã tồn tại!");
			return "auth/register";
		}

		// Check if email exists
		if (userService.isEmailExists(email)) {
			model.addAttribute("error", "Email đã được sử dụng!");
			return "auth/register";
		}

		// Register new user
		User newUser = new User();
		newUser.setUsername(username);
		newUser.setEmail(email);
		newUser.setPassword(password);

		userService.registerUser(newUser);

		return "redirect:/auth/login";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/auth/login?message=logout";
	}
	
	private String getAccessToken(String code) throws Exception {
	    OkHttpClient client = new OkHttpClient();

	    RequestBody body = new FormBody.Builder()
	            .add("code", code)
	            .add("client_id", GOOGLE_CLIENT_ID)
	            .add("client_secret", GOOGLE_CLIENT_SECRET)
	            .add("redirect_uri", GOOGLE_REDIRECT_URI)
	            .add("grant_type", "authorization_code")
	            .build();

	    Request request = new Request.Builder()
	            .url("https://oauth2.googleapis.com/token")
	            .post(body)
	            .build();

	    Response response = client.newCall(request).execute();

	    ObjectMapper mapper = new ObjectMapper();
	    JsonNode json = mapper.readTree(response.body().string());

	    return json.get("access_token").asText();
	}

	private GoogleUser getUserInfo(String accessToken) throws Exception {
	    OkHttpClient client = new OkHttpClient();

	    Request request = new Request.Builder()
	            .url("https://www.googleapis.com/oauth2/v2/userinfo")
	            .addHeader("Authorization", "Bearer " + accessToken)
	            .build();

	    Response response = client.newCall(request).execute();

	    ObjectMapper mapper = new ObjectMapper();
	    return mapper.readValue(response.body().string(), GoogleUser.class);
	}

}
