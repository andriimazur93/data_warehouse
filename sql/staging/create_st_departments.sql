CREATE TABLE st_departments (
	department_id INT NOT NULL,
	department_name VARCHAR(30) NOT NULL,
	manager_id INT,
	location_id INT,
	created_date DATETIME DEFAULT GETDATE(),
	updated DATETIME
) on [primary]
go