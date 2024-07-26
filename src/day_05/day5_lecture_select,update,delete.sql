-- 2024/07/26
-- 출력하는 개수를 제한하는 LIMIT
select last_name, employee_id, hire_date from employees order by hire_date limit 10;
-- 1번을 제외 2번부터 6번까지 출력
select last_name, employee_id, hire_date from employees order by hire_date limit 1,6;

-- 테이블을 복제하는 서브쿼리
create table job_grades_copy (select grade_level from job_grades);

-- 대량의 샘플 데이터를 입력할 때
-- insert into table (col1, col2, ... ) select문 ;
create table copy (id int, fname varchar(20), lname varchar(20));
insert into copy select employee_id, first_name, last_name from employees;
alter table copy add constraint pk_copy_id primary key (id);
commit;
-- 내가 원하는 데이터를 나누어서 새 테이블에 담을 수 있음

-- insert문 기본  : 테이블에 데이터를 삽입하는 명령어
-- insert [into] 테이블명[(열1,열2,열3,....)] values(값1,값2....);
-- 테이블 이름 다음에 나오는 열은 생략가능, 생략할 경우 values 다음에 오는 값들의 순서 및 개수가 테이블이 정의된 열 순서와 개수와 동일해야 함
CREATE TABLE testtbl (id int, username char(5) , age int);
insert testtbl values(1,'박마리아',30);
insert testtbl(id, username) values(2,'김진영');
commit;

select * from testtbl;
insert testtbl(id, username) values(5,'고해란');
rollback;

-- 자동 커밋 비활성화하기 
select @@autocommit;
SET autocommit = 0;

-- 자동으로 증가하는 AUTO-INCREMENT   (INSERT 할때는 해당 열이 없다고 생각하고 입력하면 된다.)
-- 자동으로 1부터 증가하는 값을 입력해 준다.
-- PK, UNIQUE 제약조건을 지정해 줘야 한다.  데이터형은 숫자 형식만 사용가능하다.
CREATE TABLE testtbl2 (id int auto_increment primary key , username char(5));
insert testtbl2 values(null,'김유진');
insert testtbl2 values(null,'박유진');
insert testtbl2 values(null,'서유진');
insert testtbl2 values(null,'고유진');
insert testtbl2 values(null,'유진');
insert testtbl2 values(null,'구진');
select * from testtbl2;

-- autoincrement 를 이용하여 입력된 숫자가 어디까지 증가되었는지 궁금하다면?
SELECT LAST_INSERT_ID();

-- autoincrement 시작값을 셋팅 이 가능하다.
ALTER TABLE testtbl2 auto_increment = 1000;
SET @@auto_increment_increment = 3;
rollback;
commit;

-- UPDATE : 기존에 입력된 값을 변경하기 위한 명령어
-- update table set column = 값 where 조건;
set sql_safe_updates = 0; -- 세이프 모드 해제
update copy set lname = '수정함';
update copy set lname = '사장님' where id = 100;
rollback;

-- DELETE : 행 단위로 삭제하는 명령어
-- delete from table where 조건; -- where 문이 생략되면 전체 데이터가 삭제됨
select * from copy;
delete from copy;
rollback;
drop table copy;
insert into copy select employee_id, first_name, last_name from employees; -- 중복 데이터 입력
-- DELETE LIMIT
select * from copy where lname = 'Chen';
delete from copy where lname = 'Chen' limit 3; -- 3개만 남기고 나머지 삭제






