create or alter procedure load_dim_locations
as 
BEGIN

    Begin
        insert into dim_locations(
            location_id
            , street_address
            , postal_code
            , city
            , state
            , country_name
            , region_name
        )

        select loc.location_id
            , loc.street_address
            , loc.postal_code
            , loc.city
            , loc.state_province
            , country.country_name
            , reg.region_name
        from st_locations loc
        join st_countries country
        on loc.country_id = country.country_id
        join st_regions reg
        on reg.region_id = country.region_id
        where not EXISTS(
            select 1 from dim_locations dim_loc
            where dim_loc.location_id = loc.location_id
        )
    END;

    BEGIN

        update dim_loc
        set dim_loc.city = loc.city
        , dim_loc.country_name = loc.country_name
        , dim_loc.postal_code = loc.postal_code
        , dim_loc.region_name = loc.region_name
        , dim_loc.state = loc.state_province
        , dim_loc.street_address = loc.street_address
        , dim_loc.updated_on = GETDATE()
        from dim_locations dim_loc
        join (
            select loc.location_id
                , loc.street_address
                , loc.postal_code
                , loc.city
                , loc.state_province
                , country.country_name
                , reg.region_name
            from st_locations loc
            join st_countries country
            on loc.country_id = country.country_id
            join st_regions reg
            on reg.region_id = country.region_id) loc
        on dim_loc.location_id = loc.location_id
    END;
End