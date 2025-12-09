-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.4.3 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for japanese_app
CREATE DATABASE IF NOT EXISTS `japanese_app` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `japanese_app`;

-- Dumping structure for table japanese_app.daily_streak
CREATE TABLE IF NOT EXISTS `daily_streak` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `learned_words` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `daily_streak_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table japanese_app.daily_streak: ~0 rows (approximately)

-- Dumping structure for table japanese_app.examples
CREATE TABLE IF NOT EXISTS `examples` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vocab_id` int DEFAULT NULL,
  `example_sentence` text COLLATE utf8mb4_unicode_ci,
  `translation` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `vocab_id` (`vocab_id`),
  CONSTRAINT `examples_ibfk_1` FOREIGN KEY (`vocab_id`) REFERENCES `vocabulary` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table japanese_app.examples: ~6 rows (approximately)
INSERT INTO `examples` (`id`, `vocab_id`, `example_sentence`, `translation`) VALUES
	(1, 1, 'ねこがすきです。', 'Tôi thích mèo.'),
	(2, 1, 'そのねこはかわいいです。', 'Con mèo đó dễ thương.'),
	(3, 2, 'いぬをかっています。', 'Tôi đang nuôi một con chó.'),
	(4, 3, 'みずをのみます。', 'Tôi uống nước.'),
	(5, 4, 'あのひとはせんせいです。', 'Người kia là giáo viên.'),
	(6, 5, 'がくせいですか。', 'Bạn có phải là sinh viên không?');

-- Dumping structure for table japanese_app.practice_history
CREATE TABLE IF NOT EXISTS `practice_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_vocab_id` int DEFAULT NULL,
  `practice_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `correct_count` int DEFAULT '0',
  `wrong_count` int DEFAULT '0',
  `mode` enum('quiz','listening','fill') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_vocab_id` (`user_vocab_id`),
  CONSTRAINT `practice_history_ibfk_1` FOREIGN KEY (`user_vocab_id`) REFERENCES `user_vocab` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table japanese_app.practice_history: ~0 rows (approximately)

-- Dumping structure for table japanese_app.quiz_questions
CREATE TABLE IF NOT EXISTS `quiz_questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vocab_id` int DEFAULT NULL,
  `question_text` text COLLATE utf8mb4_unicode_ci,
  `option_a` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `option_b` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `option_c` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `option_d` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correct_answer` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vocab_id` (`vocab_id`),
  CONSTRAINT `quiz_questions_ibfk_1` FOREIGN KEY (`vocab_id`) REFERENCES `vocabulary` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table japanese_app.quiz_questions: ~0 rows (approximately)

-- Dumping structure for table japanese_app.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table japanese_app.users: ~3 rows (approximately)
INSERT INTO `users` (`id`, `username`, `password`, `email`, `created_at`) VALUES
	(1, 'phu', '123456', 'phu@example.com', '2025-12-01 17:20:07'),
	(2, 'admin', 'admin123', 'admin@example.com', '2025-12-01 17:20:07'),
	(3, 'user1', 'pass123', 'user1@example.com', '2025-12-01 17:20:07'),
	(4, 'John Doe', 'quocnaru123', 'phuphandinh2004@gmail.com', '2025-12-01 12:25:11');

