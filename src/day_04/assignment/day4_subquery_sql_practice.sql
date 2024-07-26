use hr;
--  A.6 서브쿼리를 사용하여  해결 하세요


/*[문제 1]HR 부서의 어떤 사원은 급여정보를 조회하는 업무를 맡고 있다. Tucker(last_name) 사원보다 
급여를 많이 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 급여를 출력하시오 */
select salary from employees e where last_name = 'Tucker'; -- $10000
select
	concat(first_name, ' ', last_name) Name,
    j.job_title 업무,
    salary 급여
from employees e, jobs j
where e.job_id = j.job_id and salary > (
	select salary from employees e where last_name = 'Tucker'
)
order by salary;


/*[문제 2] 사원의 급여 정보 중 업무별 최소 급여를 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 
급여, 입사일을 출력하시오 */

-- distinct job_id 는 총 19개 
select min(salary) from employees group by job_id;

select
	concat(first_name, ' ', last_name) Name,
    j.job_title 업무,
	salary 급여,
    hire_date 입사일
from employees e, jobs j
where e.job_id = j.job_id and salary = any (
	select min(salary) from employees group by job_id
); -- 결과 34개. job_id가 동일할 때 조건까지 추가해줘야 함

 select
	concat(e.first_name, ' ', e.last_name) Name,
    j.job_title 업무,
    j.job_id,
	e.salary 급여,
    e.hire_date 입사일
from employees e
inner join  jobs j on e.job_id = j.job_id
inner join (
	select job_id, min(salary) minS
    from employees
    group by job_id
) e2 on e.job_id = e2.job_id and e.salary = e2.minS;

-- SELECT
--     CONCAT(e.first_name, ' ', e.last_name) AS Name,
--     j.job_title AS 업무,
--     e.salary AS 급여,
--     e.hire_date AS 입사일
-- FROM employees e
-- INNER JOIN jobs j ON e.job_id = j.job_id
-- WHERE (e.job_id, e.salary) IN (
--     SELECT job_id, MIN(salary)
--     FROM employees
--     GROUP BY job_id
-- )
-- ORDER BY j.job_title;



/*[문제 3] 소속 부서의 평균 급여보다 많은 급여를 받는 사원에 대하여 사원의 성과 이름(Name으로 별칭), 
급여, 부서번호, 업무를 출력하시오 */

select avg(salary), department_id
from employees 
group by department_id;

select
  concat(e.first_name, ' ', e.last_name) Name,
  e.salary 급여,
  e.department_id 부서번호,
  j.job_title 업무
from employees e
inner join  jobs j on e.job_id = j.job_id
inner join (
  select avg(salary) as avgS, department_id from employees group by department_id) e2
  on e.department_id = e2.department_id
  and e.salary > e2.avgS;


/*[문제 4] 사원들의 지역별 근무 현황을 조회하고자 한다. 도시 이름이 영문 'O' 로 시작하는 지역에 살고 
있는 사원의 사번, 이름, 업무, 입사일을 출력하시오 */
select
	e.employee_id 사번,
    concat(e.first_name, ' ', e.last_name) 이름,
    e.job_id 업무,
    e.hire_date 입사일,
    e.department_id 부서명
from employees e
inner join departments d on e.department_id = d.department_id
inner join (select city, location_id from locations where city like 'O%') l on d.location_id = l.location_id;


/*[문제 5] 모든 사원의 소속부서 평균연봉을 계산하여 사원별로 성과 이름(Name으로 별칭), 업무, 급여, 부
서번호, 부서 평균연봉(Department Avg Salary로 별칭)을 출력하시오 */
select avg(salary), department_id from employees group by department_id;

select 
	concat(e.first_name, ' ', e.last_name) Name,
    e.job_id 업무,
    e.salary 급여,
    e.department_id 부서번호,
	(select avg(salary) from employees group by department_id having 부서번호 = department_id) as 'Department Avg Salary'
from employees e;


/*[문제 6] ‘Kochhar’의 급여보다 많은 사원의 정보를 사원번호,이름,담당업무,급여를 출력하시오. */
select salary from employees where last_name = 'Kochhar';
select salary from employees where salary > 17000; 

select 
	employee_id 사원번호,
    concat(first_name, ' ', last_name) 이름,
    job_id 담당업무,
    salary 급여
from employees
where salary > (select salary from employees where last_name = 'Kochhar');


/* 문제 7] 급여의 평균보다 적은 사원의 사원번호,이름,담당업무,급여,부서번호를 출력하시오 */
select avg(salary) from employees;

select 
	employee_id 사원번호,
    concat(first_name, ' ', last_name) 이름,
    job_id 담당업무,
    salary 급여,
    department_id 부서번호
