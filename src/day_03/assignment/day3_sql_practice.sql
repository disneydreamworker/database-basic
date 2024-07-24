use hr;

-- [문제 0] 사원정보(EMPLOYEE) 테이블에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원번호를 출력하시오. 이때 이름은 성과 이름을 연결하여 Name이라는 별칭으로 출력하시오
select 
	employee_id 사원번호, 
	concat(first_name, ' ' ,last_name) as Name, 
	salary as '급여',
	job_id as '업무',
	hire_date as '입사일',
	manager_id as '상사의 사원번호'
from employees;

-- [문제 1] 사원정보(EMPLOYEES)  테이블에서 사원의 성과 이름은 Name, 업무는 Job, 급여는 Salary, 연봉에 $100 보너스를 추가하여 계산한 값은
-- Increased Ann_Salary, 급여에 $100 보너스를 추가하여 계산한 연봉은 Increased Salary라는 별칭으로 출력하시오
select 
	concat(first_name, ' ' ,last_name) Name, 
	job_id Job,
	salary Salary,
    salary * 12 + 100 as 'Increased Ann_Salary',
    (salary + 100) *12 as 'Increased Salary'
from employees;

-- [문제 2] 사원정보(EMPLOYEE) 테이블에서 모든 사원의 이름(last_name)과 연봉을 “이름: 1 Year Salary = $연봉” 형식으로 출력하고, 1 Year Salary라는 별칭을 붙여 출력하시오
select concat(last_name, ': 1 Year Salary = $', salary*12) as '1 Year Salary'
from employees;

-- [문제 3] 부서별로 담당하는 업무를 한 번씩만 출력하시오
select 
	job_id 업무, 
    department_id 부서번호
from employees
group by job_id
order by department_id;


-- JOIN 과제
-- 1. 모든 사원의 이름, 부서번호, 부서 이름을 조회하세요
select 
	first_name 이름, 
    e.department_id 부서번호, 
    department_name 부서이름
from employees e INNER JOIN departments d ON e.department_id;

-- 2. 부서번호 80 에 속하는 모든 업무의 고유 목록을 작성하고 출력결과에 부서의 위치를 출력하세요
select 
	distinct job_id 업무,
    l.postal_code 부서위치
from employees e
inner join departments d on e.department_id = d.department_id
inner join locations l on  d.location_id = l.location_id
WHERE e.department_id = 80;

-- 3. 커미션을 받는 사원의 이름, 부서 이름, 위치번호와 도시명을 조회하세요
select 
	concat(e.first_name, ' ', e.last_name) 이름, 
    d.department_name 부서명, 
    l.location_id 위치번호, 
    l.city 도시명
from employees e 
inner join departments d on e.department_id = d.department_id
inner join locations l on d.location_id = l.location_id
where e.commission_pct is not null;

-- 4. 이름에 a(소문자)가 포함된 모든 사원의 이름과 부서명을 조회하세요
select 
	concat(e.first_name, ' ', e.last_name) 이름,
    d.department_name 부서명
from employees e
inner join departments d on e.department_id = d.department_id
where e.last_name like '%a%'
order by e.first_name;

-- 5. 'Toronto'에서 근무하는 모든 사원의 이름, 업무, 부서 번호 와 부서명을 조회하세요
select 
	concat(e.first_name, ' ', e.last_name) 이름, 
    e.job_id 업무, e.department_id 부서번호, 
    d.department_name 부서명
from employees e
inner join departments d on e.department_id = d.department_id
inner join locations l on d.location_id = l.location_id
where l.city like 'Toronto'
order by e.first_name;

-- 6. 사원의 이름 과 사원번호를 관리자의 이름과 관리자 아이디와 함께 표시하고 각각의 컬럼명을 Employee, Emp#, Manger, Mgr#으로 지정하세요
select
	concat(e1.first_name, ' ', e1.last_name) Employee,
    e1.employee_id as 'Emp#',
    concat(e2.first_name, ' ', e2.last_name) Manager,
    e2.employee_id as 'Mgr#'
from employees e1
left join employees e2 on e1.manager_id = e2.employee_id
order by e1.employee_id;


-- 7. 사장인'King'을 포함하여 관리자가 없는 모든 사원을 조회하세요 (사원번호를 기준으로 정렬하세요)
select e1.*
from employees e1
left join employees e2 on e1.manager_id = e2.employee_id
where e1.manager_id is null
order by e1.employee_id;

-- 8. 지정한 사원의 이름, 부서 번호 와 지정한 사원과 동일한 부서에서 근무하는 모든 사원을 조회하세요
select
	concat(e1.first_name, ' ', e1.last_name) 이름, 
    e1.department_id 부서번호, 
    concat(e2.first_name, ' ', e2.last_name) 동일부서사원이름, 
    e2.department_id, e2.job_id
from employees e1
inner join employees e2 on e1.department_id = e2.department_id
where e1.employee_id = 174;

-- 9. JOB_GRADES 테이블을 생성하고 모든 사원의 이름, 업무, 부서이름, 급여 , 급여등급을 조회하세요
select
	concat(e.first_name, ' ', e.last_name) 이름,
    j.job_title 업무, 
    d.department_name 부서이름, 
    e.salary 급여,
    g.grade_level 급여등급
from employees e
inner join departments d on e.department_id = d.department_id
inner join jobs j on j.job_id = e.job_id
left join job_grades g ON e.salary BETWEEN g.lowest_sal AND g.highest_sal;

