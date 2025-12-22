package com.cuoi_ky.controller;

import com.cuoi_ky.model.User;
import com.cuoi_ky.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Optional;

/**
 * Authentication Controller
 * Following Dependency Inversion Principle
 */
@Controller
@RequestMapping("/auth")
public class AuthController {

    private final UserService userService;

    @Autowired
    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/login")
    public String login(@RequestParam(value = "error", required = false) String error,
                       @RequestParam(value = "message", required = false) String message,
                       Model model) {
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

    @PostMapping("/login")
    public String processLogin(@RequestParam String username, 
                              @RequestParam String password, 
                              Model model,
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
    public String processRegister(@RequestParam String username,
                                  @RequestParam String email,
                                  @RequestParam String password,
                                  @RequestParam String confirmPassword,
                                  Model model) {
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
}

