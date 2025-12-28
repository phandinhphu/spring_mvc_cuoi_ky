package com.cuoi_ky.service;

import com.cuoi_ky.model.DailyStreak;
import java.util.Date;
import java.util.List;
import java.util.Optional;

public interface DailyStreakService {
    // Tạo mới hoặc cập nhật chuỗi hàng ngày khi người dùng thực hành
    boolean recordPracticeToday(Integer userId, Integer wordsLearned);
}
