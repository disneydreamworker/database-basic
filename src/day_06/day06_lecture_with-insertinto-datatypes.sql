select count(emp_no) from employees;

create table bigtbl (select * from employees);
create table bigtbl2 (select * from employees);
create table bigtbl3 (select * from employees);

set sql_safe_updates = 0; -- 세이프 모드 해제

delete from bigtbl; -- DML 한 행 씩 삭제하며 트랜잭션 로그를 기록한다. 롤백이 가능하다
drop table bigtbl2; -- 테이블 자체를 삭제한다
truncate membertbl; -- 한 행 씩 삭제하며 테이블 구조만 남겨둔다

create table membertbl(select userId, name, addr from usertbl limit 3);
insert into membertbl (select userId, name, addr from usertbl limit 3);
select * from membertbl;
alter table membertbl add constraint pk_m primary key (userId);
desc membertbl;

-- IGNORE INTO : PK 중복 에러로 다음 행 입력이 멈추는 것을 막고 중복 에러를 무시한다
insert ignore into membertbl values ('SJH', '서장훈', '한국');
insert ignore into membertbl values ('HJY', '현주엽', '미국');

-- ON DUPLICATE KEY UPDATE : PK 중복값이 들어오면 값을 변경해서 중복되지 않는 값을 입력한다
-- insert 이지만 update 처럼 사용한다
insert into membertbl values('BBK', '바비킴', '미국') on duplicate key update name = '두플키', addr = '미국';


/* 
WITH 절
CTE (ANSI-SQL99 표준)을 표현하기 위한 구문이다. MySQL 8.0 이후에 추가된 기능이다.
CTE 는  NON-Rcursive (비재귀적인) , Recursive(재귀적인) CTE 로 구분되는데, Non-Rcursive 표현에 대해 알아본다.

WITH 테이블이름(열1, 열2...)
AS (쿼리문)
SELECT 열 이름 FROM 테이블이름;

AS 안의 쿼리문의 열 개수와 with 의 열 개수가 일치해야 한다
파생 테이블이고 재활용이 불가능하다
*/
with withEX (userID, total) as (
	select userID, sum(price * amount) from buytbl group by userId
)
select * from withEX order by total desc;

with withEX2 (addr, maxHeight) as (
	select addr, max(height) from usertbl group by addr
)
select avg(maxHeight) as '각 지역별 최고키의 평균' from withEX2;


/*
데이터 형식 및 내부 함수
------------------------------
	1) 숫자 데이터 형식
    
	bit(n)			1~64 bit
    tinyint			1 byte (0-255)
    smallint		2 byte (0-65535)
    mediumint		3 byte (0-1600백만)
    int(integer)	4 byte (0-42억)
    bigint			8 byte (0-1800경)

    float			4 byte (소수점 아래 7자리) : 무한 소수를 저장, 근사치 값
    double			8 byte (소수점 아래 15자리) : 무한 소수를 저장, 근사치 값
    real
    decimal(m,d)	5~17 byte (소수점 아래 d자리) : 유한 소수를 저장, 정확한 값
	
    2) 문자 데이터 형식
    
    char(n)			1 byte (1-255)
    varchar(n)		2 byte (1-65535)
    binary(n)		1 byte (1-255) : 고정 길이 이진 데이터값
    varbinary(n)	가변 길이 이진 데이터값
    
    tinytext		1 byte (1-255)
    text			2 byte (1-65535)
    mediumtext		3 byte (1-1600백만)
    longtext		4 byte (1-42억)
    blob			이미지,음성,동영상,문서파일 등 대용량 데이터값 저장
    enum			2 byte (1-65535)
    
    3) 날짜와 시간 데이터 형식
    
    date			3 byte : YYYY-MM-DD
    time			3 byte : HH:MM:SS
    datetime		8 byte : YYYY-MM-DD HH:MM:SS
    timestamp		4 byte : 타임존 시스템의 변수로 utc 시간대로 변환하여 저장
    
    4) 공간 데이터 형식
    geometry		선,점,다각형 등 공간 데이터값 저장
    
    5) JSON 형식
    json			8 byte : javascipt object notation 문서 저장
*/
