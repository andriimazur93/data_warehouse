-- run in dw schema

-- 1. check max job_run_id
select max(job_run_id) from dw_job_run_summary

-- 2. update the max_job_run_id with a new date
update dw_job_run_summary
set start_date_Time = '2022-05-20 12:47:28.700'
where job_run_id = 57

-- 3. check if it worked
select cast(max(start_date_time) as date) 
from dw_job_run_summary
where tablename = 'employees'
and status = 'Success'

-- 4. start python script python main.py

-- 5. check if the salary was updated in the staging table
select salary from st_employees
where employee_id = 206

-- 6. change if there are deparments in staging table
select * from st_departments

-- 7. load to ODS 
exec load_ods

select salary from ods_hr
where employee_id = 206

-- 8. load to dim_table
exec load_dim_employees

-- 9. load to fact table
exec load_fact_hr

-- 10. check if it worked
select *
from fact_hr fact
join dim_employees dim_emp
on dim_emp.employees_dim_key = fact.employee_dim_key
where dim_emp.employee_id = 206
