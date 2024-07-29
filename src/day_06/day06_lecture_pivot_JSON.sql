/*
PIVOT TABLE
	- 한 열에 포홤된 여러값을 출력하고, 여러 열로 변환하여 테이블 반환식을 회전하고 필요하면 집계까지 수행하는 과정을 의미한다.
*/

create table pivotTest(
	uName char(5),	-- 판매자
    season char(2),	-- 시즌
    amount int		-- 수량
);

INSERT Into pivotTest VALUES('김진수', '겨울', 10), ('운민수', '여름', 15), ('김진수','가을',25),('김진수','봄',3),('김진수','봄',37),('윤민수','가을',40),('운민수','여름',60);

SELECT * from pivottest;
-- 판매자 별로 판매, 계절, 판매수량 : Sum(), if() 함수 활용해서 피벗테이블을 생성
SELECT uName ,
	sum(if(season = '봄', amount, 0)) as'봄',
	sum(if(season = '여름', amount, 0))as '여름',
	sum(if(season = '가을', amount, 0))as '가을',
	sum(if(season = '겨울', amount, 0))as '겨울',
    sum(amount)as '합계'
from pivotTest GROUP BY uName;

-- 계절 별로 각 판매자의 판매수량을 집계하여 출력하는 피벗 테이블 
select season,
	sum(if(uname='김진수', amount, 0)) as '김진수의 판매수량',
	sum(if(uname='윤민수', amount, 0)) as '윤민수의 판매수량',
    sum(amount) 합계
from pivotTest group by season;


/*
JSON

- 웹과 모바일 응용 프로그램에서 데이터를 교환하기 위해 사용하는 개발형 표준 포맷
- 속성과 값으로 구성됨
- 포맷이 단순하고 공개되어 있어 여러 프로그래밍 언어에서 사용됨
- {} 중괄호 안에 객체를 생성, JSON 형태로 테이블 입출력 가능

*/

use bookstore;

-- json 오브젝트 생성하기
select json_object('name', name, 'height', height, 'year', birthYear) as '키 180 이상인 회원'
from usertbl
where height >= 180;

-- json 내장 함수
-- @json 변수에 json 형태의 객체 저장
set @json = 
'{
	"usertblEX" : [
		{"name": "임재범", "year": 1963, "height": 182},
		{"name": "이승기", "year": 1987, "height": 182},
		{"name": "성시경", "year": 1979, "height": 186},
        {"name": "성시경", "year": 2001, "height": 186}
    ]
}';

-- json_valid() : 제이슨 형식인지 체크 -> 문자열이 json 형식이면 1 반환, 아니면 0 반환
-- json_valid() : 제이슨 형식인지 체크 -> 문자열이 json 형식이면 1 반환, 아니면 0 반환
select json_valid(@json);

-- json_search() : 문자열을 검색해서 위치 반환
select json_search(@json, 'one', '성시경'); -- 하나의 필드만 리턴 -> \"$.usertblEX[2].name\"
select json_search(@json, 'all', '성시경'); -- 성시경이 있는 모든 필드 위치 리턴 -> [\"$.usertblEX[2].name\", \"$.usertblEX[3].name\"]

-- json_insert, json_replace, json_remove() 
select json_insert(@json, '$.usertblEX[0].date', '2024-07-29'); 
select json_replace(@json, '$.usertblEX[3].name', '임영웅');
select json_remove(@json, '$.usertblEX[0]');
