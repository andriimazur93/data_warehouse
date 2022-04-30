create table dim_locations(
    location_dim_key int identity(1,1)
    , location_id int
    , street_address varchar(255)
    , postal_code varchar(255)
    , city varchar(50)
    , state varchar(50)
    , country_name varchar(50)
    , region_name varchar(50)
    , created_on DATETIME2(3) DEFAULT GETDATE()
    , updated_on DATETIME2(3) DEFAULT GETDATE()
)


create table dim_departments
(
    departments_dim_key int identity(1, 1)
    , department_id int
    , department_name varchar(50)
    , created_on DATETIME2(3) DEFAULT GETDATE()
    , updated_on DATETIME2(3) DEFAULT GETDATE()
)


create table dim_employees
(
    employees_dim_key int identity(1,1)
    , employee_id int
    , first_name varchar(60)
    , last_name varchar(60)
    , email varchar(60)
    , phone_number varchar(60)
    , start_date DATETIME2(3)
    , end_date DATETIME2(3)
    , created_on DATETIME2(3) DEFAULT GETDATE()
    , updated_on DATETIME2(3) DEFAULT GETDATE() 
)


create table dim_jobs
(
    job_dim_key int identity(1,1)
    , job_id varchar(60)
    , job_title varchar(60)
    , min_salary int
    , max_salary int
    , created_on DATETIME2(3) DEFAULT GETDATE()
    , updated_on DATETIME2(3) DEFAULT GETDATE()
)