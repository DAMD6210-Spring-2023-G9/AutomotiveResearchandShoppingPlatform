create or replace package body pkg_favorites_mgmt as
    procedure add_favorite (pi_cid number, pi_vin varchar)
        is
            ex_null_arg exception;
        begin
            if pi_cid is null or pi_vin is null then
                raise ex_null_arg;
            end if;
            insert into favorites (
                faid,
                cid,
                vin,
                date_added
            ) values (
                favorites_id.nextval,
                pi_cid,
                pi_vin,
                sysdate);
            dbms_output.put_line('Added to favorite!');

            commit;
    exception
            when ex_null_arg then
                dbms_output.put_line('CID or VIN is null. Review not created.');
            when others then
                dbms_output.put_line(SQLERRM);
    
    end add_favorite;
    
    

    
    
    procedure delete_favorite (pi_faid number)
        is 
            ex_null_arg exception;
        begin
            if pi_faid is null then
                raise ex_null_arg;
            end if;
            delete from favorites where faid=pi_faid;
            commit;
    exception
            when ex_null_arg then
                dbms_output.put_line('ID required.');
            when others then
                dbms_output.put_line(SQLERRM);
    
    end delete_favorite;


end pkg_favorites_mgmt;