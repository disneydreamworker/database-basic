use world;

-- Q6 
select truncate(surfacearea, 1) from country;

-- Q7 
select substr(name, 2, 4) from country;

-- Q8
select replace(code, 'A', 'Z') from country;

-- Q9
select replace(code,'A', repeat('Z', 10)) from country;
select replace('안녕A하세요','A', repeat('Z', 10));

-- Q10
select addtime(now(), '24:00:00');

-- Q11
select subtime(now(), '24:00:00');

-- Q12 없음

-- Q13
select count(*) from country;

-- Q14
select sum(gnp) 합, avg(gnp) 평균, max(gnp) 최댓값, min(gnp) 최솟값 from country;

-- Q15
select round(lifeexpectancy, -1) from country;

-- Q16
select row_number() over(order by lifeexpectancy desc) from country;

-- Q17
select rank() over(order by lifeexpenctancy desc) from country;

-- Q18
select dense_rank() over(order by lifeexpenctancy desc) from country;