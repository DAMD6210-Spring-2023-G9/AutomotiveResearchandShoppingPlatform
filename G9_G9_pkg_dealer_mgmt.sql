create or replace package body pkg_dealer_mgmt as
    procedure upsert_dealer (pi_dealer_name varchar, pi_email varchar, pi_address varchar, pi_area_code varchar, pi_phone_number varchar, pi_website varchar);
    function get_dealer_registration (pi_email varchar) return number;
    function get_dealer_registration (pi_dealer_name varchar) return number;
end pkg_dealer_mgmt;
/





