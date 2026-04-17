-- Tạo và sử dụng database
CREATE DATABASE IF NOT EXISTS online_learning
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE online_learning;

-- Bảng: Student (Sinh viên)
CREATE TABLE Student (
    student_id   INT             NOT NULL AUTO_INCREMENT,
    full_name    VARCHAR(100)    NOT NULL,
    birth_date   DATE            NOT NULL,
    email        VARCHAR(150)    NOT NULL,
    CONSTRAINT pk_student    PRIMARY KEY (student_id),
    CONSTRAINT uq_student_email UNIQUE (email)
);

-- Bảng: Course (Khóa học)
CREATE TABLE Course (
    course_id       INT             NOT NULL AUTO_INCREMENT,
    course_name     VARCHAR(200)    NOT NULL,
    description     TEXT,
    total_sessions  INT             NOT NULL,
    CONSTRAINT pk_course             PRIMARY KEY (course_id),
    CONSTRAINT chk_course_sessions   CHECK (total_sessions > 0)
);

-- Bảng: Instructor (Giảng viên)
CREATE TABLE Instructor (
    instructor_id   INT             NOT NULL AUTO_INCREMENT,
    full_name       VARCHAR(100)    NOT NULL,
    email           VARCHAR(150)    NOT NULL,
    CONSTRAINT pk_instructor        PRIMARY KEY (instructor_id),
    CONSTRAINT uq_instructor_email  UNIQUE (email)
);

-- Bảng: Course_Instructor (Giảng viên phụ trách khóa học)
-- Một giảng viên có thể dạy nhiều khóa học
CREATE TABLE Course_Instructor (
    course_id       INT NOT NULL,
    instructor_id   INT NOT NULL,
    CONSTRAINT pk_course_instructor PRIMARY KEY (course_id, instructor_id),
    CONSTRAINT fk_ci_course
        FOREIGN KEY (course_id)     REFERENCES Course(course_id)     ON DELETE CASCADE,
    CONSTRAINT fk_ci_instructor
        FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id) ON DELETE CASCADE
);

-- Bảng: Enrollment (Đăng ký học)
CREATE TABLE Enrollment (
    enrollment_id       INT     NOT NULL AUTO_INCREMENT,
    student_id          INT     NOT NULL,
    course_id           INT     NOT NULL,
    enrollment_date     DATE    NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT pk_enrollment        PRIMARY KEY (enrollment_id),
    CONSTRAINT uq_enrollment        UNIQUE (student_id, course_id),   -- không đăng ký trùng
    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (student_id)    REFERENCES Student(student_id)    ON DELETE CASCADE,
    CONSTRAINT fk_enrollment_course
        FOREIGN KEY (course_id)     REFERENCES Course(course_id)      ON DELETE CASCADE
);

-- Bảng: Result (Kết quả học tập)
CREATE TABLE Result (
    result_id       INT             NOT NULL AUTO_INCREMENT,
    student_id      INT             NOT NULL,
    course_id       INT             NOT NULL,
    midterm_score   DECIMAL(4,2),
    final_score     DECIMAL(4,2),
    CONSTRAINT pk_result            PRIMARY KEY (result_id),
    CONSTRAINT uq_result            UNIQUE (student_id, course_id),   -- mỗi SV 1 kết quả / khóa học
    CONSTRAINT chk_midterm          CHECK (midterm_score  BETWEEN 0 AND 10),
    CONSTRAINT chk_final            CHECK (final_score    BETWEEN 0 AND 10),
    CONSTRAINT fk_result_student
        FOREIGN KEY (student_id)    REFERENCES Student(student_id)    ON DELETE CASCADE,
    CONSTRAINT fk_result_course
        FOREIGN KEY (course_id)     REFERENCES Course(course_id)      ON DELETE CASCADE
);


-- PHẦN II - NHẬP DỮ LIỆU BAN ĐẦU
-- Sinh viên (5 bản ghi)
INSERT INTO Student (full_name, birth_date, email) VALUES
    ('Nguyễn Văn An',    '2002-03-15', 'an.nguyen@student.edu.vn'),
    ('Trần Thị Bích',    '2001-07-22', 'bich.tran@student.edu.vn'),
    ('Lê Minh Châu',     '2003-01-10', 'chau.le@student.edu.vn'),
    ('Phạm Quốc Đạt',    '2002-11-05', 'dat.pham@student.edu.vn'),
    ('Hoàng Thị Hà',     '2001-09-18', 'ha.hoang@student.edu.vn');

-- Khóa học (5 bản ghi)
INSERT INTO Course (course_name, description, total_sessions) VALUES
    ('Lập trình Python cơ bản',
        'Giới thiệu ngôn ngữ Python, cấu trúc dữ liệu, hàm và module cơ bản.', 30),
    ('Cơ sở dữ liệu quan hệ',
        'Thiết kế CSDL, SQL nâng cao, tối ưu truy vấn và quản trị MySQL.', 24),
    ('Lập trình Web Frontend',
        'HTML5, CSS3, JavaScript và các framework hiện đại như React.', 36),
    ('Trí tuệ nhân tạo nhập môn',
        'Khái niệm AI, machine learning, neural network và ứng dụng thực tế.', 30),
    ('Mạng máy tính',
        'Mô hình OSI/TCP-IP, giao thức mạng, bảo mật và cấu hình router.', 27);

