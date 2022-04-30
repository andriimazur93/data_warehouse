create table ods_hr
(
	id 					int IDENTITY(1,1) PRIMARY KEY
	, employee_id 		int 
	, first_name 		varchar(50)
    , last_name		    varchar(50)
    , email			    varchar(60)
    , phone_number		varchar(30)
    , start_date		DateTime2(3)
	, end_date		    DateTime2(3)
    , job_id		    varchar(30)
    , manager_id		int 
    , department_id		int	
    , department_name	varchar(50)
    , location_id		int
    , city			    varchar(50)
    , state_province	varchar(50)	
	, country_name		varchar(50)	
	, region_name		varchar(50)	
	, salary		    Decimal(13,2) 
	, commission_pct	    Decimal(5,2)
	, created_on		DateTime2(3) DEFAULT getDate()
	, updated_on		DateTime2(3) DEFAULT getDate()
)