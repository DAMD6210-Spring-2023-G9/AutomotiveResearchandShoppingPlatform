
CREATE OR REPLACE PROCEDURE addUser (first_name IN varchar, last_name IN varchar, address IN varchar, area_code number, phone_number number) 
AS   total number(2) := 0; 
BEGIN 
   SELECT count(*) into total 
   FROM customers; 
    
   RETURN total; 
END; 
/ 




CREATE OR REPLACE
FUNCTION upsert_customer (
  first_name VARCHAR2,
  last_name VARCHAR2,
  email VARCHAR2,
  address VARCHAR2,
  area_code NUMBER,
  phone_number NUMBER
) RETURN NUMBER
IS
  cid NUMBER;
BEGIN
  -- check if username already exists
  SELECT COUNT(*) INTO cid FROM customer WHERE email = upsert_customer.email;
  IF cid > 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Username already exists');
  END IF;
  -- insert new customer
  SELECT CUSTOMER_ID.NEXTVAL INTO cid from dual;
  INSERT INTO customer (cid, first_name, last_name, email, address, area_code, phone_number, year_joined)
  VALUES (cid, first_name, last_name, email, address, area_code, phone_number, SYSDATE);

  COMMIT;
  RETURN cid;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/

DECLARE
  result NUMBER;
BEGIN
  result := user_register('Louie', 'JJ', '123 Main St', 123, 5551234, 'john.doe@example.com', 'password123');
  IF result = 1 THEN
    DBMS_OUTPUT.PUT_LINE('User registration successful');
  ELSE
    DBMS_OUTPUT.PUT_LINE('User registration failed');
  END IF;
END;
/
select * from customer;
/


CREATE OR REPLACE FUNCTION check_name_uniqueness(
    p_dealer_name IN VARCHAR2
) RETURN NUMBER
IS
    v_count NUMBER;
BEGIN

    SELECT COUNT(*) INTO v_count FROM dealer WHERE dealer_name = p_dealer_name;

  
    IF v_count > 0 THEN
        RETURN 0;
    END IF;


    RETURN 1;
END;
/

CREATE OR REPLACE FUNCTION dealer_register(
    p_dealer_name IN VARCHAR2,
    p_address IN VARCHAR2,
    p_area_code IN NUMBER,
    p_phone_number IN NUMBER,
    p_year_joined IN DATE,
    p_website IN VARCHAR2
) RETURN NUMBER
IS
    v_did NUMBER;
BEGIN

 IF check_name_uniqueness(p_dealer_name) = 0 THEN
        RETURN 0;
    END IF;
    
    SELECT dealer_id.NEXTVAL INTO v_did FROM DUAL;
    
    INSERT INTO dealer (
        did,
        dealer_name,
        address,
        area_code,
        phone_number,
        year_joined,
        website
    ) VALUES (
        v_did,
        p_dealer_name,
        p_address,
        p_area_code,
        p_phone_number,
        p_year_joined,
        p_website
    );

    
    RETURN 1;
EXCEPTION
    WHEN OTHERS THEN  
        RETURN 0;
END;

/

DECLARE
    v_result NUMBER;
BEGIN
    v_result := dealer_register('ABC Motors', '123 Main St', 123, 5551234, SYSDATE, 'www.abcmotors.com');

    IF v_result = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Dealer registration successful');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Dealer registration failed');
    END IF;
END;
/
select * from connections;




