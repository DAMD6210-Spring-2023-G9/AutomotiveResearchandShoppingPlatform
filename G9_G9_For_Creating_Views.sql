show user;

--CLEANUP VIEWS
set serveroutput on
declare
    v_view_exists varchar(1) := 'Y';
    v_sql varchar(2000);
begin
   dbms_output.put_line('Start schema cleanup');
   for i in (select 'DEALER_INVENTORY_VIEW' view_name from dual union all
             select 'DEALER_REVIEWS' view_name from dual union all
             select 'DEALERSHIPS' view_name from dual union all
             select 'FAVORITE_VEHICLE_VIEW' view_name from dual union all
             select 'VEHICLE_LISTING_VIEW' view_name from dual union all
             select 'VEHICLE_MODEL_DETAILED_VIEW' view_name from dual
   )
   loop
   dbms_output.put_line('....Drop view '||i.view_name);
   begin
       select 'Y' into v_view_exists
       from USER_VIEWS
       where VIEW_NAME=i.view_name;

       v_sql := 'drop view '||i.view_name;
       dbms_output.put_line(v_sql);
       execute immediate v_sql;
       dbms_output.put_line('........View '||i.view_name||' dropped successfully');
       
   exception
       when no_data_found then
           dbms_output.put_line('........View already dropped');
   end;
   end loop;
   dbms_output.put_line('Schema cleanup successfully completed');
exception
   when others then
      dbms_output.put_line('Failed to execute code:'||sqlerrm);
end;
/

--Vehicle Listing View
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
    inventory inv
    JOIN car_model cm ON inv.mid = cm.mid
    JOIN manufacturer man ON cm.fid = man.fid
    JOIN dealer d ON inv.did = d.did;
/
describe vehicle_listing_view;
-- select dealer_name, phone_number from dealer;
-- update dealer set phone_number=959663 where dealer_name='ABC Motors';

--Dealer Reviews View
CREATE VIEW Dealer_Reviews AS
SELECT c.first_name || ' ' || c.last_name AS reviewer_name,
       r.content AS review_content,
       r.date_reviewed AS review_date,
       d.dealer_name AS dealer_name   
FROM 
    reviews r
    JOIN customer c ON r.cid = c.cid
    JOIN dealer d ON r.did = d.did;
/
describe dealer_reviews;



--Dealerships View
CREATE VIEW Dealerships AS
SELECT d.dealer_name,
       d.address,
       d.phone_number,
       d.website,
       d.year_joined
From  
    dealer d;
/
describe dealerships;




--Vehicle Model Detailed View
CREATE VIEW vehicle_model_detailed_view AS
SELECT cm.model_name, m.make_name, f.cylinders, f.mpg, f.fuel, f.drive_type, f.transmission,
f.sunroof, f.moonroof, f.heated_seats, f.multimedia, f.cruise_control
FROM car_model cm
JOIN features f ON cm.mid = f.mid
JOIN manufacturer m ON cm.fid = m.fid;
/
describe vehicle_model_detailed_view;


--Dealer Inventory View
CREATE VIEW dealer_inventory_view AS
SELECT d.dealer_name,d.address, i.vin, cm.model_name, cm.body_style, i.interior_color, i.exterior_color,
i.miles, i.date_added, i.title
FROM dealer d
JOIN inventory i ON d.did = i.did
JOIN car_model cm ON i.mid = cm.mid;
/
describe dealer_inventory_view;

--Favorite Vehicle View
CREATE VIEW favorite_vehicle_view AS
SELECT 
  f.faid, 
  c.first_name || ' ' || c.last_name AS customer_name, 
  i.vin, 
  m.make_name, 
  cm.fid as car_make_fid,
  cm.model_name,
  cm.model_trim,
  i.interior_color, 
  i.exterior_color, 
  i.miles, 
  i.date_added
FROM 
  favorites f 
  JOIN customer c ON f.cid = c.cid 
  JOIN inventory i ON f.vin = i.vin 
  JOIN car_model cm ON i.mid = cm.mid
  JOIN manufacturer m ON m.fid = cm.fid;
/
describe favorite_vehicle_view;

COMMIT;
--
select * from favorite_vehicle_view;
select * from dealer_inventory_view;
select * from dealerships;
select * from vehicle_listing_view;
select * from dealer_reviews;
select * from vehicle_model_detailed_view;

grant all on vehicle_listing_view to ming, zongyao, fangyu;
grant all on dealer_reviews to ming, zongyao, fangyu;
grant all on dealerships to ming, zongyao, fangyu;
grant all on vehicle_model_detailed_view to ming, zongyao, fangyu;
grant all on dealer_inventory_view to ming, zongyao, fangyu;
grant all on favorite_vehicle_view to ming, zongyao, fangyu;