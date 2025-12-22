package com.cuoi_ky.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cuoi_ky.model.User;
import com.cuoi_ky.service.UserService;

@Controller
@RequestMapping("/profile")
public class UserController {
	
	private final UserService userService;
	
	@Autowired
	public UserController(UserService userService) {
		this.userService = userService;
	}
	
	@GetMapping("/")
	public String showProfile(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("user");
        model.addAttribute("user", currentUser);
        return "profile/index";
    }
	
	@PostMapping("/update-profile")
    public String updateProfile(@RequestParam("fullname") String fullname,
                                HttpSession session,
                                RedirectAttributes ra) {
        User currentUser = (User) session.getAttribute("user");
        
        // Gọi service để cập nhật (giả sử avatar để tạm là cái cũ)
        boolean success = userService.updateProfile(currentUser.getId(), fullname);
        
        if (success) {
            // Cập nhật lại thông tin trong Session để giao diện hiển thị tên mới ngay lập tức
            currentUser.setFullname(fullname);
            session.setAttribute("user", currentUser);
            ra.addFlashAttribute("message", "Cập nhật hồ sơ thành công!");
        } else {
            ra.addFlashAttribute("error", "Có lỗi xảy ra, vui lòng thử lại.");
        }
        return "redirect:/profile/";
    }
	
	@PostMapping("/update-avatar")
	public String updateAvatar(@RequestParam("file") MultipartFile file, 
	                           HttpSession session, 
	                           RedirectAttributes ra) {
	    if (file.isEmpty()) {
	        ra.addFlashAttribute("error", "Vui lòng chọn một hình ảnh.");
	        return "redirect:/profile/";
	    }

	    try {
	        User currentUser = (User) session.getAttribute("user");
	        String uploadDir = session.getServletContext().getRealPath("/resources/images/");
	        
	        // Tạo tên file duy nhất để tránh trùng lặp
	        String fileName = "avatar_" + currentUser.getId() + "_" + System.currentTimeMillis() + "_" + file.getOriginalFilename();
	        
	        // Tạo file vật lý trên server
	        File serverFile = new File(uploadDir + File.separator + fileName);
	        file.transferTo(serverFile); // Lưu file

	        // Cập nhật vào Database
	        boolean success = userService.updateAvatar(currentUser.getId(), fileName);

	        if (success) {
	            currentUser.setAvatar(fileName);
	            session.setAttribute("user", currentUser);
	            ra.addFlashAttribute("message", "Cập nhật ảnh đại diện thành công!");
	        } else {
	            ra.addFlashAttribute("error", "Lỗi cập nhật cơ sở dữ liệu.");
	        }

	    } catch (IOException e) {
	        e.printStackTrace();
	        ra.addFlashAttribute("error", "Lỗi khi lưu file: " + e.getMessage());
	    }

	    return "redirect:/profile/";
	}
	
	@PostMapping("/change-password")
    public String changePassword(@RequestParam("oldPassword") String oldPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 HttpSession session,
                                 RedirectAttributes ra) {
        User currentUser = (User) session.getAttribute("user");
        
        boolean success = userService.changePassword(currentUser.getId(), oldPassword, newPassword);
        
        if (success) {
            ra.addFlashAttribute("message", "Đổi mật khẩu thành công!");
        } else {
            ra.addFlashAttribute("error", "Mật khẩu cũ không chính xác.");
        }
        return "redirect:/profile/";
    }
	
}
