/*
분석함수 : 데이터 그룹을 기반으로 앞뒤 행을 계산하거나 그룹에 대한 누적분포, 상대순위 계산 시 사용 , 집계함수와 달리 그룹마다 여러 행을 반환
	- lag() : 현재 행의 바로 앞 행을 조회
    - lead() : 현재 행의 바로 뒤 행을 조회
		- 전후 데이터 차이값을 연산할 때 편리하게 확인할 수 있다
	- cume_dist() : 한 데이터값이 해당하는 그룹의 누적분포를 계산 , 0 초과 1 이하의 범위값을 반환, 같은 값은 같은 누적 분포값으로 계산, null은 최화위값으로 처리
    - percent_rank() : 그룹 내 상대 순위를 나타냄, 분포 순위를 계산 , 상위 % 표현
*/


-- lead, lag EX
 select orderid, lag(saleprice) over(order by saleprice asc) as lag_amount, saleprice, lead(saleprice) over(order by saleprice asc) as lead_amount from orders;
 
 -- cume_dist EX
 select custid, saleprice, cume_dist() over (order by saleprice desc) from orders order by saleprice desc;
 
 -- percent_rank EX
 select saleprice, percent_rank() over(order by saleprice desc) from orders order by saleprice desc;