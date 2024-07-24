select employee_id, concat (first_name,' ',last_name) as "name", salary, hire_date, manager_id from employees;

select concat(first_name,' ',last_name) as "Name", b.job_title as "Job", salary as "Salary", (salary + 100)*12 as "Increased_Salary" from employees a, jobs b 
where a.job_id = b.job_id;

select distinct department_id, job_id from employees;

select concat (last_name, ': 1 Year Salary = $', salary * 12) as "1 Year Salary"
from employees;

select concat(first_name,' ',last_name) as "Name", salary
from employees
-- where salary < 7000 or salary >=10000
where salary not between 7000 and 10000
order by salary;

