package com.cuoi_ky.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

@Configuration
@ComponentScan(basePackages = "com.cuoi_ky")
public class AppConfig {
	@Bean(name = "multipartResolver")
	public CommonsMultipartResolver multipartResolver() {
	    CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
	    
	    // Thiết lập kích thước tối đa của file
	    multipartResolver.setMaxUploadSize(5 * 1024 * 1024); 
	    
	    // Thiết lập bảng mã để tránh lỗi tiếng Việt trong tên file
	    multipartResolver.setDefaultEncoding("UTF-8");
	    
	    return multipartResolver;
	}
}