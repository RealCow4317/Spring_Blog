-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        11.4.5-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- blog_db 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `blog_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `blog_db`;

-- 테이블 blog_db.board 구조 내보내기
CREATE TABLE IF NOT EXISTS `board` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `writer` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `category_id` int(11) DEFAULT NULL,
  `pinned` tinyint(1) DEFAULT 0,
  `image` varchar(255) DEFAULT NULL,
  `thumbnail` varchar(500) DEFAULT NULL,
  `views` int(11) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_board_category` (`category_id`) USING BTREE,
  CONSTRAINT `fk_board_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=616 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 blog_db.board:~4 rows (대략적) 내보내기
INSERT INTO `board` (`id`, `title`, `content`, `writer`, `created_at`, `category_id`, `pinned`, `image`, `thumbnail`, `views`) VALUES
	(612, '바탕화면이다', '<p><img src="/upload/35d105a8-af6d-4418-a959-1fbd99700e5a_Screenshot 2025-05-12 223602.png" style="width: 1225.71px;"><br></p>', 'admin', '2025-05-14 15:48:34', 8, 0, NULL, '/upload/35d105a8-af6d-4418-a959-1fbd99700e5a_Screenshot 2025-05-12 223602.png', 41),
	(613, '오늘 일상 공유', '<p>안녕하세요 오늘 하루 공유해요~~~<img style="width: 459px;" src="/upload/06a1379b-e178-419b-98e6-6acd88533895_20250920_130652.jpg"></p>', 'admin', '2025-10-13 23:18:47', 9, 0, NULL, '/upload/06a1379b-e178-419b-98e6-6acd88533895_20250920_130652.jpg', 38),
	(614, '이미지 파일 업로드!!', '<p><img src="/upload/ba4e2939-0767-4f59-afd2-9ff9c076fb35_20250920_130720.jpg" style="width: 1225.71px;"><br></p>', 'admin', '2025-10-20 10:02:03', 8, 0, NULL, '/upload/ba4e2939-0767-4f59-afd2-9ff9c076fb35_20250920_130720.jpg', 3),
	(615, '공지입니다', '공지입니다', 'admin', '2025-10-21 23:49:16', 8, 1, NULL, NULL, 2);

-- 테이블 blog_db.category 구조 내보내기
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 blog_db.category:~0 rows (대략적) 내보내기
INSERT INTO `category` (`id`, `name`) VALUES
	(8, '공지사항'),
	(9, '일상');

-- 테이블 blog_db.comment 구조 내보내기
CREATE TABLE IF NOT EXISTS `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `board_id` int(11) NOT NULL,
  `writer` varchar(100) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `content` text NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `board_id` (`board_id`) USING BTREE,
  KEY `fk_comment_parent` (`parent_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`board_id`) REFERENCES `board` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_comment_parent` FOREIGN KEY (`parent_id`) REFERENCES `comment` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 blog_db.comment:~3 rows (대략적) 내보내기
INSERT INTO `comment` (`id`, `board_id`, `writer`, `parent_id`, `content`, `created_at`) VALUES
	(27, 613, 'bjw8518', NULL, 'asdasdsadasd', '2025-10-13 23:30:01'),
	(34, 613, 'admin', NULL, '11111', '2025-10-13 23:46:45'),
	(36, 613, 'bjw8518', 27, '1뎁스', '2025-10-13 23:54:39'),
	(37, 613, 'bjw8518', 36, '2뎁스', '2025-10-13 23:54:44');

-- 테이블 blog_db.image 구조 내보내기
CREATE TABLE IF NOT EXISTS `image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 blog_db.image:~2 rows (대략적) 내보내기
INSERT INTO `image` (`id`, `file_name`, `file_path`) VALUES
	(7, '256b627c-b39b-4bfc-bff7-7f888700aedd_스크린샷 2025-05-13 204306.png', '/upload/256b627c-b39b-4bfc-bff7-7f888700aedd_스크린샷 2025-05-13 204306.png'),
	(8, '1c7c2ef9-c681-4b0d-80a5-abb3b43cfffe_스크린샷 2025-05-13 204306.png', '/upload/1c7c2ef9-c681-4b0d-80a5-abb3b43cfffe_스크린샷 2025-05-13 204306.png'),
	(9, '35d105a8-af6d-4418-a959-1fbd99700e5a_Screenshot 2025-05-12 223602.png', '/upload/35d105a8-af6d-4418-a959-1fbd99700e5a_Screenshot 2025-05-12 223602.png'),
	(10, '06a1379b-e178-419b-98e6-6acd88533895_20250920_130652.jpg', '/upload/06a1379b-e178-419b-98e6-6acd88533895_20250920_130652.jpg'),
	(11, 'ba4e2939-0767-4f59-afd2-9ff9c076fb35_20250920_130720.jpg', '/upload/ba4e2939-0767-4f59-afd2-9ff9c076fb35_20250920_130720.jpg');

-- 테이블 blog_db.member 구조 내보내기
CREATE TABLE IF NOT EXISTS `member` (
  `member_no` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `is_admin` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`member_no`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 blog_db.member:~2 rows (대략적) 내보내기
INSERT INTO `member` (`member_no`, `id`, `password`, `name`, `email`, `created_at`, `is_admin`) VALUES
	(24, 'bjw8518', '$2a$10$/436TFhxZJhEshAk9CHuFu5Z1pIf2C/i7jI6OVmk/C75.o7DkTe3u', '배진우', 'bjw8518@gmail.com', '2025-10-08 17:04:24', 0),
	(25, 'admin', '$2a$10$/FhjVbF5WqlJ0QTH5RydGugrCzD4Zk/Pynu.ahk5EbX0hkN82zJZ2', '관리자', 'admin@gmail.com', '2025-10-08 17:30:42', 1),
	(26, 'bjw147312', '$2a$10$RfNK5cw/wWaJPVU3/qQ9E.GGDbQTcirCpKKl2ApojRGSCpSs7UEl.', '찌누', 'bjw147312@gmail.com', '2025-10-21 23:48:21', 0);

-- 테이블 blog_db.todo 구조 내보내기
CREATE TABLE IF NOT EXISTS `todo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_no` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `content` text NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `due_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_todo_member` (`member_no`),
  KEY `fk_todo_parent` (`parent_id`),
  CONSTRAINT `fk_todo_member` FOREIGN KEY (`member_no`) REFERENCES `member` (`member_no`) ON DELETE CASCADE,
  CONSTRAINT `fk_todo_parent` FOREIGN KEY (`parent_id`) REFERENCES `todo` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 blog_db.todo:~3 rows (대략적) 내보내기
INSERT INTO `todo` (`id`, `member_no`, `parent_id`, `content`, `completed`, `created_at`, `due_date`) VALUES
	(1, 24, NULL, 'Spring Boot 프로젝트 마이그레이션', 0, '2025-12-26 10:00:00', '2025-12-31'),
	(2, 25, NULL, '블로그 디자인 개편', 1, '2025-12-25 14:00:00', '2025-12-30'),
	(3, 24, 1, '1. Spring Security 설정', 0, '2025-12-26 11:00:00', '2025-12-27');

-- 테이블 blog_db.diary 구조 내보내기
CREATE TABLE IF NOT EXISTS `diary` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `member_no` INT(11) NOT NULL,
  `diary_date` DATE NOT NULL,
  `content` TEXT NOT NULL,
  `image_path` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_diary_member_date` (`member_no`, `diary_date`),
  CONSTRAINT `FK_diary_member` FOREIGN KEY (`member_no`) REFERENCES `member` (`member_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