-- Giảng viên (5 bản ghi)
INSERT INTO Instructor (full_name, email) VALUES
    ('TS. Nguyễn Đức Hùng',   'hung.nguyen@university.edu.vn'),
    ('ThS. Trần Thị Mai',     'mai.tran@university.edu.vn'),
    ('PGS. Lê Văn Sơn',       'son.le@university.edu.vn'),
    ('TS. Phạm Thị Lan',      'lan.pham@university.edu.vn'),
    ('ThS. Hoàng Văn Tú',     'tu.hoang@university.edu.vn');

-- Phân công giảng viên phụ trách khóa học
INSERT INTO Course_Instructor (course_id, instructor_id) VALUES
    (1, 1),   -- Python    <- Nguyễn Đức Hùng
    (2, 2),   -- CSDL      <- Trần Thị Mai
    (3, 3),   -- Frontend  <- Lê Văn Sơn
    (4, 4),   -- AI        <- Phạm Thị Lan
    (5, 5),   -- Mạng      <- Hoàng Văn Tú
    (1, 2),   -- Python    <- Trần Thị Mai (dạy thêm)
    (4, 1);   -- AI        <- Nguyễn Đức Hùng (dạy thêm)

-- 2.5  Đăng ký học
INSERT INTO Enrollment (student_id, course_id, enrollment_date) VALUES
    (1, 1, '2025-01-10'),
    (1, 2, '2025-01-10'),
    (1, 4, '2025-01-11'),
    (2, 1, '2025-01-12'),
    (2, 3, '2025-01-12'),
    (3, 2, '2025-01-13'),
    (3, 5, '2025-01-13'),
    (4, 3, '2025-01-14'),
    (4, 4, '2025-01-14'),
    (5, 1, '2025-01-15'),
    (5, 5, '2025-01-15');

-- Kết quả học tập
INSERT INTO Result (student_id, course_id, midterm_score, final_score) VALUES
    (1, 1, 7.5, 8.0),
    (1, 2, 6.0, 7.0),
    (1, 4, 8.5, 9.0),
    (2, 1, 5.5, 6.5),
    (2, 3, 7.0, 7.5),
    (3, 2, 8.0, 8.5),
    (3, 5, 6.5, 7.0),
    (4, 3, 9.0, 9.5),
    (4, 4, 7.5, 8.0),
    (5, 1, 6.0, 6.5),
    (5, 5, 7.0, 7.5);

-- CẬP NHẬT DỮ LIỆU (DML - UPDATE)
-- Cập nhật email cho sinh viên có student_id = 3 (Lê Minh Châu)
UPDATE Student
SET    email = 'chaule.updated@student.edu.vn'
WHERE  student_id = 3;

-- Cập nhật mô tả cho khóa học Python (course_id = 1)
UPDATE Course
SET    description = 'Giới thiệu Python từ cơ bản đến nâng cao: cấu trúc dữ liệu, OOP, xử lý file và kết nối CSDL.'
WHERE  course_id = 1;

-- Cập nhật điểm cuối kỳ cho sinh viên Nguyễn Văn An (student_id=1) môn CSDL (course_id=2)
UPDATE Result
SET    final_score = 8.5
WHERE  student_id = 1
  AND  course_id  = 2;

-- XÓA DỮ LIỆU (DML - DELETE)
-- Xóa kết quả học tập tương ứng trước khi xóa đăng ký
-- (sinh viên 5 đã đăng ký nhầm khóa học 5 → xóa)
DELETE FROM Result
WHERE  student_id = 5
  AND  course_id  = 5;

-- Xóa lượt đăng ký không hợp lệ (student_id=5, course_id=5)
DELETE FROM Enrollment
WHERE  student_id = 5
  AND  course_id  = 5;

-- TRUY VẤN DỮ LIỆU (DML - SELECT)
-- Danh sách tất cả sinh viên
SELECT
    student_id,
    full_name,
    birth_date,
    email
FROM   Student
ORDER  BY student_id;

-- Danh sách giảng viên
SELECT
    instructor_id,
    full_name,
    email
FROM   Instructor
ORDER  BY instructor_id;

-- Danh sách các khóa học
SELECT
    course_id,
    course_name,
    description,
    total_sessions
FROM   Course
ORDER  BY course_id;

-- Thông tin đăng ký khóa học
-- (kết hợp tên sinh viên, tên khóa học, ngày đăng ký)
SELECT
    e.enrollment_id,
    s.student_id,
    s.full_name         AS student_name,
    c.course_id,
    c.course_name,
    e.enrollment_date
FROM   Enrollment e
JOIN   Student    s ON s.student_id = e.student_id
JOIN   Course     c ON c.course_id  = e.course_id
ORDER  BY e.enrollment_date, s.student_id;

-- Thông tin kết quả học tập
-- (kèm điểm trung bình = 40% giữa kỳ + 60% cuối kỳ)
SELECT
    r.result_id,
    s.student_id,
    s.full_name             AS student_name,
    c.course_id,
    c.course_name,
    r.midterm_score,
    r.final_score,
    ROUND(r.midterm_score * 0.4 + r.final_score * 0.6, 2) AS average_score
FROM   Result  r
JOIN   Student s ON s.student_id = r.student_id
JOIN   Course  c ON c.course_id  = r.course_id
ORDER  BY s.student_id, c.course_id;