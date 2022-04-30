create table dim_locations(
    location_dim_key in IDENTITY(1,1)
    , location_id int
    , street_address varchar(255)
    , postal_code varchar(255)
    , city varchar(50)
    , state varchar(50)
    , country_name varchar(50)
    , region_name varchar(50)
    , created_on DATETIME2(3) default getdate()
    , updated_on DATETIME2(3) default getdate()
))
