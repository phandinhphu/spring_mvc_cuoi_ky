package com.cuoi_ky.service;

/**
 * Service để lấy ngữ cảnh (context) từ cơ sở dữ liệu cho RAG
 */
public interface RAGService {

    /**
     * Tìm kiếm thông tin liên quan từ database dựa trên câu hỏi của người dùng
     * 
     * @param query Câu hỏi của người dùng
     * @return Chuỗi text chứa thông tin ngữ cảnh
     */
    String findContext(String query);
}
