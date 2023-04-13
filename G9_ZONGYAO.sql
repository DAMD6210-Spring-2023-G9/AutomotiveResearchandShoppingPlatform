show user;

create table TEST (
    test_id NUMBER PRIMARY KEY
    );

grant all on TEST to FANGYU, MING;

select * from g9.dealer;
select * from g9.customer;
select * from g9.reviews;
select * from g9.favorites;
select * from g9.inventory;
select * from g9.car_make;
select * from g9.connections;
select * from g9.features;
select * from g9.manufacturer;

CREATE SEQUENCE manufacturer_id
START WITH 1
INCREMENT BY 1;

INSERT INTO manufacturer (fid, make_name, country, descript, year_founded) VALUES (manufacturer_id.nextval, 'Ford', 'USA', 'One of the oldest founders', '1903');
INSERT INTO manufacturer (fid, make_name, country, descript, year_founded) VALUES (manufacturer_id.nextval, 'GMC', 'USA', 'American heavy duty vehicle manufacurer', '1911');
INSERT INTO manufacturer (fid, make_name, country, descript, year_founded) VALUES (manufacturer_id.nextval, 'Audi', 'Germany', 'German luxry car brand', '1909');
INSERT INTO manufacturer (fid, make_name, country, descript, year_founded) VALUES (manufacturer_id.nextval, 'BMW', 'Germany', 'German luxry car brand', '1916');
commit;


------------------------------- Test ---------------------------------
describe g9.pkg_customer_mgmt;
select * from g9.customer;
--select g9.pkg_customer_mgmt.upsert_customer('Zongyao', 'Li', 'li.zongyao@northeastern.edu', '360 Huntington St.', '218', '119911') from dual;

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

-- Test pkg_favorites_mgmt

--
