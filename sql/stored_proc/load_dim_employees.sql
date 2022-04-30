create or alter procedure load_dim_employees
AS
Begin
    Begin
        insert into dim_employees (employee_id, first_name, last_name, email, phone_number, hire_date)
        select emp.employee_id
        , emp.first_name
        , emp.last_name
        , emp.email
        , emp.phone_number
        , replace(cast(emp.hire_date as Date), '-', '') as hire_date
        from st_employees emp 
        where not EXISTS(
            select 1
            from dim_employees dim_emp
            where 
            dim_emp.employee_id = emp.employee_id
            and dim_emp.hire_date = replace(cast(emp.hire_date as Date), '-', '')
        )
    End;
    Begin
        update dim_emp
        set
            dim_emp.first_name = emp.first_name
            , dim_emp.last_name = emp.last_name
            , dim_emp.email = emp.email
            , dim_emp.phone_number = emp.phone_number
            , dim_emp.updated_on = GETDATE()
        from dim_employees dim_emp
        join(
            select emp.employee_id
            , emp.first_name
            , emp.last_name
            , emp.email
            , emp.phone_number
            , replace(cast(emp.hire_date as Date), '-', '') as hire_date
            from st_employees emp 
        ) emp
        on dim_emp.employee_id = emp.employee_id
        and dim_emp.hire_date = replace(cast(emp.hire_date as Date), '-', '')
    End;
End;