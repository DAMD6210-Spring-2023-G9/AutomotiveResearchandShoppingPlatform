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

       v_sql := 'drop table '||i.table_name || ' purge';
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
CREATE SEQUENCE DEALER_ID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE CUSTOMER_ID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE REVIEWS_ID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE CAR_MODEL_ID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE CONNECTIONS_ID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE FAVORITES_ID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE FEATURES_ID START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE MANUFACTURER_ID START WITH 1 INCREMENT BY 1;
/
--CREATE TABLES AS PER DATA MODEL
create table customer (
    cid number(12) default customer_id.nextval primary key,
    first_name varchar(50) not null,
    last_name varchar(50),
    address varchar(255),
    area_code number(3),
    phone_number number(18),
    year_joined date
)
/

create table dealer (
    did number(8) default dealer_id.nextval primary key,
    dealer_name varchar(50) not null,
    address varchar(255),
    area_code number(3) not null,
    phone_number number(18) not null,
    year_joined date not null,
    website varchar(100)
)

/
create table manufacturer (
    fid number(6) default manufacturer_id.nextval primary key,
    make_name varchar(50) not null,
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
  interior_color varchar(20),
  exterior_color varchar(20),
  title varchar(10),
  miles number(4),
  date_added date,
  is_hidden char(1),
  foreign key (did) references dealer (did),
  foreign key (mid) references car_model (mid)
)
/
create table favorites (
    faid number(30) default favorites_id.nextval primary key,
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

select * from car_model;
insert into car_model values(car_model_id.nextval,3, 'A6', 'basic', 'sports car', 2500, to_date('2000-03-03', 'yyyy-mm-dd'));
insert into car_model values(car_model_id.nextval,4, '440i', 'xdrive-40', 'Sedan', 3000, to_date('2000-03-03', 'yyyy-mm-dd'));
insert into car_model values(car_model_id.nextval,3, 'Mustang', 'luxory', 'coupe', 4000, to_date('2010-12-01', 'yyyy-mm-dd'));

select * from Features;
insert into Features values(features_id.nextval,1,4, '22/11', 'gas', '4wd', 'manual', '1', '0', '1','1','0');
insert into Features values(features_id.nextval,2,3, '12/3', 'gas', 'fwd', 'Auto', '0', '0', '0','1','0');
insert into Features values(features_id.nextval,3,2, '12/3', 'gas', '2wd', 'Auto', '1', '1', '0','1','1');


insert into dealer values (dealer_id.nextval,'John Smith', '01 Clifton Street, Malden', 021, 781219223, to_date('2011-02-21', 'yyyy-mm-dd'), 'https://github.com/youngyangyang04'
);
insert into dealer values (dealer_id.nextval,'Brian', '01 Clifton Street, Malden', 021, 781219223, to_date('2011-02-21', 'yyyy-mm-dd'), 'https://youngyangyang'
);
insert into dealer values (dealer_id.nextval,'Williams', '01 Clifton Street, Malden', 021, 781219223, to_date('2011-02-21', 'yyyy-mm-dd'), 'https://youngyangyang04'
);
update dealer set year_joined = to_date('2012-06-21', 'yyyy-mm-dd') where did = 1;
update dealer set year_joined = to_date('2009-05-01', 'yyyy-mm-dd') where did = 2;

update dealer set address = '01 Pleasant Street, Malden' where did = 1;
update dealer set address = '05 Terr Street, Malden' where did = 2;

select * from customer;
insert into customer values(customer_id.nextval,'Harry', 'Potter', '4 Privet Drive', 001, 0987652345, to_date('1998-09-20', 'yyyy-mm-dd'));
insert into customer values(customer_id.nextval,'Ron', 'Weasley', 'Hogwards', 002, 0987652344, to_date('1999-10-20', 'yyyy-mm-dd'));
insert into customer values(customer_id.nextval,'Jack', 'Williams', 'Hogwards', 002, 0987652354, to_date('2001-03-10', 'yyyy-mm-dd'));

select * from connections;
insert into connections values(connections_id.nextval, 000001, 2, 'can price go any lower?', to_date('2023-02-02', 'yyyy-mm-dd'));
insert into connections values(connections_id.nextval, 000002, 1, 'can I get your number?', to_date('2023-02-03', 'yyyy-mm-dd'));
insert into connections values(connections_id.nextval, 000002, 3, 'how is the car condition?', to_date('2023-01-23', 'yyyy-mm-dd'));

insert into inventory values('LGWEFSEE3DFA333F2',1,1,'Black', 'red', 'clean', '2000', to_date('2000-01-03', 'yyyy-mm-dd') , '0');
insert into inventory values('LGWSSSDE3DFAWS3SS',2,2,'white', 'white', 'clean', '3000', to_date('2019-01-03', 'yyyy-mm-dd') , '0');
insert into inventory values('LVWEDDSEE3EFA534F',2,3,'Grey', 'Black', 'clean', '3050', to_date('2021-11-21', 'yyyy-mm-dd') , '0');
select interior_color from inventory where vin='LVWEDDSEE3EFA534F';

insert into Reviews values(reviews_id.nextval,1,1,'i like it',to_date('2018-03-12','yyyy-mm-dd'));
insert into Reviews values(reviews_id.nextval,2,1,'i love the car so much',to_date('2022-04-12','yyyy-mm-dd'));
insert into Reviews values(reviews_id.nextval,3,2,'everything is great',to_date('2021-03-22','yyyy-mm-dd'));

insert into favorites values(favorites_id.nextval,1,'LGWEFSEE3DFA333F2',to_date('2019-03-08','yyyy-mm-dd'));
insert into favorites values(favorites_id.nextval,2,'LGWSSSDE3DFAWS3SS',to_date('2020-04-11','yyyy-mm-dd'));
insert into favorites values(favorites_id.nextval,3,'LVWEDDSEE3EFA534F',to_date('2019-05-10','yyyy-mm-dd'));

commit;
