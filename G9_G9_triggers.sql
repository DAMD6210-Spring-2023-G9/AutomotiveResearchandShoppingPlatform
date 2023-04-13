CREATE OR REPLACE TRIGGER remove_car_model
AFTER DELETE ON car_model
FOR EACH ROW
BEGIN
  DELETE FROM inventory WHERE mid = :old.mid;
END;

/

CREATE OR REPLACE TRIGGER remove_favorites
AFTER DELETE ON customer
FOR EACH ROW
BEGIN
    DELETE FROM favorites WHERE cid = :OLD.cid;
END;

/


CREATE OR REPLACE TRIGGER trg_hide_inventory
AFTER UPDATE ON inventory
FOR EACH ROW
BEGIN
    IF :OLD.IS_HIDDEN = '0' AND :NEW.IS_HIDDEN = '1' THEN
        DELETE FROM favorites WHERE VIN = :NEW.VIN;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER NOTIFY_NEW_INVENTORY
AFTER INSERT ON inventory
FOR EACH ROW
DECLARE
    v_msg VARCHAR2(200);
BEGIN
    v_msg := 'A new inventory item (VIN: ' || :NEW.VIN || ') has been added to the system.';
    dbms_output.put_line(v_msg);
END;
/
commit;


