create or alter PROCEDURE load_ods
As
Begin

-- Declare @ODSRecCount Int;
-- 
    -- select @ODSRecCount = Count(*) from ods_hr
    -- if (@ODSRecCount = 0)
    --     Begin
    --         insert into ods_hr( 
    --             employee_id,
    --             first_name,
    --             last_name,	    
    --             email,	    
    --             phone_number,		
    --             start_date,	
    --             end_date,	    
    --             job_id,	    
    --             manager_id,		
    --             department_id,		
    --             department_name,	
    --             location_id,	
    --             city,	    
    --             state_province,	
    --             country_name,	
    --             region_name
    --         )

    --         select 
    --             emp.employee_id,
    --             emp.first_name,
    --             emp.last_name,
    --             emp.email,
    --             emp.phone_number,
    --             jobhistory.start_date,
    --             jobhistory.end_date,
    --             jobhistory.job_id,
    --             NULL manager_id,
    --             jobhistory.department_id,
    --             dep.department_name,
    --             dep.location_id,
    --             loc.city,
    --             loc.state_province,
    --             con.country_name,
    --             reg.region_id
    --         FROM st_job_history jobhistory
    --         LEFT JOIN st_employees emp
    --             on jobhistory.employee_id = emp.employee_id
    --         LEFT JOIN st_departments dep
    --             on dep.department_id = jobhistory.department_id 
    --         LEFT JOIN st_locations loc
    --             on loc.location_id = dep.location_id
    --         LEFT JOIN st_countries con
    --             on con.country_id = loc.country_id
    --         LEFT JOIN st_regions reg
    --             on reg.region_id = con.region_id
    --         left join st_jobs job
    --             on job.job_id = emp.job_id

    --     End;

        Begin
            insert into ods_hr( 
                employee_id,
                first_name,
                last_name,	    
                email,	    
                phone_number,		
                start_date,	
                end_date,	    
                job_id,	    
                manager_id,		
                department_id,		
                department_name,	
                location_id,	
                city,	    
                state_province,	
                country_name,	
                region_name,
                salary,
                commission_pct
            )
            select 
                emp.employee_id,
                emp.first_name,
                emp.last_name,
                emp.email,
                emp.phone_number,
                emp.hire_date as start_date,
                NULL as end_date,
                emp.job_id,
                emp.manager_id,
                emp.department_id,
                dep.department_name,
                dep.location_id,
                loc.city,
                loc.state_province,
                con.country_name,
                reg.region_id,
                emp.salary,
                coalesce(emp.commission_pct, 0.0) as commission_pct
            from st_employees emp
            LEFT JOIN st_departments dep
                on dep.department_id = emp.department_id 
            LEFT JOIN st_locations loc
                on loc.location_id = dep.location_id
            LEFT JOIN st_countries con
                on con.country_id = loc.country_id
            LEFT JOIN st_regions reg
                on reg.region_id = con.region_id
            left join st_jobs job
                on job.job_id = emp.job_id
            where 1=1 
            and not exists(
                select 1 from ods_hr ods
                where ods.employee_id = emp.employee_id 
                and ods.start_date = emp.hire_date
                and ods.job_id = emp.job_id
                and ods.department_id = emp.department_id
            )

            update ods
            set ods.first_name = emp.first_name,
                ods.last_name = emp.last_name,
                ods.email = emp.email,
                ods.phone_number = emp.phone_number
                
            from ods_hr ods
            join(
                    select 
                        emp.employee_id,
                        emp.first_name,
                        emp.last_name,
                        emp.email,
                        emp.phone_number,
                        emp.hire_date as start_date,
                        NULL as end_date,
                        emp.job_id,
                        emp.manager_id,
                        emp.department_id,
                        dep.department_name,
                        dep.location_id,
                        loc.city,
                        loc.state_province,
                        con.country_name,
                        reg.region_id
                    from st_employees emp
                    LEFT JOIN st_departments dep
                        on dep.department_id = emp.department_id 
                    LEFT JOIN st_locations loc
                        on loc.location_id = dep.location_id
                    LEFT JOIN st_countries con
                        on con.country_id = loc.country_id
                    LEFT JOIN st_regions reg
                        on reg.region_id = con.region_id
                    left join st_jobs job
                        on job.job_id = emp.job_id
                ) emp
                    on ods.employee_id = emp.employee_id 
                    and ods.start_date = emp.start_date
                    and ods.job_id = emp.job_id
                    and ods.department_id = emp.department_id

        End;
End;