show user;

create table TEST (
    test_id NUMBER PRIMARY KEY
    );
    
CREATE VIEW vehicle_listing_view AS 
SELECT 
    inv.vin,
    man.make_name,
    cm.model_name,
    cm.model_trim,
    cm.year_introduced,
    inv.miles,
    inv.interior_color,
    inv.exterior_color,
    inv.title,
    d.dealer_name,
    d.address,
    d.area_code,
    d.phone_number,
    inv.date_added
FROM 
    g9.inventory inv
    JOIN g9.car_model cm ON inv.mid = cm.mid
    JOIN g9.manufacturer man ON cm.fid = man.fid
    JOIN g9.dealer d ON inv.did = d.did;
/
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

