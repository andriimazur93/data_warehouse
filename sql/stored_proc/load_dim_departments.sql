create or alter procedure load_dim_departments
as
Begin

    Begin
        insert into dim_departments(
            department_id
            , department_name
        )
        select department_id
        , department_name
        from st_departments dep
        where not exists (
            select 1
            from dim_departments dim_dep
            where dim_dep.department_name = dep.department_name
        )
    End;

End;