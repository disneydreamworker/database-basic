use hr;
-- SQL Practice 1
--  A.1 데이터 검색 : SELECT

-- [문제 0] 사원정보(EMPLOYEE) 테이블에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원번호를 출력하시오. 이때 이름은 성과 이름을 연결하여 Name이라는 별칭으로 출력하시오
select 
	e.employee_id 사원번호, 
	concat(e.first_name, ' ' , e.last_name) as Name, 
	e.salary as '급여',
	j.job_name as '업무',
	e.hire_date as '입사일',
	e.manager_id as '상사의 사원번호'
from employees e, jobs j
where e.job_id = j.job_id;


-- [문제 1] 사원정보(EMPLOYEES)  테이블에서 사원의 성과 이름은 Name, 업무는 Job, 급여는 Salary, 연봉에 $100 보너스를 추가하여 계산한 값은
-- Increased Ann_Salary, 급여에 $100 보너스를 추가하여 계산한 연봉은 Increased Salary라는 별칭으로 출력하시오
select 
	concat(first_name, ' ' ,last_name) Name, 
	job_id Job,
	salary Salary,
    salary * 12 + 100 as 'Increased Ann_Salary',
    (salary + 100) * 12 as 'Increased Salary'
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

select distinct department_id, department_name
from departments;


-- A.2 데이터 제한 및 정렬 : WHERE, ORDER BY
 /*[문제 0] HR 부서에서 예산 편성 문제로 급여 정보 보고서를 작성하려고 한다. 사원정보(EMPLOYEES) 테
이블에서 급여가 $7,000~$10,000 범위 이외인 사람의 성과 이름(Name으로 별칭) 및 급여를 급여가 작은 
순서로 출력하시오(75행).*/
select
	concat(first_name, ' ', last_name) Name,
    salary
from employees
where salary not between 7000 and 10000
order by salary;

 /*[문제 1] 사원의 이름(last_name) 중에 ‘e’ 및 ‘o’ 글자가 포함된 사원을 출력하시오. 이때 머리글은 ‘e 
and o Name’라고 출력하시오  */
select
	last_name as 'e and o Name'
from employees
where last_name like '%e%' or last_name like '%o%'; --  와일드 문자~!!! e 또는 o를 포함하는 문자열을 찾는다

/*[문제 2] 현재 날짜 타입을 날짜 함수를 통해 확인하고, 2006년 05월 20일부터 2007년 05월 20일 사이에 
고용된 사원들의 성과 이름(Name으로 별칭), 사원번호, 고용일자를 출력하시오. 단, 입사일이 빠른 순으로 
정렬하시오 */
select now();
select current_date();

select
	concat(first_name, ' ' ,last_name) Name, 
	employee_id 사원번호,
    hire_date 고용일자
from employees
where hire_date between '2006-05-20'and '2007-05-20'
order by hire_date;


/*[문제 3] HR 부서에서는 급여(salary)와 수당율(commission_pct)에 대한 지출 보고서를 작성하려고 한다. 
이에 수당을 받는 모든 사원의 성과 이름(Name으로 별칭), 급여, 업무, 수당율을 출력하시오. 이때 급여가 
큰 순서대로 정렬하되, 급여가 같으면 수당율이 큰 순서대로 정렬하시오*/
select
	concat(first_name, ' ' ,last_name) Name,
    salary 급여,
    job_id 업무,
    commission_pct 수당율
from employees
where commission_pct is not null
order by salary desc, commission_pct desc;



-- A.3 단일 행 함수 및 변환 함수
/*[문제 0] 이번 분기에 60번 IT 부서에서는 신규 프로그램을 개발하고 보급하여 회사에 공헌하였다. 이에 
해당 부서의 사원 급여를 12.3% 인상하기로 하였다. 60번 IT 부서 사원의 급여를 12.3% 인상하여 정수만
(반올림) 표시하는 보고서를 작성하시오. 출력 형식은 사번, 이름과 성(Name으로 별칭), 급여, 인상된 급
여(Increased Salary로 별칭)순으로 출력한다*/
select
		employee_id 사번,
        concat(first_name,'', last_name) as Name,
        salary,
        salary * 1.123 as 'Increased Salary'
from employees
where employees.department_id = 60;
 
/*
[문제 1] 각 사원의 성(last_name)이 ‘s’로 끝나는 사원의 이름과 업무를 아래의 예와 같이 출력하고자 한
다. 출력 시 성과 이름은 첫 글자가 대문자, 업무는 모두 대문자로 출력하고 머리글은 Employee JOBs로 
표시하시오(18행).
 □예 James Landry is a ST_CLERK
 (hint) INITCAP, UPPER, SUBSTR 함수를 사용하며 SUBSTR 함수의 경우 뒤에서부터 첫글자는 두 번째 
인자에 –1을 사용한다. */

