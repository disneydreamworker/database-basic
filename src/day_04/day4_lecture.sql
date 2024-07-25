use bookstore;

-- subQueryorders
select max(price) from book;
select bookname from book where price = (select max(price) from book);

select name
from customer
where custid in (select custid from orders);



select * from orders where custid = 1; 
select * from book where publisher = '대한미디어';
select custid from orders where custid = 1;
select name from customer where custid in (
	select custid from orders where bookid in (
		select bookid from book where publisher = '대한미디디어'
));


-- 상관부속질의(correlated subquery
-- 질의3-31   출판사별로출판사의평균도서가격보다비싼도서를구하시오.
-- b1, b2 : 튜플 변수
select avg(price) from book group by publisher; 

select bookname 
from book b1 
where b1.price > (
	select avg(b2.price) 
	from book b2 
    where b1.publisher = b2.publisher
);

-- (13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
select custid, avg(saleprice)
from orders
group by custid;

select avg(saleprice) from orders;

-- (13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
select c.name, avg(o.saleprice)
from orders o, customer c
where o.custid = c.custid
group by o.custid
having avg(o.saleprice) > (
	select avg(saleprice) from orders -- 11800 : 판매액 평균
);

select name
from customer c
where 
	(select avg(o1.saleprice) from orders o1 where c.custid = o1.custid) >
	(select avg(o2.saleprice) from orders o2);


-- 1970 년 이후에 출생하고 키가 182 이상인 회원의 아이디와 이름을 조회
select userid, name
from usertbl
where birthyear > 1970 and height >= 182;

select userid, name
from usertbl
where birthyear > 1970 or height >= 182;

-- 키가 180 ~ 183 사이인 회원의 정보를 조회하세요
select *
from usertbl
where height between 180 and 183;

-- 지역이 경남 이나 전남 이나 경북 에서 거주하는 회원의 이름
select name
from usertbl 
where addr in ('경남', '전북', '전남');

-- 회원 중 김씨 성을 가진 회원의 정보를 조회하시오
select *
from usertbl
where name like '김%';


-- 김경호 회원보다 키가 크거나 같은 사람의 이름과 키를 조회하시오
select name, height
from usertbl
where height > (
	select height from usertbl where name = '김경호'
);

-- 지역이 경남인 회원인 사람의 키보다 키가 크거나 같은 회원의 이름을 조회하시오 
select name
from usertbl
where height >= (
	select height from usertbl where addr = '경남' -- 177, 173
); -- 조건 연산자는 다중 행 연산을 지원하지 않아 에러가 발생한다 (subquery returns more than 1 row)


-- ANY : '또는' & 'or' 의 의미를 가진다
select name, height
from usertbl
where height >= ANY (
	select height from usertbl where addr = '경남' -- 177, 173
);


-- ALL : 'and' 의 의미를 가진다
select name, height
from usertbl
where height >= ALL (
	select height from usertbl where addr = '경남' -- 177, 173
);


-- 서브쿼리는 테이블을 복사할 때 많이 활용된다. 
-- usertbl 의 userid를 pk로 설정하는 alter 명령어
create table usertbl2 (
	select *
    from usertbl
);

alter  table usertbl add constraint pk_usertbl primary key(userid);


-- 
select name
from customer c
where 
	(select avg(o1.saleprice) from orders o1 where c.custid = o1.custid) >
	(select avg(o2.saleprice) from orders o2);
    
select * from customer c where (
	select avg(o1.saleprice)
	from orders o1
	where c.custid = o1.custid);

    
select userid, sum(price * amount) from buytbl group by userid;

use bookstore;
select * from buytbl;


-- Group by & WITH ROLLUP : 총합 중간 합계를 분류 별로 구하기
select groupName, sum(price*amount) 
from buytbl
group by groupName
with rollup; -- 누적 합계 구하기

