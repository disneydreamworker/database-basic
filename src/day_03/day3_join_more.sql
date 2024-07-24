/*
조인이 필요한 이유는 하나의 스키마 내부에 여러 릴레이션이 있기 때문이다.
조인은 릴레이션을 기반으로 (테이블의 관계) 수행되는 연산이다.
조인은 sql:1999 문법 이전과 이후로 구분된다.
  - 등가 조인 (equi join) => natural join / inner join
  - 외부 조인 / 포괄 조인 (outer join) => left outer join, right outer join
  - 자체 조인 (self join) =>
  - 비등가 조인
  - 카티시안 곱 (cross join) => cross join
*/

------------------------------------------------------------------------
use hr;

-- 등가 조인 = 이너 조인 = 이퀴 조인 = natural 조인
SELECT emp.employee_id 사원번호,
emp.first_name 이름,
emp.department_id 부서번호,
dept.department_name 부서이름
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id;


-- SELF JOIN : 각 사원을 관리하는 상사의 이름을 조회하세요
select a.employee_id, a.first_name 사원이름, a.manager_id 상사번호, b.employee_id 상사의사원번호, b.first_name 상사이름
from employees a, employees b
where a.manager_id = b.employee_id;


-- LEFT OUTER JOIN 
-- 1999년 이전
select a.employee_id, a.first_name 사원이름, a.manager_id 상사번호, b.employee_id 상사의사원번호, b.first_name 상사이름
from employees a, employees b
where a.manager_id = b.employee_id;
-- 1999년 이후 ANSI



-- 1. 모든 사원의 이름, 부서번호, 부서 이름을 조회하세요
select first_name, e.department_id, department_name 
from employees e INNER JOIN departments d ON e.department_id;

-- 2. 부서번호 80 에 속하는 모든 업무의 고유 목록을 작성하고 출력결과에 부서의 위치를 출력하세요
select distinct job_id, l.postal_code
from employees e
INNER JOIN departments d ON e.department_id = d.department_id
inner join locations l on  d.location_id = l.location_id
WHERE e.department_id = 80;

-- 3. 커미션을 받는 사원의 이름, 부서 이름, 위치번호와 도시명을 조회하세요
select e.first_name, e.last_name, e.department_id, l.location_id, l.city
from employees e 
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
where e.commission_pct is not null;

-- 4. 이름에 a(소문자)가 포함된 모든 사원의 이름과 부서명을 조회하세요

-- 5. 'Toronto'에서 근무하는 모든 사원의 이름, 업무, 부서 번호 와 부서명을 조회하세요

-- 6. 사원의 이름 과 사원번호를 관리자의 이름과 관리자 아이디와 함께 표시하고 각각의 컬럼명을 Employee, Emp#, Manger, Mgr#으로 지정하세요


