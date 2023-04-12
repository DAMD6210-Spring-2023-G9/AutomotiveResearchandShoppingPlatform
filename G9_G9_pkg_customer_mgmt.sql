
create or replace package body pkg_customer_mgmt as
    procedure upsert_customer (pi_first_name varchar, pi_last_name varchar, pi_email varchar, pi_address varchar, pi_area_code varchar, pi_phone_number varchar);
    function get_customer_registration (pi_email varchar) return number;
    function get_customer_registration (pi_first_name varchar, pi_last_name varchar)return number;
end pkg_customer_mgmt;
/

