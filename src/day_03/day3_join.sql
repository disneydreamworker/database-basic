-- 박지성 고객이 주문한 도서의 총 구매액을 알고 싶다면? -> 조인 연산 
-- JOIN : 한 테이블의 행을 다른 테이블의 행에 연결하여 두 개 이상의 테이블을 결합하는 연산 / 여러개의 테이블을 연결하여 하나의 테이블을 만드는 과정
use bookstore;

select * from customer, orders; -- 두 테이블을 어떠한 조건 없이 연결 : Cartessian Product -> 각 테이블의 전체 튜플 수 * 전체 튜플 수

-- 고객과 고객의 주문에 대한 데이터를 모두 출력하세요
select * from customer, orders where customer.custid = orders.custid -- 두 테이블의 연결 조건을 추가해서 하나의 릴레이션으로 출력
order by customer.name;

-- 고객의이름과고객이주문한도서의판매가격을검색하시오.
select name, saleprice
from customer, orders
where customer.custid = orders.custid; -- 동등 조인 (equi join)

-- 고객별로주문한모든도서의총판매액을구하고, 고객별로정렬하시오.
select name, sum(saleprice) as '총판매액'
from customer, orders
where customer.custid = orders.custid
group by customer.name
order by customer.name;

-- 질의3-25   고객의이름과고객이주문한도서의이름을구하시오
select name, bookname
from customer, orders, book
where customer.custid = orders.custid and orders.bookid = book.bookid; 

-- 질의3-26   가격이20,000원인도서를주문한고객의이름과도서의이름을구하시오.
select name, bookname
from customer, orders, book
where customer.custid = orders.custid and orders.bookid = orders.bookid and orders.saleprice = 20000;


-- Outer JOIN
-- 질의3-27  도서를구매하지않은고객을포함하여고객의이름과고객이주문한도서의 판매가격을구하시오.
select name, saleprice
from customer left outer join orders on customer.custid = orders.custid;

select name, saleprice
from customer right outer join orders on customer.custid = orders.custid;


-- 1. 서점의고객이요구하는다음질문에대해SQL 문을작성하시오.
-- 5)박지성이 구매한도서의출판사수
select count(distinct publisher) 
from customer, book, orders
where customer.custid = orders.custid and orders.bookid = book.bookid and customer.custid = 1;

-- 6)박지성이 구매한도서의이름, 가격, 정가와판매가격의차이
select bookname, price, price-saleprice as '정가-판매가격'
from customer, book, orders
where customer.custid = orders.custid and orders.bookid = book.bookid and customer.custid = 1;

-- 7)박지성이 구매하지않은도서의이름
select distinct bookname, name
from customer, book, orders
where customer.custid = orders.custid and orders.bookid = book.bookid and not customer.custid = 1;
