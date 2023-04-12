
create or replace package body pkg_customer_mgmt as
    function upsert_customer (pi_first_name varchar, pi_last_name varchar, pi_email varchar, pi_address varchar, pi_area_code varchar, pi_phone_number varchar) return number
    is
    v_customer_id number;
    ex_invalid_email exception;
    ex_invalid_name exception;
    BEGIN
        if pi_email is NULL or instr(pi_email,'@') <1 then
            raise ex_invalid_email;
        end if;

        if pi_first_name is null or pi_last_name is null then
            raise ex_invalid_name;
        end if;
        
        merge into customer tgt
            using ( 
                select  pi_email email, 
                        pi_first_name fname, 
                        pi_last_name lname, 
                        pi_address address, 
                        pi_area_code area_code, 
                        pi_phone_number phone_number
                    from dual
            ) src
            on (tgt.email = src.email)
        when matched then update set    
                                        tgt.first_name=src.fname, 
                                        tgt.last_name=src.lname, 
                                        tgt.address = src.address,  
                                        tgt.area_code = src.area_code,  
                                        tgt.phone_number = src.phone_number
        when not matched then insert (
            cid,
            first_name,
            last_name,
            email,
            address,
            area_code,
            phone_number,
            year_joined
        ) values (
            customer_id.nextval,
            src.fname,
            src.lname,
            src.email,
            src.address,
            src.area_code,
            src.phone_number,
            sysdate);
        select cid into v_customer_id from customer where email=pi_email;
        commit;
        dbms_output.put_line('User upserted successful!');
        RETURN v_customer_id;
    EXCEPTION
        when ex_invalid_email then
            dbms_output.put_line('Email is null. Error!');
        when ex_invalid_name then
            dbms_output.put_line('Name is not legal. Error!');
    END upsert_customer;
    
    
    
    function get_customer_registration (pi_email varchar) return number
    is
        v_cid number;
        ex_invalid_email exception;
    begin
        if pi_email is NULL or instr(pi_email,'@') <1 then
            raise ex_invalid_email;
        end if;
        select cid into v_cid from customer where email=pi_email;
        return v_cid;
        
    EXCEPTION
       when ex_invalid_email then
            dbms_output.put_line('Email is null. Error!');
    
    end get_customer_registration;
    
    
    
    function get_customer_registration (pi_area_code varchar, pi_phone_number varchar)return number
    is
        v_cid number;
        v_phone_number varchar(10);
        ex_invalid_phone_number exception;
    begin
        if pi_area_code is null or pi_phone_number is null then
            raise ex_invalid_phone_number;
        end if;
        v_phone_number:= concat(pi_area_code, pi_phone_number);
        if length(v_phone_number) != 9 then
             raise ex_invalid_phone_number;
        end if;
        
        select cid into v_cid from customer where pi_area_code = area_code and pi_phone_number = phone_number;
        return v_cid;
        
    EXCEPTION
        when ex_invalid_phone_number then
            dbms_output.put_line('Phone number length: '||v_phone_number|| ' '|| length(v_phone_number));
            dbms_output.put_line('Phone number is not right. Error!');
        when others then
            dbms_output.put_line('Phone number is right. Other error!');
        
    end get_customer_registration;
    
    
    
end pkg_customer_mgmt;
/

