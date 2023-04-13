create or replace package body pkg_inventory_mgmt as
    procedure upsert_inventory (pi_dealer_id number, pi_vin varchar, pi_mid number, pi_ftid number, pi_interior_color varchar, pi_exterior_color varchar, pi_title varchar, pi_miles varchar, pi_is_hidden varchar)
        is
            ex_null_arg exception;
        begin
            if pi_dealer_id is null or pi_vin is null then
                raise ex_null_arg;
            end if;
            merge into inventory tgt using (select 
                pi_dealer_id pi_dealer_id, 
                pi_vin vin, 
                pi_mid mid, 
                pi_ftid ft_id,
                pi_interior_color interior, 
                pi_exterior_color exterior, 
                pi_title title, 
                pi_miles miles, 
                pi_is_hidden is_hidden from dual) src on ( tgt.vin=src.vin)
            when matched then update set 
                tgt.did = src.pi_dealer_id,
                tgt.mid = mid,
                tgt.ftid = ft_id,
                tgt.interior_color=src.interior,
                tgt.exterior_color = src.exterior,
                tgt.title=src.title,
                tgt.is_hidden=src.is_hidden
            when not matched then insert (
                did,
                vin,
                mid,
                ftid,
                interior_color,
                exterior_color,
                title,
                miles,
                is_hidden)
            values (
                pi_vin,
                pi_dealer_id,
                pi_mid,
                pi_ftid,
                pi_interior_color,
                pi_exterior_color,
                pi_title,
                pi_miles,
                pi_is_hidden);
            commit;
        exception
            when ex_null_arg then
                dbms_output.put_line('pi_dealer_id');
            when others then
                dbms_output.put_line(SQLERRM);
    end upsert_inventory;
    
        
    
    procedure delete_inventory (pi_vin varchar)
        is
            ex_null_arg exception;
        begin
            if pi_vin is null then
                raise ex_null_arg;
            end if;
            delete from inventory where vin=pi_vin;
    exception
            when ex_null_arg then
                dbms_output.put_line('pi_dealer_id');
            when others then
                dbms_output.put_line(SQLERRM);
    commit;
    end delete_inventory;
end pkg_inventory_mgmt;
/


