
create or replace package body pkg_car_model_mgmt as
    procedure upsert_model (pi_manufacturer varchar, pi_model_name varchar, pi_model_trim varchar, pi_body_style varchar, pi_weight number, pi_year_introduced varchar);
    
end pkg_car_model_mgmt;
/


