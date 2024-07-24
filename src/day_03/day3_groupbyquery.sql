use bookstore;
select phone from customer where name = '김연아';
select bookname, price from book;

select * from book where price between 10000 and 20000;
select * from book where publisher in ('굿스포츠', '대한미디어');

-- 와일드 문자 : &, [0-5], [^],  _
select * from book where bookname like '%축구%';
select * from book where bookname like '%_구%';

-- 집계 함수
select sum(saleprice) as '김연아님의 구매금액' from orders where custid = 2;
select sum(saleprice) as 총매출, avg(saleprice) as 평균값, min(saleprice), max(saleprice) from orders;
-- count(*) 함수는 null을 포함한 전체 튜플 개수를 센다
-- count(칼럼명) 은 null을 제외한 튜플 수를 센다
select distinct count(publisher) from book;
select count(ifnull(saleprice, 0)) from orders;

-- group by
select *, count(*) as 도서수량, sum(saleprice) as 총판매액
from orders
group by custid;

select custid, count(*) as 도서수량, sum(saleprice) as 총판매액
from orders
where saleprice >= 8000
group by custid
having count(saleprice) >= 2;

-- select 절의 실행순서
-- 1) FROM
-- 2) WHERE
-- 3) GROUP BY
-- 4) HAVING
-- 5) SELECT
-- 6) ORDER BY




