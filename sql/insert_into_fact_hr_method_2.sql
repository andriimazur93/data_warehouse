insert into fact_hr(
    employee_dim_key
    , manager_dim_key
    , job_dim_key
    , departments_dim_key
    , location_dim_key
    , salary
    , commission_pct
)
select dim_emp.employees_dim_key
, coalesce(dim_mgr.manager_dim_key, 0) as manager_dim_key
, dim_jobs.job_dim_key
, coalesce(dim_dep.departments_dim_key, 0) as departments_dim_key
, coalesce(dim_loc.location_dim_key, 0) as location_dim_key
, emp.salary
, coalesce(emp.commission_pct, 0.0) as commission_pct
from st_employees emp
join dim_employees dim_emp
    on emp.employee_id = dim_emp.employee_id
    and replace(cast(emp.hire_date as Date), '-', '') = dim_emp.hire_date
left join dim_managers dim_mgr
    on dim_mgr.manager_id = emp.manager_id
left join dim_jobs
    on dim_jobs.job_id = emp.job_id
left join dim_departments dim_dep
    on dim_dep.department_id = emp.department_id
left join st_departments st_dep
    on st_dep.department_id = emp.department_id
left join st_locations st_loc
    on st_loc.location_id = st_dep.location_id
left join dim_locations dim_loc
    on dim_loc.location_id = st_loc.location_id