-- Dumping structure for table japanese_app.user_vocab
CREATE TABLE IF NOT EXISTS `user_vocab` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `vocab_id` int DEFAULT NULL,
  `status` enum('active','sleep') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `added_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `vocab_id` (`vocab_id`),
  CONSTRAINT `user_vocab_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_vocab_ibfk_2` FOREIGN KEY (`vocab_id`) REFERENCES `vocabulary` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table japanese_app.user_vocab: ~0 rows (approximately)

-- Dumping structure for table japanese_app.vocabulary
CREATE TABLE IF NOT EXISTS `vocabulary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `word` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meaning` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `romaji` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hiragana` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `katakana` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kanji` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `audio_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table japanese_app.vocabulary: ~200 rows (approximately)
INSERT INTO `vocabulary` (`id`, `word`, `meaning`, `romaji`, `hiragana`, `katakana`, `kanji`, `audio_url`, `created_at`) VALUES
	(1, 'ねこ', 'Con mèo', 'neko', 'ねこ', NULL, '猫', NULL, '2025-12-01 17:20:35'),
	(2, 'いぬ', 'Con chó', 'inu', 'いぬ', NULL, '犬', NULL, '2025-12-01 17:20:35'),
	(3, 'とり', 'Con chim', 'tori', 'とり', NULL, '鳥', NULL, '2025-12-01 17:20:35'),
	(4, 'さかな', 'Con cá', 'sakana', 'さかな', NULL, '魚', NULL, '2025-12-01 17:20:35'),
	(5, 'うま', 'Con ngựa', 'uma', 'うま', NULL, '馬', NULL, '2025-12-01 17:20:35'),
	(6, 'ぶた', 'Con heo', 'buta', 'ぶた', NULL, '豚', NULL, '2025-12-01 17:20:35'),
	(7, 'き', 'Cây', 'ki', 'き', NULL, '木', NULL, '2025-12-01 17:20:35'),
	(8, 'はな', 'Hoa', 'hana', 'はな', NULL, '花', NULL, '2025-12-01 17:20:35'),
	(9, 'みず', 'Nước', 'mizu', 'みず', NULL, '水', NULL, '2025-12-01 17:20:35'),
	(10, 'ひ', 'Lửa', 'hi', 'ひ', NULL, '火', NULL, '2025-12-01 17:20:35'),
	(11, 'つき', 'Mặt trăng', 'tsuki', 'つき', NULL, '月', NULL, '2025-12-01 17:20:35'),
	(12, 'たいよう', 'Mặt trời', 'taiyou', 'たいよう', NULL, '太陽', NULL, '2025-12-01 17:20:35'),
	(13, 'やま', 'Núi', 'yama', 'やま', NULL, '山', NULL, '2025-12-01 17:20:35'),
	(14, 'かわ', 'Sông', 'kawa', 'かわ', NULL, '川', NULL, '2025-12-01 17:20:35'),
	(15, 'そら', 'Bầu trời', 'sora', 'そら', NULL, '空', NULL, '2025-12-01 17:20:35'),
	(16, 'くも', 'Mây', 'kumo', 'くも', NULL, '雲', NULL, '2025-12-01 17:20:35'),
	(17, 'かぜ', 'Gió', 'kaze', 'かぜ', NULL, '風', NULL, '2025-12-01 17:20:35'),
	(18, 'あめ', 'Mưa', 'ame', 'あめ', NULL, '雨', NULL, '2025-12-01 17:20:35'),
	(19, 'ゆき', 'Tuyết', 'yuki', 'ゆき', NULL, '雪', NULL, '2025-12-01 17:20:35'),
	(20, 'うみ', 'Biển', 'umi', 'うみ', NULL, '海', NULL, '2025-12-01 17:20:35'),
	(21, 'ひ', 'Ngày', 'hi', 'ひ', NULL, '日', NULL, '2025-12-01 17:20:40'),
	(22, 'とき', 'Thời gian', 'toki', 'とき', NULL, '時', NULL, '2025-12-01 17:20:40'),
	(23, 'あさ', 'Buổi sáng', 'asa', 'あさ', NULL, '朝', NULL, '2025-12-01 17:20:40'),
	(24, 'ひる', 'Buổi trưa', 'hiru', 'ひる', NULL, '昼', NULL, '2025-12-01 17:20:40'),
	(25, 'よる', 'Buổi tối', 'yoru', 'よる', NULL, '夜', NULL, '2025-12-01 17:20:40'),
	(26, 'きょう', 'Hôm nay', 'kyou', 'きょう', NULL, '今日', NULL, '2025-12-01 17:20:40'),
	(27, 'あした', 'Ngày mai', 'ashita', 'あした', NULL, '明日', NULL, '2025-12-01 17:20:40'),
	(28, 'きのう', 'Hôm qua', 'kinou', 'きのう', NULL, '昨日', NULL, '2025-12-01 17:20:40'),
	(29, 'げつようび', 'Thứ hai', 'getsuyoubi', 'げつようび', NULL, '月曜日', NULL, '2025-12-01 17:20:40'),
	(30, 'かようび', 'Thứ ba', 'kayoubi', 'かようび', NULL, '火曜日', NULL, '2025-12-01 17:20:40'),
	(31, 'すいようび', 'Thứ tư', 'suiyoubi', 'すいようび', NULL, '水曜日', NULL, '2025-12-01 17:20:40'),
	(32, 'もくようび', 'Thứ năm', 'mokuyoubi', 'もくようび', NULL, '木曜日', NULL, '2025-12-01 17:20:40'),
	(33, 'きんようび', 'Thứ sáu', 'kinyoubi', 'きんようび', NULL, '金曜日', NULL, '2025-12-01 17:20:40'),
	(34, 'どようび', 'Thứ bảy', 'doyoubi', 'どようび', NULL, '土曜日', NULL, '2025-12-01 17:20:40'),
	(35, 'にちようび', 'Chủ nhật', 'nichiyoubi', 'にちようび', NULL, '日曜日', NULL, '2025-12-01 17:20:40'),
	(36, 'じかん', 'Giờ', 'jikan', 'じかん', NULL, '時間', NULL, '2025-12-01 17:20:40'),
	(37, 'ふん', 'Phút', 'fun', 'ふん', NULL, '分', NULL, '2025-12-01 17:20:40'),
	(38, 'しゅう', 'Tuần', 'shuu', 'しゅう', NULL, '週', NULL, '2025-12-01 17:20:40'),
	(39, 'つき', 'Tháng', 'tsuki', 'つき', NULL, '月', NULL, '2025-12-01 17:20:40'),
	(40, 'とし', 'Năm', 'toshi', 'とし', NULL, '年', NULL, '2025-12-01 17:20:40'),
	(41, 'ひと', 'Người', 'hito', 'ひと', NULL, '人', NULL, '2025-12-01 17:20:44'),
	(42, 'おとこ', 'Đàn ông', 'otoko', 'おとこ', NULL, '男', NULL, '2025-12-01 17:20:44'),
	(43, 'おんな', 'Phụ nữ', 'onna', 'おんな', NULL, '女', NULL, '2025-12-01 17:20:44'),
	(44, 'こども', 'Trẻ em', 'kodomo', 'こども', NULL, '子供', NULL, '2025-12-01 17:20:44'),
	(45, 'かぞく', 'Gia đình', 'kazoku', 'かぞく', NULL, '家族', NULL, '2025-12-01 17:20:44'),
	(46, 'ちち', 'Bố', 'chichi', 'ちち', NULL, '父', NULL, '2025-12-01 17:20:44'),
	(47, 'はは', 'Mẹ', 'haha', 'はは', NULL, '母', NULL, '2025-12-01 17:20:44'),
	(48, 'あに', 'Anh trai', 'ani', 'あに', NULL, '兄', NULL, '2025-12-01 17:20:44'),
	(49, 'あね', 'Chị gái', 'ane', 'あね', NULL, '姉', NULL, '2025-12-01 17:20:44'),
	(50, 'おとうと', 'Em trai', 'otouto', 'おとうと', NULL, '弟', NULL, '2025-12-01 17:20:44'),
	(51, 'いもうと', 'Em gái', 'imouto', 'いもうと', NULL, '妹', NULL, '2025-12-01 17:20:44'),
	(52, 'そふ', 'Ông', 'sofu', 'そふ', NULL, '祖父', NULL, '2025-12-01 17:20:44'),
	(53, 'そぼ', 'Bà', 'sobo', 'そぼ', NULL, '祖母', NULL, '2025-12-01 17:20:44'),
	(54, 'ともだち', 'Bạn bè', 'tomodachi', 'ともだち', NULL, '友達', NULL, '2025-12-01 17:20:44'),
	(55, 'せんせい', 'Giáo viên', 'sensei', 'せんせい', NULL, '先生', NULL, '2025-12-01 17:20:44'),
	(56, 'がくせい', 'Sinh viên', 'gakusei', 'がくせい', NULL, '学生', NULL, '2025-12-01 17:20:44'),
	(57, 'かいしゃいん', 'Nhân viên công ty', 'kaishain', 'かいしゃいん', NULL, '会社員', NULL, '2025-12-01 17:20:44'),
	(58, 'いしゃ', 'Bác sĩ', 'isha', 'いしゃ', NULL, '医者', NULL, '2025-12-01 17:20:44'),
	(59, 'てんいん', 'Nhân viên bán hàng', 'tenin', 'てんいん', NULL, '店員', NULL, '2025-12-01 17:20:44'),
	(60, 'しゅふ', 'Nội trợ', 'shufu', 'しゅふ', NULL, '主婦', NULL, '2025-12-01 17:20:44'),
	(61, 'たべる', 'Ăn', 'taberu', 'たべる', NULL, '食べる', NULL, '2025-12-01 17:20:49'),
	(62, 'のむ', 'Uống', 'nomu', 'のむ', NULL, '飲む', NULL, '2025-12-01 17:20:49'),
	(63, 'みる', 'Nhìn, xem', 'miru', 'みる', NULL, '見る', NULL, '2025-12-01 17:20:49'),
	(64, 'きく', 'Nghe', 'kiku', 'きく', NULL, '聞く', NULL, '2025-12-01 17:20:49'),
	(65, 'よむ', 'Đọc', 'yomu', 'よむ', NULL, '読む', NULL, '2025-12-01 17:20:49'),
	(66, 'かく', 'Viết', 'kaku', 'かく', NULL, '書く', NULL, '2025-12-01 17:20:49'),
	(67, 'はなす', 'Nói chuyện', 'hanasu', 'はなす', NULL, '話す', NULL, '2025-12-01 17:20:49'),
	(68, 'いく', 'Đi', 'iku', 'いく', NULL, '行く', NULL, '2025-12-01 17:20:49'),
	(69, 'くる', 'Đến', 'kuru', 'くる', NULL, '来る', NULL, '2025-12-01 17:20:49'),
	(70, 'かえる', 'Về', 'kaeru', 'かえる', NULL, '帰る', NULL, '2025-12-01 17:20:49'),
	(71, 'ねる', 'Ngủ', 'neru', 'ねる', NULL, '寝る', NULL, '2025-12-01 17:20:49'),
	(72, 'おきる', 'Thức dậy', 'okiru', 'おきる', NULL, '起きる', NULL, '2025-12-01 17:20:49'),
	(73, 'あう', 'Gặp', 'au', 'あう', NULL, '会う', NULL, '2025-12-01 17:20:49'),
	(74, 'あるく', 'Đi bộ', 'aruku', 'あるく', NULL, '歩く', NULL, '2025-12-01 17:20:49'),
	(75, 'はしる', 'Chạy', 'hashiru', 'はしる', NULL, '走る', NULL, '2025-12-01 17:20:49'),
	(76, 'いれる', 'Cho vào', 'ireru', 'いれる', NULL, '入れる', NULL, '2025-12-01 17:20:49'),
	(77, 'でる', 'Đi ra', 'deru', 'でる', NULL, '出る', NULL, '2025-12-01 17:20:49'),
	(78, 'つくる', 'Làm, chế tạo', 'tsukuru', 'つくる', NULL, '作る', NULL, '2025-12-01 17:20:49'),
	(79, 'かう', 'Mua', 'kau', 'かう', NULL, '買う', NULL, '2025-12-01 17:20:49'),
	(80, 'うる', 'Bán', 'uru', 'うる', NULL, '売る', NULL, '2025-12-01 17:20:49'),
	(81, 'おおきい', 'To, lớn', 'ookii', 'おおきい', NULL, '大きい', NULL, '2025-12-01 17:24:05'),
	(82, 'ちいさい', 'Nhỏ', 'chiisai', 'ちいさい', NULL, '小さい', NULL, '2025-12-01 17:24:05'),
	(83, 'たかい', 'Cao; đắt', 'takai', 'たかい', NULL, '高い', NULL, '2025-12-01 17:24:05'),
	(84, 'やすい', 'Rẻ', 'yasui', 'やすい', NULL, '安い', NULL, '2025-12-01 17:24:05'),
	(85, 'あつい', 'Nóng', 'atsui', 'あつい', NULL, '暑い', NULL, '2025-12-01 17:24:05'),
	(86, 'さむい', 'Lạnh', 'samui', 'さむい', NULL, '寒い', NULL, '2025-12-01 17:24:05'),
	(87, 'ながい', 'Dài', 'nagai', 'ながい', NULL, '長い', NULL, '2025-12-01 17:24:05'),
	(88, 'みじかい', 'Ngắn', 'mijikai', 'みじかい', NULL, '短い', NULL, '2025-12-01 17:24:05'),
	(89, 'あたらしい', 'Mới', 'atarashii', 'あたらしい', NULL, '新しい', NULL, '2025-12-01 17:24:05'),
	(90, 'ふるい', 'Cũ', 'furui', 'ふるい', NULL, '古い', NULL, '2025-12-01 17:24:05'),
	(91, 'やさしい', 'Dễ; hiền', 'yasashii', 'やさしい', NULL, '優しい', NULL, '2025-12-01 17:24:05'),
	(92, 'むずかしい', 'Khó', 'muzukashii', 'むずかしい', NULL, '難しい', NULL, '2025-12-01 17:24:05'),
	(93, 'きれい', 'Đẹp; sạch', 'kirei', 'きれい', NULL, '綺麗', NULL, '2025-12-01 17:24:05'),
	(94, 'しずか', 'Yên tĩnh', 'shizuka', 'しずか', NULL, '静か', NULL, '2025-12-01 17:24:05'),
	(95, 'にぎやか', 'Nhộn nhịp', 'nigiyaka', 'にぎやか', NULL, '賑やか', NULL, '2025-12-01 17:24:05'),
	(96, 'げんき', 'Khỏe mạnh', 'genki', 'げんき', NULL, '元気', NULL, '2025-12-01 17:24:05'),
	(97, 'べんり', 'Tiện lợi', 'benri', 'べんり', NULL, '便利', NULL, '2025-12-01 17:24:05'),
	(98, 'ゆうめい', 'Nổi tiếng', 'yuumei', 'ゆうめい', NULL, '有名', NULL, '2025-12-01 17:24:05'),
	(99, 'すき', 'Thích', 'suki', 'すき', NULL, '好き', NULL, '2025-12-01 17:24:05'),
	(100, 'きらい', 'Ghét', 'kirai', 'きらい', NULL, '嫌い', NULL, '2025-12-01 17:24:05'),
	(101, 'ほん', 'Sách', 'hon', 'ほん', NULL, '本', NULL, '2025-12-01 17:24:10'),
	(102, 'じしょ', 'Từ điển', 'jisho', 'じしょ', NULL, '辞書', NULL, '2025-12-01 17:24:10'),
	(103, 'かみ', 'Giấy', 'kami', 'かみ', NULL, '紙', NULL, '2025-12-01 17:24:10'),
	(104, 'えんぴつ', 'Bút chì', 'enpitsu', 'えんぴつ', NULL, '鉛筆', NULL, '2025-12-01 17:24:10'),
	(105, 'ペン', 'Bút mực', 'pen', NULL, 'ペン', NULL, NULL, '2025-12-01 17:24:10'),
	(106, 'つくえ', 'Cái bàn', 'tsukue', 'つくえ', NULL, '机', NULL, '2025-12-01 17:24:10'),
	(107, 'いす', 'Cái ghế', 'isu', 'いす', NULL, '椅子', NULL, '2025-12-01 17:24:10'),
	(108, 'かばん', 'Cặp, túi', 'kaban', 'かばん', NULL, '鞄', NULL, '2025-12-01 17:24:10'),
	(109, 'でんわ', 'Điện thoại', 'denwa', 'でんわ', NULL, '電話', NULL, '2025-12-01 17:24:10'),
	(110, 'パソコン', 'Máy tính', 'pasokon', NULL, 'パソコン', NULL, NULL, '2025-12-01 17:24:10'),
	(111, 'くるま', 'Xe hơi', 'kuruma', 'くるま', NULL, '車', NULL, '2025-12-01 17:24:10'),
	(112, 'じてんしゃ', 'Xe đạp', 'jitensha', 'じてんしゃ', NULL, '自転車', NULL, '2025-12-01 17:24:10'),
	(113, 'くつ', 'Giày', 'kutsu', 'くつ', NULL, '靴', NULL, '2025-12-01 17:24:10'),
	(114, 'ふく', 'Quần áo', 'fuku', 'ふく', NULL, '服', NULL, '2025-12-01 17:24:10'),
	(115, 'かさ', 'Ô (dù)', 'kasa', 'かさ', NULL, '傘', NULL, '2025-12-01 17:24:10'),
	(116, 'かぎ', 'Chìa khóa', 'kagi', 'かぎ', NULL, '鍵', NULL, '2025-12-01 17:24:10'),
	(117, 'とけい', 'Đồng hồ', 'tokei', 'とけい', NULL, '時計', NULL, '2025-12-01 17:24:10'),
	(118, 'めがね', 'Kính mắt', 'megane', 'めがね', NULL, '眼鏡', NULL, '2025-12-01 17:24:10'),
	(119, 'てがみ', 'Thư', 'tegami', 'てがみ', NULL, '手紙', NULL, '2025-12-01 17:24:10'),
	(120, 'こづつみ', 'Bưu kiện', 'kozutsumi', 'こづつみ', NULL, '小包', NULL, '2025-12-01 17:24:10'),
	(121, 'がっこう', 'Trường học', 'gakkou', 'がっこう', NULL, '学校', NULL, '2025-12-01 17:24:17'),
	(122, 'だいがく', 'Đại học', 'daigaku', 'だいがく', NULL, '大学', NULL, '2025-12-01 17:24:17'),
	(123, 'こうこう', 'Trường cấp 3', 'koukou', 'こうこう', NULL, '高校', NULL, '2025-12-01 17:24:17'),
	(124, 'いえ', 'Nhà', 'ie', 'いえ', NULL, '家', NULL, '2025-12-01 17:24:17'),
	(125, 'うち', 'Nhà (của tôi)', 'uchi', 'うち', NULL, NULL, NULL, '2025-12-01 17:24:17'),
	(126, 'みせ', 'Cửa hàng', 'mise', 'みせ', NULL, '店', NULL, '2025-12-01 17:24:17'),
	(127, 'ぎんこう', 'Ngân hàng', 'ginkou', 'ぎんこう', NULL, '銀行', NULL, '2025-12-01 17:24:17'),
	(128, 'ゆうびんきょく', 'Bưu điện', 'yuubinkyoku', 'ゆうびんきょく', NULL, '郵便局', NULL, '2025-12-01 17:24:17'),
	(129, 'びょういん', 'Bệnh viện', 'byouin', 'びょういん', NULL, '病院', NULL, '2025-12-01 17:24:17'),
	(130, 'えき', 'Nhà ga', 'eki', 'えき', NULL, '駅', NULL, '2025-12-01 17:24:17'),
	(131, 'くうこう', 'Sân bay', 'kuukou', 'くうこう', NULL, '空港', NULL, '2025-12-01 17:24:17'),
	(132, 'まち', 'Thành phố', 'machi', 'まち', NULL, '町', NULL, '2025-12-01 17:24:17'),
	(133, 'としょかん', 'Thư viện', 'toshokan', 'としょかん', NULL, '図書館', NULL, '2025-12-01 17:24:17'),
	(134, 'レストラン', 'Nhà hàng', 'resutoran', NULL, 'レストラン', NULL, NULL, '2025-12-01 17:24:17'),
	(135, 'ホテル', 'Khách sạn', 'hoteru', NULL, 'ホテル', NULL, NULL, '2025-12-01 17:24:17'),
	(136, 'こうえん', 'Công viên', 'kouen', 'こうえん', NULL, '公園', NULL, '2025-12-01 17:24:17'),
	(137, 'プール', 'Hồ bơi', 'puuru', NULL, 'プール', NULL, NULL, '2025-12-01 17:24:17'),
	(138, 'ぎんこう', 'Ngân hàng', 'ginkou', 'ぎんこう', NULL, '銀行', NULL, '2025-12-01 17:24:17'),
	(139, 'やま', 'Núi', 'yama', 'やま', NULL, '山', NULL, '2025-12-01 17:24:17'),
	(140, 'かわ', 'Sông', 'kawa', 'かわ', NULL, '川', NULL, '2025-12-01 17:24:17'),
	(141, 'こんにちは', 'Xin chào', 'konnichiwa', 'こんにちは', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(142, 'おはよう', 'Chào buổi sáng', 'ohayou', 'おはよう', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(143, 'こんばんは', 'Chào buổi tối', 'konbanwa', 'こんばんは', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(144, 'さようなら', 'Tạm biệt', 'sayounara', 'さようなら', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(145, 'ありがとう', 'Cảm ơn', 'arigatou', 'ありがとう', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(146, 'すみません', 'Xin lỗi; cảm phiền', 'sumimasen', 'すみません', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(147, 'はい', 'Vâng', 'hai', 'はい', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(148, 'いいえ', 'Không', 'iie', 'いいえ', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(149, 'もしもし', 'Alo', 'moshimoshi', 'もしもし', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(150, 'がんばって', 'Cố lên', 'ganbatte', 'がんばって', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(151, 'どういたしまして', 'Không có gì', 'douitashimashite', 'どういたしまして', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(152, 'はじめまして', 'Rất vui được gặp bạn', 'hajimemashite', 'はじめまして', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(153, 'どうぞ', 'Xin mời', 'douzo', 'どうぞ', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(154, 'どうも', 'Cảm ơn/ Xin lỗi nhẹ', 'doumo', 'どうも', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(155, 'わかりました', 'Tôi hiểu rồi', 'wakarimashita', 'わかりました', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(156, 'わかりません', 'Tôi không hiểu', 'wakarimasen', 'わかりません', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(157, 'お願いします', 'Làm ơn', 'onegaishimasu', 'おねがいします', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(158, 'ごめんなさい', 'Xin lỗi', 'gomennasai', 'ごめんなさい', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(159, 'ちょっと', 'Một chút', 'chotto', 'ちょっと', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(160, 'だいじょうぶ', 'Ổn', 'daijoubu', 'だいじょうぶ', NULL, NULL, NULL, '2025-12-01 17:24:24'),
	(161, '経験', 'Kinh nghiệm', 'keiken', 'けいけん', NULL, '経験', NULL, '2025-12-01 17:24:30'),
	(162, '予定', 'Kế hoạch, dự định', 'yotei', 'よてい', NULL, '予定', NULL, '2025-12-01 17:24:30'),
	(163, '文化', 'Văn hóa', 'bunka', 'ぶんか', NULL, '文化', NULL, '2025-12-01 17:24:30'),
	(164, '社会', 'Xã hội', 'shakai', 'しゃかい', NULL, '社会', NULL, '2025-12-01 17:24:30'),
	(165, '工場', 'Nhà máy', 'koujou', 'こうじょう', NULL, '工場', NULL, '2025-12-01 17:24:30'),
	(166, '技術', 'Kỹ thuật', 'gijutsu', 'ぎじゅつ', NULL, '技術', NULL, '2025-12-01 17:24:30'),
	(167, '医学', 'Y học', 'igaku', 'いがく', NULL, '医学', NULL, '2025-12-01 17:24:30'),
	(168, '法律', 'Luật pháp', 'houritsu', 'ほうりつ', NULL, '法律', NULL, '2025-12-01 17:24:30'),
	(169, '政治', 'Chính trị', 'seiji', 'せいじ', NULL, '政治', NULL, '2025-12-01 17:24:30'),
	(170, '自然', 'Tự nhiên', 'shizen', 'しぜん', NULL, '自然', NULL, '2025-12-01 17:24:30'),
	(171, '安全', 'An toàn', 'anzen', 'あんぜん', NULL, '安全', NULL, '2025-12-01 17:24:30'),
	(172, '危険', 'Nguy hiểm', 'kiken', 'きけん', NULL, '危険', NULL, '2025-12-01 17:24:30'),
	(173, '必要', 'Cần thiết', 'hitsuyou', 'ひつよう', NULL, '必要', NULL, '2025-12-01 17:24:30'),
	(174, '自由', 'Tự do', 'jiyuu', 'じゆう', NULL, '自由', NULL, '2025-12-01 17:24:30'),
	(175, '場合', 'Trường hợp', 'baai', 'ばあい', NULL, '場合', NULL, '2025-12-01 17:24:30'),
	(176, '理由', 'Lý do', 'riyuu', 'りゆう', NULL, '理由', NULL, '2025-12-01 17:24:30'),
	(177, '方法', 'Phương pháp', 'houhou', 'ほうほう', NULL, '方法', NULL, '2025-12-01 17:24:30'),
	(178, '資料', 'Tài liệu', 'shiryou', 'しりょう', NULL, '資料', NULL, '2025-12-01 17:24:30'),
	(179, '連絡', 'Liên lạc', 'renraku', 'れんらく', NULL, '連絡', NULL, '2025-12-01 17:24:30'),
	(180, '住所', 'Địa chỉ', 'juusho', 'じゅうしょ', NULL, '住所', NULL, '2025-12-01 17:24:30'),
	(181, '説明', 'Giải thích', 'setsumei', 'せつめい', NULL, '説明', NULL, '2025-12-01 17:24:30'),
	(182, '準備', 'Chuẩn bị', 'junbi', 'じゅんび', NULL, '準備', NULL, '2025-12-01 17:24:30'),
	(183, '会議', 'Hội họp', 'kaigi', 'かいぎ', NULL, '会議', NULL, '2025-12-01 17:24:30'),
	(184, '約束', 'Lời hứa', 'yakusoku', 'やくそく', NULL, '約束', NULL, '2025-12-01 17:24:30'),
	(185, '経験する', 'Trải nghiệm', 'keiken suru', 'けいけんする', NULL, '経験する', NULL, '2025-12-01 17:24:30'),
	(186, '連れていく', 'Dẫn đi', 'tsureteiku', 'つれていく', NULL, '連れて行く', NULL, '2025-12-01 17:24:30'),
	(187, '選ぶ', 'Chọn', 'erabu', 'えらぶ', NULL, '選ぶ', NULL, '2025-12-01 17:24:30'),
	(188, '比べる', 'So sánh', 'kuraberu', 'くらべる', NULL, '比べる', NULL, '2025-12-01 17:24:30'),
	(189, '調べる', 'Tra cứu, điều tra', 'shiraberu', 'しらべる', NULL, '調べる', NULL, '2025-12-01 17:24:30'),
	(190, '手伝う', 'Giúp đỡ', 'tetsudau', 'てつだう', NULL, '手伝う', NULL, '2025-12-01 17:24:30'),
	(191, '足りる', 'Đủ', 'tariru', 'たりる', NULL, '足りる', NULL, '2025-12-01 17:24:30'),
	(192, '増える', 'Tăng lên', 'fueru', 'ふえる', NULL, '増える', NULL, '2025-12-01 17:24:30'),
	(193, '減る', 'Giảm xuống', 'heru', 'へる', NULL, '減る', NULL, '2025-12-01 17:24:30'),
	(194, '残る', 'Còn lại', 'nokoru', 'のこる', NULL, '残る', NULL, '2025-12-01 17:24:30'),
	(195, '決める', 'Quyết định', 'kimeru', 'きめる', NULL, '決める', NULL, '2025-12-01 17:24:30'),
	(196, '習う', 'Học (từ ai đó)', 'narau', 'ならう', NULL, '習う', NULL, '2025-12-01 17:24:30'),
	(197, '育てる', 'Nuôi dưỡng', 'sodateru', 'そだてる', NULL, '育てる', NULL, '2025-12-01 17:24:30'),
	(198, '働く', 'Làm việc', 'hataraku', 'はたらく', NULL, '働く', NULL, '2025-12-01 17:24:30'),
	(199, '始める', 'Bắt đầu', 'hajimeru', 'はじめる', NULL, '始める', NULL, '2025-12-01 17:24:30'),
	(200, '終わる', 'Kết thúc', 'owaru', 'おわる', NULL, '終わる', NULL, '2025-12-01 17:24:30');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
