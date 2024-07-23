-- fk 추가 작업
alter table countries add foreign key (region_id) references regions(region_id);
alter table locations add foreign key (country_id) references countries(country_id);
alter table departments add foreign key (location_id) references locations(location_id);
alter table departments add foreign key (manager_id) references employees(employee_id);

alter table employees add foreign key (department_id) references departments(department_id);
alter table employees add foreign key (job_id) references jobs(job_id);
alter table employees add foreign key (manager_id) references employees(employee_id);

alter table job_history add foreign key (job_id) references jobs(job_id);
alter table job_history add foreign key (employee_id) references employees(employee_id);
alter table job_history add foreign key (department_id) references departments(department_id);





