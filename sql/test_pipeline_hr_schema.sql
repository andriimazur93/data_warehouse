-- run in hr schema

-- 1. set salary for employee with id 206
update employees
set salary = 7000
where employee_id = 206

-- 2. check if salary was set
select salary from employees
where employee_id = 206