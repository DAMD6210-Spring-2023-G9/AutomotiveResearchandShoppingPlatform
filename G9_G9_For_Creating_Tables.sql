show user;

--CLEANUP TABLES
set serveroutput on
declare
    v_table_exists varchar(1) := 'Y';
    v_sql varchar(2000);
begin
   dbms_output.put_line('Start schema cleanup');
   for i in (select 'REVIEWS' table_name from dual union all
             select 'FAVORITES' table_name from dual union all
             select 'INVENTORY' table_name from dual union all
             select 'CONNECTIONS' table_name from dual union all
             select 'FEATURES' table_name from dual union all
             select 'CAR_MODEL' table_name from dual union all
             select 'MANUFACTURER' table_name from dual union all
             select 'DEALER' table_name from dual union all
             select 'CUSTOMER' table_name from dual
   )
   loop
   dbms_output.put_line('....Drop table '||i.table_name);
   begin
       select 'Y' into v_table_exists
       from USER_TABLES
       where TABLE_NAME=i.table_name;

       v_sql := 'drop table '||i.table_name ||' purge';
       dbms_output.put_line(v_sql);
       execute immediate v_sql;
       dbms_output.put_line('........Table '||i.table_name||' dropped successfully');
       
   exception
       when no_data_found then
           dbms_output.put_line('........Table already dropped');
   end;
   end loop;
   dbms_output.put_line('Schema cleanup successfully completed');
exception
   when others then
      dbms_output.put_line('Failed to execute code:'||sqlerrm);
end;
/
--CLEANUP SEQUENCE
declare
    v_sequence_exists varchar(1) := 'Y';
    v_sql varchar(2000);
begin
    for i in (select 'REVIEWS_ID' sequence_name from dual union all
             select 'FAVORITES_ID' sequence_name from dual union all
             select 'CONNECTIONS_ID' sequence_name from dual union all
             select 'FEATURES_ID' sequence_name from dual union all
             select 'CAR_MODEL_ID' sequence_name from dual union all
             select 'MANUFACTURER_ID' sequence_name from dual union all
             select 'DEALER_ID' sequence_name from dual union all
             select 'CUSTOMER_ID' sequence_name from dual
    )
    loop
    dbms_output.put_line('Start sequence cleanup');
    begin
        select 'Y' into v_sequence_exists
        from USER_SEQUENCES
        where SEQUENCE_NAME=i.sequence_name;
        v_sql := 'DROP SEQUENCE '||i.sequence_name;
        execute immediate v_sql;
        dbms_output.put_line('........SEQUENCE '||i.sequence_name||' dropped successfully');
    exception
        when no_data_found then
            dbms_output.put_line('........sequence already dropped');
    end;
    end loop;
exception
    when others then
        dbms_output.put_line('........sequence already dropped');
end;
/
--CREATE SEQUENCE
CREATE SEQUENCE DEALER_ID START WITH 10000001 INCREMENT BY 1 MINVALUE 10000001 MAXVALUE 19999999;
CREATE SEQUENCE CUSTOMER_ID START WITH 100000000001 INCREMENT BY 1 MINVALUE 100000000001 MAXVALUE 199999999999;
CREATE SEQUENCE REVIEWS_ID START WITH 2000000000000000000000000001 INCREMENT BY 1 MINVALUE 2000000000000000000000000001 MAXVALUE 2999999999999999999999999999;
CREATE SEQUENCE CAR_MODEL_ID START WITH 300000000001 INCREMENT BY 1 MINVALUE 300000000001 MAXVALUE 399999999999;
CREATE SEQUENCE CONNECTIONS_ID START WITH 4000000000000000000000000001 INCREMENT BY 1 MINVALUE 4000000000000000000000000001 MAXVALUE 4999999999999999999999999999999;
CREATE SEQUENCE FAVORITES_ID START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 999;
CREATE SEQUENCE FEATURES_ID START WITH 5000000001 INCREMENT BY 1 MINVALUE 5000000001 MAXVALUE 5999999999;
CREATE SEQUENCE MANUFACTURER_ID START WITH 700001 INCREMENT BY 1 MINVALUE 700001 MAXVALUE 799999;
/
--CREATE TABLES AS PER DATA MODEL
create table customer (
    cid number(12) default customer_id.nextval primary key,
    first_name varchar(50) not null,
    last_name varchar(50),
    email varchar (255) unique not null,
    address varchar(255),
    area_code varchar(3),
    phone_number varchar(6) unique,
    year_joined date default sysdate not null
)
/

