create or alter procedure load_dim_jobs
AS
Begin

    Begin
        insert into dim_jobs(
            job_id
            , job_title
            , min_salary
            , max_salary
        )

        select job_id
        , job_title
        , min_salary
        , max_salary
        from st_jobs jobs
        where not exists(
            select 1
            from dim_jobs
            where dim_jobs.job_id = jobs.job_id
        )
    End;

    Begin
        update dim_jobs
        set dim_jobs.job_title = jobs.job_title
        , dim_jobs.min_salary = jobs.min_salary
        , dim_jobs.max_salary = jobs.max_salary 
        , dim_jobs.updated_on = GETDATE()
        from dim_jobs
        join (
            select job_id
        , job_title
        , min_salary
        , max_salary
        from st_jobs jobs
        ) jobs
        on jobs.job_id = dim_jobs.job_id
    End;
End;