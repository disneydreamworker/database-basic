use bookstore;
SELECT ABS(-78),ABS(+78);
SELECT ROUND(4.875,1);
SELECT  custid '고객번호',  ROUND(sum(saleprice)/count(*),-2)'평균금액'
FROM Orders
GROUP BY custid;

SELECT * FROM BOOK WHERE BOOKNAME LIKE'%야구%';

SELECT REPLACE(BOOKNAME,'야구','농구')BOOKNAME FROM BOOK;

SELECT bookname '제목' , CHAR_LENGTH(bookname)'문자수',LENGTH(bookname)'바이트수'
FROM BOOK
WHERE publisher = '굿스포츠';
SELECT * FROM CUSTOMER;
SELECT SUBSTR(name,1,1)'성' , count(*)'인원'
from customer
GROUP BY SUBSTR(name,1,1);
SELECT orderid '주문번호', orderdate '주문일', ADDDATE(orderdate,interval 10 DAY)'확정일'
FROM ORDERS;
SELECT orderid '주문번호', DATE_FORMAT(orderdate,'%Y-%m-%d')'주문일',custid'고객번호',bookid'도서번호'
FROM Orders
WHERE orderdate = STR_TO_DATE('20240707','%Y%m%d');
SELECT SYSDATE(),NOW(), DATE_FORMAT(SYSDATE(),'%Y/%m/%d %a %h:%i') 'SYSDATE_1';
CREATE TABLE MYBOOK(bookid int auto_increment primary key, price int );
insert into mybook values(null,10000);
insert into mybook values(null,20000);
insert into mybook values(null,null);
select sum(price)'총합' from mybook;
select price + 100 from mybook where bookid = 3;
select sum(price), avg(price),count(*), count(price)from mybook;
select * from mybook where price is null;
select * from mybook where price= ''; -- 우리 반은 없어야 함
select name '이름', ifnull(phone,'연락처 없음')'전화번호' from customer;
select * from customer;
SET @seq:=0;
SELECT (@seq:=@seq+1)'순번' , custid, name, phone
FROM Customer
WHERE @seq<2;
CREATE VIEW Vorders
AS SELECT o.orderid, o.custid,c.name, o.bookid,b.bookname,o.saleprice,o.orderdate
   FROM Customer c, Orders o, Book b
   WHERE c.custid= o.custid and b.bookid=o.bookid;
SELECT * FROM Vorders where name = '김연아';
CREATE VIEW vm_Book_ball
AS SELECT *
   FROM BOOK
   WHERE  bookname like '%축구%';
select * from vm_book_ball;
select * from vm_Customer;
CREATE OR REPLACE VIEW vm_Customer(custid,name,address)
AS SELECT custid,name,address
   FROM Customer
   WHERE  address like '%영국%';
DROP VIEW vm_Customer;


select length(bookname), char_length(bookname) from book where publisher = '굿스포츠';

drop view highorders;
-- 1) 
create view highorders as select orders.bookid 도서번호, book.bookname 도서이름, customer.name 고객이름, book.publisher 출판사, orders.saleprice 판매가격 from orders, book, customer where orders.saleprice >= 20000 and book.bookid = orders.bookid and orders.custid = customer.custid;
select * from highorders;

-- 2) 
select 도서이름, 고객이름 from highorders;

-- 3)
create or replace view highorders as select orders.bookid 도서번호, book.bookname 도서이름, customer.name 고객이름, book.publisher 출판사 from orders, book, customer where orders.saleprice >= 20000 and book.bookid = orders.bookid and orders.custid = customer.custid;
select 도서이름, 고객이름 from highorders;


-- 인덱스
create index i_book on book(bookname);
create index i_book2 on book(publisher, price);

show index from book;
-- Query > Explain Current Statement 메뉴에서 확인
select * from book where publisher = '대한미디어' and price >= 3000;
-- 최적화 하기
analyze table book;
-- 인덱스 삭제하기
drop index i_book on book;
drop index i_book2 on book;