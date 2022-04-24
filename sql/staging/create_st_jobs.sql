CREATE TABLE st_jobs (
	job_id VARCHAR(10) NOT NULL,
	job_title VARCHAR(35) NOT NULL,
	min_salary DECIMAL(8, 0),
	max_salary DECIMAL(8, 0),
	created_date DATETIME DEFAULT GETDATE(),
	updated DATETIME
) on [primary]
go
