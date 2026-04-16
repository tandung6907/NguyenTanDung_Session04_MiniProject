create database homework_ss4;

use homework_ss4;

create table Student(
	studentId int primary key auto_increment,
    teacherId int unique,
    foreign key (teacherId) references Teacher(teacherId),
    fullName varchar(255) not null,
    courseId int unique,
    foreign key (courseId) references Course(courseId),
    fullName varchar(255) not null,
    birthday date not null,
    email varchar(255) not null unique
);

create table Course(
	courseId int primary key auto_increment,
    teacherId int,
    foreign key (teacherId) references Teacher(teacherId),
    courseName varchar(255) not null,
    shortDescribe varchar(300),
    numberCourse int not null
    check (numberCourse > 0)
);

create table Teacher(
	teacherId int primary key auto_increment,
    teacherName varchar(255) not null,
    email varchar(255) not null unique
);

create table Enrollment(
	enrollmentId int primary key auto_increment,
    enrollmentDate timestamp not null,
    studentId int unique,
    foreign key (studentId) references Student(studentId)
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