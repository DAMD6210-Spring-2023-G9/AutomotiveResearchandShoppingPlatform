
set serveroutput on;
-- Test pkg_customer_mgmt
DECLARE 
    v_cid number;
begin
    v_cid:=g9.pkg_customer_mgmt.upsert_customer('Zongyao', 'Li', 'li.zongyao@northeastern.edu', '360 Huntington St.', '218', '119911');
    dbms_output.put_line(to_char(v_cid));
    v_cid:=g9.pkg_customer_mgmt.get_customer_registration ('li.zongyao@northeastern.edu');
    dbms_output.put_line('Found user with email li.zongyao@northeastern.edu cid is: ' || to_char(v_cid));
    v_cid:=g9.pkg_customer_mgmt.get_customer_registration ('218', '119911');
    dbms_output.put_line('Found user with phone number 218119911 cid is: ' || to_char(v_cid));
end;
/

-- Test pkg_dealer_mgmt
DECLARE 
    v_did number;
begin
    v_did:=g9.pkg_dealer_mgmt.upsert_dealer('Northeastern Car Sales', 'car.sales@northeastern.edu', '360 Huntington St.', '302', '519559', 'carsale.northeastern.edu');
    dbms_output.put_line(to_char(v_did));
    v_did:=g9.pkg_dealer_mgmt.get_dealer_registration ('car.sales@northeastern.edu');
    dbms_output.put_line('Found dealer with email car.sales@northeastern.edu cid is: ' || to_char(v_did));
    v_did:=g9.pkg_dealer_mgmt.get_dealer_registration ('Northeastern Car Sales');
    dbms_output.put_line('Found dealer with name Northeastern Car Sales cid is: ' || to_char(v_did));
end;


/
-- Test pkg_car_model_mgmt
describe g9.pkg_car_model_mgmt;
select * from g9.car_model;
DECLARE 
    v_mid number;
begin
    v_mid:=g9.pkg_car_model_mgmt.upsert_model('Ford', 'Escape', 'basic', 'SUV', '2000', '2000-03-03');
    dbms_output.put_line(to_char(v_mid));
end;
/

--select * from g9.car_model where model_name = 'A6' and model_trim='basic' and year_introduced=to_date('2000-03-03','yyyy-mm-dd');


-- Test pkg_manufacturer_mgmt
describe g9.pkg_manufacturer_mgmt;

DECLARE 
    v_fid number;
begin
    v_fid:=g9.pkg_manufacturer_mgmt.upsert_manufacturer('Jeep', 'U.S.A.', 'Affiliated with Chrysler', '1980');
    dbms_output.put_line(to_char(v_fid));
end;
/

select * from g9.manufacturer where make_name='Jeep';


-- Test pkg_features_mgmt
select * from g9.features;
exec g9.pkg_features_mgmt.insert_features(300000000003, 6, '18/22', 'gas', 'le', 'Auto', 'y', 'y', 'y','y', 'y');
exec g9.pkg_features_mgmt.update_features(5000000006, 300000000003, 6, '18/22', 'gas', '4wd', 'Auto', '1', '1', '1','1', '1');

