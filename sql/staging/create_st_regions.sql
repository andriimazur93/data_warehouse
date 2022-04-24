CREATE TABLE st_regions (
	region_id INT NOT NULL,
	region_name VARCHAR(25),
	created_date DATETIME DEFAULT GETDATE(),
	updated DATETIME
) on [primary]
go
