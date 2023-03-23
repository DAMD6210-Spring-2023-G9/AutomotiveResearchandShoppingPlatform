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

