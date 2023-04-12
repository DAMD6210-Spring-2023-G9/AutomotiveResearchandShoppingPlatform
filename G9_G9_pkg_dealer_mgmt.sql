create or replace package body pkg_dealer_mgmt as
    function upsert_dealer (pi_dealer_name varchar, pi_email varchar, pi_address varchar, pi_area_code varchar, pi_phone_number varchar, pi_website varchar) return number
    is
        v_dealer_id number;
        ex_invalid_email exception;
        ex_invalid_name exception;
    BEGIN
        if pi_email is NULL or instr(pi_email,'@') <1 then
            raise ex_invalid_email;
        end if;

        if pi_dealer_name is null then
            raise ex_invalid_name;
        end if;
        
        merge into dealer tgt
            using ( 
                select  pi_email email, 
                        pi_dealer_name dname, 
                        pi_address address, 
                        pi_area_code area_code, 
                        pi_phone_number phone_number,
                        pi_website website
                    from dual
            ) src
            on (tgt.email = src.email)
        when matched then update set    
                                        tgt.dealer_name=src.dname, 
                                        tgt.address = src.address,  
                                        tgt.area_code = src.area_code,  
                                        tgt.phone_number = src.phone_number,
                                        tgt.website = src.website
        when not matched then insert (
            did,
            dealer_name,
            email,
            address,
            area_code,
            phone_number,
            year_joined,
            website
        ) values (
            dealer_id.nextval,
            src.dname,
            src.email,
            src.address,
            src.area_code,
            src.phone_number,
            sysdate,
            src.website);
        select did into v_dealer_id from dealer where email=pi_email;
        commit;
        dbms_output.put_line('Dealer upserted successful!');
        RETURN v_dealer_id;
    EXCEPTION
        when ex_invalid_email then
            dbms_output.put_line('Email is null. Error!');
        when ex_invalid_name then
            dbms_output.put_line('Name is not legal. Error!');
    end upsert_dealer;
    
    
    
    function get_dealer_registration (pi_input varchar) return number
    is
        v_did number;
        ex_invalid_input exception;
    begin
        if pi_input is NULL then
            raise ex_invalid_input;
        end if;
        select did into v_did from dealer where email=pi_input or dealer_name = pi_input;
        return v_did;
        
    EXCEPTION
       when ex_invalid_input then
            dbms_output.put_line('Input is null. Nothing to find!');
    end get_dealer_registration;
    
    
    
--    
--    function get_dealer_registration (pi_dealer_name varchar) return number
--    is
--        v_did number;
--        ex_invalid_name exception;
--    begin
--        if pi_dealer_name is null then
--            raise ex_invalid_name;
--        end if;
--        select did into v_did from dealer where dealer_name=pi_dealer_name;
--        return v_did;
--        
--    exception
--        when ex_invalid_name then
--            dbms_output.put_line('Name is not legal. Error!');
--        when others then
--            dbms_output.put_line('Something went wrong. Abort');
--    end get_dealer_registration;
--    
    
end pkg_dealer_mgmt;
/





