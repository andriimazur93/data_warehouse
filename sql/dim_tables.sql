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
    , hire_date int
    , created_on DATETIME2(3) DEFAULT GETDATE()
    , updated_on DATETIME2(3) DEFAULT GETDATE() 
)


create table dim_managers
(
    manager_dim_key int identity(1,1)
    , manager_id int
    , first_name varchar(60)
    , last_name varchar(60)
    , email varchar(60)
    , phone_number varchar(60)
    , hire_date int
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

create table dim_date
(
    date_dim_key INT
    , calendar_date varchar(10)
    , month_id SMALLINT
    , month_desc varchar(15)
    , quarter_id SMALLINT
    , quarter_desc varchar(6)
    , year_id INT
    , day_number_of_week SMALLINT
    , day_of_week_desc VARCHAR(15)
    , day_number_of_month SMALLINT
    , day_number_of_year SMALLINT
    , week_number_of_year SMALLINT
    , year_month varchar(7)
)
