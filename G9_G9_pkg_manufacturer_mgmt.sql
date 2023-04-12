create or replace package body pkg_manufacturer_mgmt as
    procedure upsert_manufacturer (pi_manufacturer varchar, pi_country varchar, pi_descipt varchar, pi_year_founded varchar);
    
end pkg_manufacturer_mgmt;
/


