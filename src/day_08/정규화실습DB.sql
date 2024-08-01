#######################################################
# 정규화실습 
# 서유미
# 실습 DATABASE
# 작성일:2024-07-31
#######################################################

DROP DATABASE IF EXISTS 정규화;

CREATE DATABASE 정규화 DEFAULT CHARSET  utf8mb4 COLLATE  utf8mb4_general_ci;

USE 정규화;

CREATE TABLE 동아리가입학생학과(
  동아리번호 CHAR(2),
  학번 varchar(20),
  동아리명 varchar(50) not null,
  학생이름 varchar(30) not null, 
  동아리가입일 date not null,
  학과번호 CHAR(2),
  학과명 varchar(30),
  primary key(동아리번호,학번)
 ) DEFAULT CHARSET=utf8mb4;
 
 
 insert into 동아리가입학생학과 values('c1','지구한바퀴여행','2000-02-01',231001,'문지영','2023-04-01','D1','화학공학과');
 insert into 동아리가입학생학과 values('c1','지구한바퀴여행','2000-02-01',231002,'배경민','2023-04-03','D4','경영학과');
 insert into 동아리가입학생학과 values('c2','클래식연주동아리','2010-06-05',232001,'김명희','2023-03-22','D2','통계학과');
 insert into 동아리가입학생학과 values('c3','워너비골퍼','2020-03-01',232002,'천은정','2023-03-07','D2','통계학과');
 insert into 동아리가입학생학과 values('c3','워너비골퍼','2020-03-01',231002,'배경민','2023-04-02','D2','경영학과');
 insert into 동아리가입학생학과 values('c4','쉘위댄스','2021-07-01',231001,'문지영','2023-04-30','D1','화학공학과');
 insert into 동아리가입학생학과 values('c4','쉘위댄스','2021-07-01',233001,'이현경','2023-03-27','D3','역사학과');
 
 
 
