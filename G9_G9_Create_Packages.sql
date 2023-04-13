
create or replace package pkg_customer_mgmt as
    function upsert_customer (pi_first_name varchar, pi_last_name varchar, pi_email varchar, pi_address varchar, pi_area_code varchar, pi_phone_number varchar) return number;
    function get_customer_registration (pi_email varchar) return number;
    function get_customer_registration (pi_area_code varchar, pi_phone_number varchar)return number;
end pkg_customer_mgmt;
/

create or replace package pkg_dealer_mgmt as
    function upsert_dealer (pi_dealer_name varchar, pi_email varchar, pi_address varchar, pi_area_code varchar, pi_phone_number varchar, pi_website varchar) return number;
    function get_dealer_registration (pi_input varchar) return number;
--    function get_dealer_registration (pi_dealer_name varchar) return number;
end pkg_dealer_mgmt;
/

create or replace package pkg_car_model_mgmt as
    function upsert_model (pi_manufacturer varchar, pi_model_name varchar, pi_model_trim varchar, pi_body_style varchar, pi_weight number, pi_year_introduced varchar) return number;
    
end pkg_car_model_mgmt;
/

create or replace package pkg_manufacturer_mgmt as
    function upsert_manufacturer (pi_manufacturer varchar, pi_country varchar, pi_descript varchar, pi_year_founded varchar) return number;
    
end pkg_manufacturer_mgmt;
/


create or replace package pkg_inventory_mgmt as
    procedure upsert_inventory (pi_dealer_id number, pi_vin varchar, pi_mid number, pi_interior_color varchar, pi_exterior_color varchar, pi_title varchar, pi_miles varchar, pi_is_hidden varchar);
    procedure delete_inventory (pi_vin varchar);

end pkg_inventory_mgmt;
/

create or replace package pkg_features_mgmt as
    procedure insert_features (pi_vin varchar, pi_cylinders number, pi_mpg varchar, pi_fuel varchar, pi_drive_type varchar, pi_transmission varchar, SUNROOF char, MOONROOF char, HEATED_SEATS char,MULTIMEDIA char, CRUISE_CONTROL char);
    procedure update_features (pi_vin varchar, pi_cylinders number, pi_mpg varchar, pi_fuel varchar, pi_drive_type varchar, pi_transmission varchar, pi_SUNROOF char, pi_MOONROOF char, pi_HEATED_SEATS char,pi_MULTIMEDIA char, pi_CRUISE_CONTROL char);

end pkg_features_mgmt;
/
create or replace package pkg_connections_mgmt as
    procedure create_connection (pi_cid number, pi_did number, pi_content varchar);

end pkg_connections_mgmt;
/
create or replace package pkg_reviews_mgmt as
    procedure write_review (pi_cid number, pi_did number, pi_content varchar);
    procedure delete_review (pi_rid number);
    procedure update_review (pi_rid number, pi_content varchar);

end pkg_reviews_mgmt;
/
create or replace package pkg_favorites_mgmt as
    procedure add_favorite (pi_cid number, pi_vin varchar);
    procedure delete_favorite (pi_faid number);
end pkg_favorites_mgmt;
/

grant execute on pkg_customer_mgmt to zongyao, fangyu, ming;
grant execute on pkg_dealer_mgmt to zongyao, fangyu, ming;
grant execute on pkg_car_model_mgmt to zongyao, fangyu, ming;
grant execute on pkg_manufacturer_mgmt to zongyao, fangyu, ming;
grant execute on pkg_inventory_mgmt to zongyao, fangyu, ming;
grant execute on pkg_features_mgmt to zongyao, fangyu, ming;
grant execute on pkg_connections_mgmt to zongyao, fangyu, ming;
grant execute on pkg_reviews_mgmt to zongyao, fangyu, ming;
grant execute on pkg_favorites_mgmt to zongyao, fangyu, ming;