from employees
where salary < (select avg(salary) from employees);


/*문제 8] 100번 부서의 최소 급여보다 최소 급여가 많은 다른 모든 부서를 출력하시오*/
select min(salary) from employees where department_id = 100; -- 6900
-- 모든 부서마다의 최소 급여를 뽑아서
-- 6900 과 비교해서 더 많은 부서를 출력
select min(salary), department_id from employees group by department_id;

select distinct department_id
from employees
where department_id in 
	(select department_id from employees group by department_id having min(salary) > 
    (select min(salary) from employees where department_id = 100));


/*문제 9] 업무별로 최소 급여를 받는 사원의 정보를 사원번호,이름,업무,부서번호를 출력하시오. 출력시 업무별로 정렬하시오*/
select min(salary), job_id from employees group by job_id;

select 
	e.employee_id 사원번호,
    concat(e.first_name, ' ', e.last_name) 이름,
    e.job_id 업무,
    e.department_id 부서번호,
    e.salary
from employees e
where (e.job_id, e.salary) in (
	select job_id, min(salary)
    from employees
    group by job_id
)
order by job_id;


/*문제 10] 100번 부서의 최소 급여보다 최소 급여가 적은 다른 모든 부서를 출력하시오*/
select min(salary) from employees where department_id = 100; -- 6900
select min(salary), department_id from employees group by department_id;

select distinct department_id
from employees
where department_id in 
	(select department_id from employees group by department_id having min(salary) < 
    (select min(salary) from employees where department_id = 100));
    
    
/*문제 11] 업무가 SA_MAN인 사원의 정보를 이름,업무,부서명,근무지를 출력하시오.*/
select employee_id from employees where job_id = 'SA_MAN'; -- 5명
select
	concat(e.first_name, ' ', e.last_name) 이름,
    e.job_id 업무,
    d.department_name 부서명,
    concat(l.city, ' ', l.street_address, " ", l.postal_code) 근무지
from employees e, departments d, locations l
where e.department_id = d.department_id and d.location_id = l.location_id and e.employee_id in (select employee_id from employees where job_id = 'SA_MAN');


/*문제 12] 가장 많은 부하직원을 갖는 MANAGER의 사원번호와 이름을 출력하시오*/
select count(employee_id), manager_id from employees group by manager_id;
select max(cnt) from (select count(employee_id) cnt from employees group by manager_id) as c;  -- 14 
-- 14명의 부하직원을 갖는 직원의 사원번호 찾기
select
	employee_id 사원번호,
    concat(first_name, ' ', last_name) 이름
from employees
where employee_id = (
	select manager_id
    from (
		select manager_id, count(employee_id) as cnt
        from employees
        group by manager_id
	) as Managers
    where cnt = (
		select max(cnt)
        from (
			select count(employee_id) as cnt
            from employees
            group by manager_id
		) as MaxManagers
	)
);

/*문제 13] 사원번호가 123인 사원의 업무가 같고 사원번호가 192인 사원의 급여(SAL))보다 많은 사원의 사원번호,이름,직업,급여를 출력하시오 */
select job_id
from employees
where employee_id = 123; -- ST_MAN

select salary
from employees
where employee_id = 192; -- 4000

select 
	employee_id 사원번호,
    concat(first_name, ' ', last_name) 이름,
    job_id 직업,
    salary 급여
from employees
where salary > (
	select salary
	from employees
	where employee_id = 192
) and job_id = (
	select job_id
	from employees
	where employee_id = 123
);


/*문제 14] 50번 부서에서 최소 급여를 받는 사원보다 많은 급여를 받는 사원의 사원번호,이름,업무,입사일
자,급여,부서번호를 출력하시오.  단 50번 부서의 사원은 제외합니다. */
select 
	employee_id 사원번호,
    concat(first_name, ' ', last_name) 이름,
    job_id 업무,
    hire_date 입사일자,
    salary 급여,
    department_id 부서번호
from employees
where salary > (
		-- 50번 부서에서 최소 급여를 찾기
        select min(salary)
        from employees
        where department_id = 50
) and department_id <> 50;


/*문제 15]  (50번 부서의 최고 급여)를 받는 사원 보다 많은 급여를 받는 사원의 사원번호,이름,업무,입사일
자,급여,부서번호를 출력하시오.  단 50번 부서의 사원은 제외합니다.*/
select 
	employee_id 사원번호,
    concat(first_name, ' ', last_name) 이름,
    job_id 업무,
    hire_date 입사일자,
    salary 급여,
    department_id 부서번호
from employees
where salary > (
		-- 50번 부서에서 최고 급여를 찾기
        select max(salary)
        from employees
        where department_id = 50
) and department_id <> 50;


