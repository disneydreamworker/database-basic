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


-- 내장 함수
-- 1) 제어 흐름 함수 : if(), ifnull(), nullif(), case-when-else-end()
select if (100 > 200, '참', '거짓');
select ifnull(null, 'null'); 		-- 수식1이 null이므로 'null'반환
select ifnull(100, 'null'); 		-- 수식1이 null이 아니므로 100 반환
select nullif(100, (200-100));		-- 두 수식이 같으므로 null 반환
select nullif(10, (200-100)); 		-- 두 수식이 다르므로 10 반환
select 
	case 5
		when 1 then '일'
        when 3 then '삼'
        when 5 then '오'
		else '모름'
	end as 'case';

/*
2) 문자열 함수 : ASCII(아스키코드), char(숫자)
	- 기본 문자 코드 : UTF-8 
	- 영자 : 1 byte, 한글 : 3 byte
    
    - bit_length() : bit 크기, 문자 크기 반환
    - char_lenghth() : 문자의 개수 반환
    - length() : 할당된 byte 수 반환
	
    - concat(문자열1, 문자열2, ...)
    - concat_ws(구분자, 문자열1, 문자열2...)
    
    - elt(위치값, 문자열) : 위치값에 해당하는 문자열 반환 
    - field(문자, 문자열) : 해당 문자열의 위치값 반환
    - find_in_set(문자, '문자열') : 해당 문자의 위치값 반환
    - instr(문자열, 문자) : 해당 문자의 위치값을 반환
    - locate(문자, 문자열) : 해당 문자의 위치값을 반환
*/

select ascii('A'), char(65);
select bit_length('a'), char_length('a'), length('a');
select bit_length('가'), char_length('가'), length('가'); 

select concat_ws('&', '안녕','하세','요'); -- '안녕&하세&요'

select elt(2, 'one', 'two', 'three');
select field('둘', 'one', '둘', 'three');
select find_in_set('둘', 'one,둘,three');
select instr('하나둘셋넷다섯', '둘');
select locate('둘', '하나둘셋넷다섯');

/*
3) FORMAT (숫자, 소숫점 자릿수) 
*/

select format(0.123456789, 3); -- 0.123

/*
4) 2진수, 16진수, 8진수
	- bin()
    - hex()
    - oct()
*/

select bin(10), oct(10), hex(10);

/*
5) 문자열 처리
	- insert(기준 문자열, 위치, 길이, 삽입할 문자열) : 기준 문자열의 위치부터 길이만큼을 삽입할 문자열로 대체
    - left(문자열, 길이)
    - right(문자열, 길이)
    - upper() = ucase()
    - lower() = lcase()
    - lpad() : 문자열의 남는 공간에 문자열로 입력
    - rpad()
    - trim() : 양쪽 공백 제거
    - substring()
*/
select insert('오늘은여기까지', 2, 4, '*');
select insert('오늘은여기까지', 2, 4, '******');
select left('오늘은여기까지', 3), right('오늘은여기까지', 3);
select lower('ABCD'), lcase('ABCD'), upper('abcd'), ucase('abcd');
select lpad('오늘은여기까지', 15, '이제는안녕');
select rpad('오늘은여기까지', 15, '이제는안녕');
select trim('     [오늘은 여기까지]   ');
select rtrim('     [오늘은 여기까지]   ');
select ltrim('     [오늘은 여기까지]   ');
select substring('오늘은여기까지', 1, 3);

/*
6) 날짜 및 시간 함수
	- adddate(날짜, 차이)
    - subdate(날짜, 차이)
    - addtime
    - subtime
    
    - curdate() : 연-월-일
    - curtime() : 시:분:초
    - now() : 연-월-일 시:분:초
    - sysdate() : 연-월-일 시:분:초
    - localtime(), localstamp()
    
     - year(), month(), day()
     - hour(), minute(), second(), microsecond()
*/
select adddate('2024-01-01', interval 320 day);
select subdate('2024-12-31', interval 320 day);
select subdate('2024-12-31', interval 3 month);
select addtime('2024-12-31 : 23:59:59', '0:0:1');
select subtime('2025-01-01 : 00:00:00', '0:0:1');
select date(now()), time(now());
