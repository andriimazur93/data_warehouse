CREATE TABLE st_countries (
	country_id CHAR(2) NOT NULL,
	country_name VARCHAR(40),
	region_id INT NOT NULL,
	created_date DATETIME DEFAULT GETDATE(),
	updated DATETIME
) on [primary]
go
