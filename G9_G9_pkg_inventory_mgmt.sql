create or replace package body pkg_inventory_mgmt as
    procedure upsert_inventory (pi_dealer_id varchar, pi_vin varchar, pi_make varchar, pi_interior_color varchar, pi_exterior_color varchar, pi_title varchar, pi_miles varchar, pi_is_hidden varchar);
    
end pkg_inventory_mgmt;
/