create table dealer (
    did number(8) default dealer_id.nextval primary key,
    dealer_name varchar(50) not null,
    email varchar(100) unique not null,
    address varchar(255),
    area_code varchar(3) not null,
    phone_number varchar(6) not null unique,
    year_joined date not null,
    website varchar(100)
)

/
create table manufacturer (
    fid number(6) default manufacturer_id.nextval primary key,
    make_name varchar(50) not null unique,
    country varchar(20),
    descript varchar(255),
    year_founded varchar(4)
)

/
create table car_model (
    mid number(12) default car_model_id.nextval primary key,
    fid number(6) not null,
    model_name varchar(50) not null,
    model_trim varchar(50) default 'basic',
    body_style varchar(10),
    weight number(4),
    year_introduced date
)
/
create table features (
    ftid number(10) default features_id.nextval primary key ,
    mid number(12),
    cylinders number(2),
    mpg varchar(20),
    fuel varchar(5),
    drive_type varchar(3),
    transmission varchar(10),
    sunroof char(1),
    moonroof char(1),
    heated_seats char(1),
    multimedia char(1),
    cruise_control char(1),
    foreign key (mid) references car_model (mid)
)
/
create table inventory (
  vin VARCHAR(17) primary key,
  did number(8) not null,
  mid number(12) not null,
  ftid number(10) not null,
  interior_color varchar(20),
  exterior_color varchar(20),
  title varchar(10),
  miles number(4),
  date_added date,
  is_hidden char(1),
  foreign key (did) references dealer (did),
  foreign key (mid) references car_model (mid),
  foreign key (ftid) references car_model (ftid)
)
/
create table favorites (
    faid number(3) default favorites_id.nextval primary key,
    cid number(12),
    vin varchar(17),
    date_added date,
    foreign key (cid) references customer (cid),
    foreign key (vin)  references inventory (vin)
)
/
create table reviews (
    rid number(31) default reviews_id.nextval primary key,
    cid number(12),
    did number(8),
    content varchar(225),
    date_reviewed date,
    foreign key (did) references dealer (did),
    foreign key (cid) references customer (cid)    
)
/
create table connections (
    cvid number(31) default connections_id.nextval primary key,
    cid number(12),
    did number(8),
    content varchar(225),
    date_connected date,
    foreign key (did) references dealer (did),
    foreign key (cid) references customer (cid)    
)
/

INSERT INTO manufacturer (fid, make_name, country, descript, year_founded) VALUES (manufacturer_id.nextval, 'Ford', 'USA', 'One of the oldest founders', '1903');
INSERT INTO manufacturer (fid, make_name, country, descript, year_founded) VALUES (manufacturer_id.nextval, 'GMC', 'USA', 'American heavy duty vehicle manufacurer', '1911');
INSERT INTO manufacturer (fid, make_name, country, descript, year_founded) VALUES (manufacturer_id.nextval, 'Audi', 'Germany', 'German luxry car brand', '1909');
INSERT INTO manufacturer (fid, make_name, country, descript, year_founded) VALUES (manufacturer_id.nextval, 'BMW', 'Germany', 'German luxry car brand', '1916');

select * from manufacturer;
insert into car_model values(car_model_id.nextval,70003, 'A6', 'basic', 'sports car', 2500, to_date('2000-03-03', 'yyyy-mm-dd'));
insert into car_model values(car_model_id.nextval,70004, '440i', 'xdrive-40', 'Sedan', 3000, to_date('2000-03-03', 'yyyy-mm-dd'));
insert into car_model values(car_model_id.nextval,70003, 'Mustang', 'luxory', 'coupe', 4000, to_date('2010-12-01', 'yyyy-mm-dd'));

select * from Features;
insert into Features values(features_id.nextval,300000000001,4, '22/11', 'gas', '4wd', 'manual', '1', '0', '1','1','0');
insert into Features values(features_id.nextval,300000000002,4, '12/3', 'gas', 'fwd', 'Auto', '0', '0', '0','1','0');
insert into Features values(features_id.nextval,300000000003,6, '12/3', 'gas', '2wd', 'Auto', '1', '1', '0','1','1');

