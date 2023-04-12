



CREATE OR REPLACE PROCEDURE addUser (first_name IN varchar, last_name IN varchar, address IN varchar, area_code number, phone_number number) 
AS   total number(2) := 0; 
BEGIN 
   SELECT count(*) into total 
   FROM customers; 
    
   RETURN total; 
END; 
/ 