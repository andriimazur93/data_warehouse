CREATE TABLE st_locations (
	location_id INT NOT NULL,
	street_address VARCHAR(40),
	postal_code VARCHAR(12),
	city VARCHAR(30) NOT NULL,
	state_province VARCHAR(25),
	country_id CHAR(2) NOT NULL,
	created_date DATETIME DEFAULT GETDATE(),
	updated DATETIME
) on [primary]
go