select * from dealer;
insert into dealer values (dealer_id.nextval,'Boston Motors', 'customer@bostonmotors.com','01 Clifton Street, Malden', 021, 313131, to_date('2011-02-21', 'yyyy-mm-dd'), 'https://github.com/youngyangyang04'
);
insert into dealer values (dealer_id.nextval,'The Greatest Value','customer@tgv.com', '01 Clifton Street, Malden', 021, 518725, to_date('2011-02-21', 'yyyy-mm-dd'), 'https://youngyangyang'
);
insert into dealer values (dealer_id.nextval,'Selected Auto','customer@selectedauto.com', '01 Clifton Street, Malden', 021, 777777, to_date('2011-02-21', 'yyyy-mm-dd'), 'https://youngyangyang04'
);
update dealer set year_joined = to_date('2012-06-21', 'yyyy-mm-dd') where dealer_name = 'Boston Motors';
update dealer set year_joined = to_date('2009-05-01', 'yyyy-mm-dd') where dealer_name = 'The Greatest Value';

update dealer set address = '01 Pleasant Street, Malden' where dealer_name = 'The Greatest Value';
update dealer set address = '05 Terr Street, Malden' where dealer_name = 'Selected Auto';

select * from customer;
insert into customer values(customer_id.nextval,'Harry', 'Potter', 'Harry.Potter@Hog.edu', '4 Privet Drive',  001, 987789, to_date('1998-09-20', 'yyyy-mm-dd'));
insert into customer values(customer_id.nextval,'Ron', 'Weasley',  'Ron.W2@Hog.edu', 'Hogwards', 002, 511155, to_date('1999-10-20', 'yyyy-mm-dd'));
insert into customer values(customer_id.nextval,'Jack', 'Williams', 'Jack.W3@Hog.edu', 'Hogwards',  003, 797979, to_date('2001-03-10', 'yyyy-mm-dd'));

select * from connections;
insert into connections values(connections_id.nextval, 100000000001, 10000001, 'can price go any lower?', to_date('2023-02-02', 'yyyy-mm-dd'));
insert into connections values(connections_id.nextval, 100000000001, 10000002, 'can I get your number?', to_date('2023-02-03', 'yyyy-mm-dd'));
insert into connections values(connections_id.nextval, 100000000003, 10000002, 'how is the car condition?', to_date('2023-01-23', 'yyyy-mm-dd'));

select * from dealer;
insert into inventory values('LGWEFSEE3DFA333F2',10000001,300000000001,'Black', 'red', 'clean', '2000', to_date('2000-01-03', 'yyyy-mm-dd') , '0');
insert into inventory values('LGWSSSDE3DFAWS3SS',10000002,300000000002,'white', 'white', 'clean', '3000', to_date('2019-01-03', 'yyyy-mm-dd') , '0');
insert into inventory values('LVWEDDSEE3EFA534F',10000002,300000000003,'Grey', 'Black', 'clean', '3050', to_date('2021-11-21', 'yyyy-mm-dd') , '0');
select interior_color from inventory where vin='LVWEDDSEE3EFA534F';

insert into Reviews values(reviews_id.nextval,100000000001,10000001,'i like it',to_date('2018-03-12','yyyy-mm-dd'));
insert into Reviews values(reviews_id.nextval,100000000002,10000001,'i love the car so much',to_date('2022-04-12','yyyy-mm-dd'));
insert into Reviews values(reviews_id.nextval,100000000003,10000002,'everything is great',to_date('2021-03-22','yyyy-mm-dd'));

insert into favorites values(favorites_id.nextval,100000000001,'LGWEFSEE3DFA333F2',to_date('2019-03-08','yyyy-mm-dd'));
insert into favorites values(favorites_id.nextval,100000000002,'LGWSSSDE3DFAWS3SS',to_date('2020-04-11','yyyy-mm-dd'));
insert into favorites values(favorites_id.nextval,100000000003,'LVWEDDSEE3EFA534F',to_date('2019-05-10','yyyy-mm-dd'));

commit;
