
-- Regions 테이블 생성
create table regions(
	region_id int unsigned not null,
    region_name varchar(25),
    primary key (region_id)
);


-- Countries 테이블 생성
create table countries (
	country_id char(2) not null,
    country_name varchar(40),
    region_id int unsigned not null,
    primary key (country_id)
);

-- Locations
create table locations(
	location_id int unsigned auto_increment,
    street_address varchar(40),
    postal_code varchar(12),
    city varchar(30) not null,
    state_province varchar(30),
    country_id char(2) not null,
    primary key (location_id)
);



-- Departments
create table departments (
	department_id int unsigned not null,
    department_name varchar(30) not null,
    manager_id int unsigned,
    location_id int unsigned,
    primary key (department_id)
);



-- jobs 
create table jobs (
	job_id varchar(20) not null,
    job_title varchar(40) not null, 
    min_salary decimal(8,0) unsigned,
    max_salary decimal(8,0) unsigned,
    primary key (job_id)
);


drop table job_history;
-- job_history
create table job_history (
	employee_id int unsigned not null,
	start_date date not null, 
	end_date date not null,
	job_id varchar(20) not null,
    department_id int unsigned not null
);



drop table employees;
-- EMPLOYEES 사원 테이블 생성
create table employees (
	employee_id int unsigned not null,				-- 사원 번호
    first_name varchar(20),							-- 성
    last_name varchar(30) not null,					-- 이름
    email varchar(30),								-- 이메일
    phone_number varchar(20),						-- 전화번호
    hire_date date not null, 						-- 입사일
    job_id varchar(10) not null,					-- 직무 번호
    salary decimal(8,2) not null, 					-- 월급
    commission_pct decimal(2,2), 					-- 커미션 (수당)
    manager_id int unsigned,						-- 메니저 번호
    department_id integer unsigned,					-- 부서 번호
    primary key (employee_id)
);



alter table job_history add unique index(
	employee_id, start_date
);	-- 사원의 이력 관리


