show user;

--CLEANUP SCRIPT
set serveroutput on
declare
    v_table_exists varchar(1) := 'Y';
    v_sql varchar(2000);
begin
   dbms_output.put_line('Start schema cleanup');
   for i in (select 'REVIEWS' table_name from dual union all
             select 'FAVORITES' table_name from dual union all
             select 'INVENTORY' table_name from dual union all
             select 'CONVERSATION' table_name from dual union all
             select 'FEATURES' table_name from dual union all
             select 'CAR_MODEL' table_name from dual union all
             select 'MANUFACTOR' table_name from dual union all
             select 'DEALER' table_name from dual union all
             select 'CUSTOMER' table_name from dual
   )
   loop
   dbms_output.put_line('....Drop table '||i.table_name);
   begin
       select 'Y' into v_table_exists
       from USER_TABLES
       where TABLE_NAME=i.table_name;

       v_sql := 'drop table '||i.table_name;
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

--CREATE TABLES AS PER DATA MODEL
create table customer (
    cid number(12) primary key,
    first_name varchar(50) not null,
    last_name varchar(50),
    address varchar(255),
    area_code number(3),
    phone_number number(18),
    year_joined date
)
/
create table dealer (
    did number(8) primary key,
    dealer_name varchar(50) not null,
    address varchar(255),
    area_code number(3) not null,
    phone_number number(18) not null,
    year_joined date not null,
    website varchar(100)
)
/
create table manufactor (
    fid number(6) primary key,
    make_name varchar(50) not null,
    country varchar(20),
    descript varchar(255),
    year_founded date
)
/
create table car_model (
    mid number(12) primary key,
    fid number(6) not null,
    model_name varchar(50) not null,
    model_trim varchar(50) default 'basic',
    body_style varchar(10),
    weight number(4),
    year_introduced date
)
/
create table features (
    ftid number(10) primary key,
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
  vin VARCHAR(17) constraint inventory_pk primary key,
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
    faid number(30) constraint favorite_pk primary key,
    cid number(12),
    vin varchar(17),
    date_added date,
    foreign key (cid) references customer (cid),
    foreign key (vin)  references inventory (vin)
)
/
create table reviews (
    rid number(31) constraint reviews_pk primary key,
    cid number(12),
    did number(8),
    content varchar(225),
    date_reviewed date,
    foreign key (did) references dealer (did),
    foreign key (cid) references customer (cid)    
)
/
create table conversation (
    cvid number(31) constraint conversation_pk primary key,
    cid number(12),
    did number(8),
    content varchar(225),
    date_connected date,
    foreign key (did) references dealer (did),
    foreign key (cid) references customer (cid)    
)
/

