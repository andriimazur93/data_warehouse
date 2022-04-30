create or alter procedure load_dim_managers
AS
Begin

    Begin
        insert into dim_managers(manager_id, first_name, last_name, email, phone_number, hire_date)
        select mgr.employee_id
        , mgr.first_name
        , mgr.last_name
        , mgr.email
        , mgr.phone_number
        , replace(cast(mgr.hire_date as date),'-','') as hire_date
        from st_employees mgr
        where mgr.employee_id in(
            select manager_id 
            from st_employees
            group by manager_id
        )
        and not EXISTS(
            select 1
            from dim_managers dim_man
            where dim_man.manager_id = mgr.employee_id
            and dim_man.hire_date = replace(cast(mgr.hire_date as date),'-','') 
        )
    End;

    Begin
        update dim_man
        set dim_man.first_name = mgr.first_name
            , dim_man.last_name = mgr.last_name
            , dim_man.email = mgr.email
            , dim_man.phone_number = mgr.phone_number
            , dim_man.updated_on = GETDATE()
        from dim_managers dim_man
        join (
            select mgr.employee_id
            , mgr.first_name
            , mgr.last_name
            , mgr.email
            , mgr.phone_number
            , replace(cast(mgr.hire_date as date),'-','') as hire_date
            from st_employees mgr
            where mgr.employee_id in(
                select manager_id 
                from st_employees
                group by manager_id
            )
        ) mgr
        on dim_man.manager_id = mgr.employee_id
        and dim_man.hire_date = replace(cast(mgr.hire_date as date),'-','')
    End;
End;