CREATE TABLE st_job_history (
	employee_id INT NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	job_id VARCHAR(10) NOT NULL,
	department_id INT NOT NULL,
	created_date DATETIME DEFAULT GETDATE(),
	updated DATETIME
) on [primary]
go