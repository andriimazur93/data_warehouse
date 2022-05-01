create or alter procedure load_fact_hr
as
Begin

    select ods.* into #ods
    from ods_hr ods
    join st_employees st_emp
    on st_emp.employee_id = ods.employee_id
        and st_emp.hire_date = ods.start_date
        and st_emp.department_id = ods.department_id
        and st_emp.job_id = ods.job_id


    -- truncate table fact_hr

    delete fact
    from fact_hr fact
    join dim_employees dim_emp
        on dim_emp.employees_dim_key = fact.employee_dim_key
    join st_employees st_emp
        on st_emp.employee_id = dim_emp.employee_id
        and replace(cast(st_emp.hire_date as Date), '-', '')  = dim_emp.hire_date
        

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
    , ods.salary
    , ods.commission_pct
    from #ods ods
    join dim_employees dim_emp
        on dim_emp.employee_id = ods.employee_id
        and replace(cast(ods.start_date as Date), '-', '') = dim_emp.hire_date
    left join dim_managers dim_mgr
        on dim_mgr.manager_id = ods.manager_id
    left join dim_jobs
        on dim_jobs.job_id = ods.job_id
    left join dim_departments dim_dep
        on dim_dep.department_id = ods.department_id
    left join dim_locations dim_loc
        on dim_loc.location_id = ods.location_id
End;