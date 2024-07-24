-- 연습문제 
use bookstore;
-- 1) 
select bookname from book where bookid = 1;
-- 2)
select bookname from book where price >= 20000;
-- 3)
select sum(price) as '박지성의 총 구매액' from book where bookid= 1;
-- 4)
select count(bookid) as '박지성이 구매한 도서의 수' from book where bookid =1;


-- 1)
select count(bookid) as '도서의 총 개수' from book;
-- 2)
select distinct count(publisher) as '출판사의 총 개수' from book;
-- 3)
select name, address from customer;
-- 4)
select orderid as '주문번호' from orders where orderdate between '2024-07-04' and '2024-07-07';
-- 5)
select orderid as '주문번호' from orders where orderdate not between '2024-07-04' and '2024-07-07';
-- 6)
select name, address from customer where name like '김%';
-- 7)
select name, address from customer where name like '김%아';
