CREATE DATABASE homework_ss4;
USE homework_ss4;

CREATE TABLE Teacher (
    teacherId INT PRIMARY KEY AUTO_INCREMENT,
    teacherName VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Course (
    courseId INT PRIMARY KEY AUTO_INCREMENT,
    teacherId INT,
    courseName VARCHAR(255) NOT NULL,
    shortDescribe VARCHAR(300),
    numberCourse INT NOT NULL,
    CHECK (numberCourse > 0),
    FOREIGN KEY (teacherId) REFERENCES Teacher(teacherId)
);

CREATE TABLE Student (
    studentId INT PRIMARY KEY AUTO_INCREMENT,
    fullName VARCHAR(255) NOT NULL,
    birthday DATE NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Enrollment (
    enrollmentId INT PRIMARY KEY AUTO_INCREMENT,
    enrollmentDate TIMESTAMP NOT NULL,
    studentId INT,
    courseId INT,
    FOREIGN KEY (studentId) REFERENCES Student(studentId),
    FOREIGN KEY (courseId) REFERENCES Course(courseId)
);

create table Score(
	scoreId int primary key auto_increment
);

insert into Student (fullName, birthday, email)
values
	('Vi Anh Dủng', '2026-04-16', 'dungvisvvcl@gmail.com'),
	('Vi Anh Dủng', '2026-04-16', 'dungvinguvcl@gmail.com'),
	('Vi Anh Dủng', '2026-04-16', 'dungviocchovcl@gmail.com'),
	('Vi Anh Dủng', '2026-04-16', 'dungvidanvcl@gmail.com'),
	('Vi Anh Dủng', '2026-04-16', 'dungvistupidvcl@gmail.com');

select * from Student;
delete from Student;
drop table Student, Course, Teacher, Enrollment;