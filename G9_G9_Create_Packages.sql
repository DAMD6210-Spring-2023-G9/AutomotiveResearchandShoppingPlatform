
create or replace package pkg_customer_mgmt as
    function upsert_customer (pi_first_name varchar, pi_last_name varchar, pi_email varchar, pi_address varchar, pi_area_code varchar, pi_phone_number varchar) return number;
    function get_customer_registration (pi_email varchar) return number;
    function get_customer_registration (pi_first_name varchar, pi_last_name varchar)return number;
end pkg_customer_mgmt;
/

create or replace package pkg_dealer_mgmt as
    function upsert_dealer (pi_dealer_name varchar, pi_email varchar, pi_address varchar, pi_area_code varchar, pi_phone_number varchar, pi_website varchar) return number;
    function get_dealer_registration (pi_email varchar) return number;
    function get_dealer_registration (pi_dealer_name varchar) return number;
end pkg_dealer_mgmt;
/

create or replace package pkg_car_model_mgmt as
    function upsert_model (pi_manufacturer varchar, pi_model_name varchar, pi_model_trim varchar, pi_body_style varchar, pi_weight number, pi_year_introduced varchar) return number;
    
end pkg_car_model_mgmt;
/

create or replace package pkg_manufacturer_mgmt as
    function upsert_manufacturer (pi_manufacturer varchar, pi_country varchar, pi_descipt varchar, pi_year_founded varchar) return number;
    
end pkg_manufacturer_mgmt;
/


create or replace package pkg_inventory_mgmt as
    function upsert_inventory (pi_dealer_id varchar, pi_vin varchar, pi_make varchar, pi_interior_color varchar, pi_exterior_color varchar, pi_title varchar, pi_miles varchar, pi_is_hidden varchar) return number;
    
end pkg_inventory_mgmt;
/

grant execute on pkg_customer_mgmt to zongyao, fangyu, ming;
grant execute on pkg_dealer_mgmt to zongyao, fangyu, ming;
grant execute on pkg_car_model_mgmt to zongyao, fangyu, ming;
grant execute on pkg_manufacturer_mgmt to zongyao, fangyu, ming;
grant execute on pkg_inventory_mgmt to zongyao, fangyu, ming;

