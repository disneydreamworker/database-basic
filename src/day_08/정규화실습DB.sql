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
  동아리명 varchar(50) not null,
  동아리개장일 date not null,
  학번 int,
  이름 varchar(30) not null, 
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
 commit;
 
 
 -- 1차 정규화
 create table 동아리 (
	select 동아리번호, 동아리명, 동아리개장일 from 동아리가입학생학과 group by 동아리번호
 );
select * from 동아리;
alter table 동아리 add constraint pk_동아리번호 primary key(동아리번호);


drop table 동아리학생학과;
create table 동아리학생학과 (
	select 학번, 이름, 동아리가입일, 학과번호, 학과명, 동아리번호 from 동아리가입학생학과
);
select * from 동아리학생학과;
alter table 동아리학생학과 add constraint fk_동아리번호 foreign key (동아리번호) references 동아리(동아리번호);
alter table 동아리학생학과 add constraint pk_학생학과 primary key (학번, 동아리번호);


drop table 학생학과;
create table 학생학과 (select 학번, 이름, 학과번호, 학과명 from 동아리학생학과 group by 학번 order by 학번);
select * from 학생학과;
alter table 학생학과 add constraint pk_학생 primary key (학번);


create table 학과(select 학과번호, 학과명 from 학생학과 group by 학과번호 order by 학과번호);
select * from 학과;
alter table 학과 add constraint pk_학과번호 primary key(학과번호);


create table 학생 (select 학번, 이름, 학과번호 from 학생학과 group by 학번 order by 학번);
select * from 학생;
alter table 학생 add constraint pk_학번 primary key (학번);
alter table 학생 add constraint fk_학과번호 foreign key (학과번호) references 학과(학과번호);


drop table 동아리가입;
create table 동아리가입(select 동아리번호, 동아리가입일, 학번 from 동아리학생학과 order by 동아리번호);
select * from 동아리가입;
alter table 동아리가입 add constraint fk_동아리가입_번호 foreign key(동아리번호) references 동아리(동아리번호);
alter table 동아리가입 add constraint fk_동아리가입_학번 foreign key (학번) references 학생(학번);
alter table 동아리가입 add constraint pk_동아리가입 primary key(동아리번호, 학번);


-- 제약조건 적용 확인하기
select * from information_schema.table_constraints where table_name = '학생';
select * from information_schema.table_constraints where table_name = '학과';
select * from information_schema.table_constraints where table_name = '동아리';
select * from information_schema.table_constraints where table_name = '동아리가입';
