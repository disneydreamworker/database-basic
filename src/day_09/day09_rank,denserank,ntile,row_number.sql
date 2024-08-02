/*
순위 함수 : 조회 결과에 순위를 부여
	row_number : 모든 행을 대상으로 유일 값으로 순위를 부여 (1,2,3,4,5) , 정렬 시 우선 순위가 존재함
    rank : 우선 순위가 없어서 같은 순위를 부여 (1, 1, 1, 4, 5)
    dense_rank : 순위가 같을 때 순위를 뛰어넘지 않음 (1, 1, 2, 2, 3, 4, 4, 5, 5, 5, 6)
    ntile(n) : 인자로 지정한 개수만큼 그룹화 하고 각 그룹의 순위를 부여, 행이 속한 그룹의 순위 (n개의 그룹으로 나눠 차등 순위 매김)
*/

-- row_number ex over:정렬조건에 대한 옵션
use employees;
select *, row_number() over(order by sal desc, department_id desc) as row_sal
from (
	select employee_id, sum(salary) sal, department_id from employees group by department_id
) as ex;

-- rank ex
use bookstore;
select *, rank() over(order by saleprice desc) as rank_price
from orders;

-- partition by ex
select orderid, saleprice, row_number() over(partition by custid order by saleprice desc, orderid) as num, custid from orders;

-- dense_rank ex
select dense_rank() over(order by saleprice desc) as num, saleprice, orderid from orders;

-- ntile ex
select row_number() over(order by saleprice desc) as row_num, saleprice , ntile(4) over(order by saleprice desc) as num from orders;