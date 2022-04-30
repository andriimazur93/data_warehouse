create table fact_hr
(
    employee_dim_key INT
    , manager_dim_key INT
    , job_dim_key INT
    , departments_dim_key INT
    , location_dim_key int
    , salary DECIMAL(13, 2)
    , commission_pct DECIMAL(5, 2)
    , created_date DATETIME DEFAULT GETDATE()
	, updated DATETIME DEFAULT GETDATE()
)