SELECT 
  CONCAT(upper(substr(first_name, 1, 1)), substr(first_name, 2), upper(substr(last_name, 1, 1)), substr(last_name, 2),' is a ', upper(job_id)) AS "Employee JOBs"
FROM employees;



/*
[문제 2] 모든 사원의 연봉을 표시하는 보고서를 작성하려고 한다. 보고서에 사원의 성과 이름(Name으로 
별칭), 급여, 수당여부에 따른 연봉을 포함하여 출력하시오. 수당여부는 수당이 있으면 “Salary + 
Commission”, 수당이 없으면 “Salary only”라고 표시하고, 별칭은 적절히 붙인다. 또한 출력 시 연봉이 
높은 순으로 정렬한다(107행).*/

select 
	concat(first_name,' ', last_name) as Name,
    salary,
    case 
		when commission_pct is not null then 'Salary+Commission'
        else 'SalaryOnly'
	end as 수당여부,
	salary * (1 + IFNULL(commission_pct, 0)) * 12 연봉
from employees
order by 
	case 
		when commission_pct is not null then 'Salary+Commission'
        else 'SalaryOnly'
	end desc; 


/*
 [문제 3] 모든 사원들 성과 이름(Name으로 별칭), 입사일 그리고 입사일이 어떤 요일이였는지 출력하시오. 
이때 주(week)의 시작인 일요일부터 출력되도록 정렬하시오(107행)*/
select 
	concat(first_name,'', last_name) as Name,
    hire_date,
    dayname(hire_date)
from employees
order by dayofweek(hire_date);


-- A.4 집계된 데이터 보고 : 집계 함수
/*[문제 0] 모든 사원은 직속 상사 및 직속 직원을 갖는다. 단, 최상위 또는 최하위 직원은 직속 상사 및 직
원이 없다. 소속된 사원들 중 어떤 사원의 상사로 근무 중인 사원의 총 수를 출력하시오*/
select count(distinct m.employee_id)
from employees e, employees m
where e.manager_id = m.employee_id;


/*
[문제 1] 각 사원이 소속된 부서별로 급여 합계, 급여 평균, 급여 최대값, 급여 최소값을 집계하고자 한다. 
계산된 출력값은 6자리와 세 자리 구분기호, $ 표시와 함께 출력하고 부서번호의 오름차순 정렬하시오. 
단, 부서에 소속되지 않은 사원에 대한 정보는 제외하고 출력시 머리글은 아래 예시처럼 별칭(alias) 처리
하시오
(hint) 출력 양식 정하는 방법 - TO_CHAR(SUM(salary), '$999,999.00')*/
select
	department_id 부서번호,
    concat('$', format(sum(salary), '#,#')) 급여합계,
    concat('$', format(avg(salary), '#,#')) 급여평균,
    concat('$', format(max(salary), '#,#'))급여최대값,
    concat('$', format(min(salary), '#,#'))급여최소값
from employees
where department_id is not null
group by department_id;


 /*[문제 2] 사원들의 업무별 전체 급여 평균이 $10,000보다 큰 경우를 조회하여 업무, 급여 평균을 출력하시
오. 단 업무에 사원(CLERK)이 포함된 경우는 제외하고 전체 급여 평균이 높은 순서대로 출력하시*/
select
	j.job_title 업무,
    avg(salary) 급여평균
from employees e, jobs j
where 
	e.job_id = j.job_id and j.job_title <> '%CLERK%'
group by e.job_id
having avg(e.salary) >= 10000
order by avg(e.salary )desc;

select job_title 업무, avg(salary) '급여 평균'
from employees, jobs
where jobs.job_id = employees.job_id and not jobs.job_id like '%CLERK%'
group by employees.job_id
having avg(salary) >= 10000
order by avg(salary) desc;



-- JOIN 과제
-- 1. 모든 사원의 이름, 부서번호, 부서 이름을 조회하세요
select 
	first_name 이름, 
    e.department_id 부서번호, 
    department_name 부서이름
from employees e INNER JOIN departments d ON e.department_id
where e.department_id = d.department_id;

-- 2. 부서번호 80 에 속하는 모든 업무의 고유 목록을 작성하고 출력결과에 부서의 위치를 출력하세요
select 
	distinct j.job_title 고유업무목록,
    concat(l.country_id, ' ', l.city, ' ', l.street_address) 부서위치
from employees e
inner join departments d on e.department_id = d.department_id
inner join locations l on  d.location_id = l.location_id
inner join jobs j on e.job_id = j.job_id
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
where e1.employee_id = 202;


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


select
	concat(e.first_name, ' ', e.last_name) 이름,
    j.job_title 업무, 
    d.department_name 부서이름, 
    e.salary 급여,
    g.grade_level 급여등급
from employees e, jobs j, departments d, job_grades g
where e.department_id = d.department_id and e.job_id = j.job_id 
and e.salary between g.lowest_sal and g.highest_sal
order by g.grade_level desc;


