package com.cuoi_ky.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Authentication Interceptor
 * Intercepts requests to protected pages and checks if user is logged in
 */
public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession(false);

        // Avoid url /api/translate/health
        System.out.println("Request URI: " + request.getRequestURI());
        if (request.getRequestURI().contains("/api/translate/health")) {
            return true;
        }

        // Check if user is logged in
        if (session == null || session.getAttribute("userId") == null) {
            // User not logged in, redirect to login page
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return false;
        }

        // User is logged in, allow request to continue
        return true;
    }
}
