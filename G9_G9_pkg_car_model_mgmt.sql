create or replace package body pkg_car_model_mgmt as
    function upsert_model (pi_manufacturer varchar, pi_model_name varchar, pi_model_trim varchar, pi_body_style varchar, pi_weight number, pi_year_introduced varchar) return number
    is
        ex_arg_null exception;
        ex_manufacturer_not_exist exception;
        v_fid number;
        v_mid number;
        v_year_introduced date;
--        v_make_name varchar(100);
    begin
        if pi_manufacturer is null or pi_model_name is null or pi_year_introduced is null then
            raise ex_arg_null;
        end if;
        v_year_introduced:= to_date(pi_year_introduced, 'yyyy-mm-dd');
        select fid into v_fid from manufacturer where make_name=pi_manufacturer;
        if v_fid is null then 
            raise ex_manufacturer_not_exist;
        end if;
--        dbms_output.put_line('v_fid is '||v_fid);
        dbms_output.put_line('v_year_introduced is '||v_year_introduced);
        merge into car_model tgt using 
            (select v_fid fid, pi_model_name mn, pi_model_trim mt, pi_body_style bs, pi_weight wt, v_year_introduced y from dual) 
            src 
            on (tgt.fid=src.fid and tgt.model_name=src.mn and tgt.model_trim=src.mt and tgt.year_introduced=src.y)
            when matched then update set 
                tgt.body_style = src.bs,
                tgt.weight = src.wt
            when not matched then 
                insert 
                    (mid, fid, model_name, model_trim, body_style, weight, year_introduced)
                values (
                    car_model_id.nextval,
                    src.fid,
                    src.mn,
                    src.mt,
                    src.bs,
                    src.wt,
                    src.y
                );
        commit;
         dbms_output.put_line('Successfully upserted record.');
        select mid into v_mid from car_model where fid=v_fid and model_name=pi_model_name and model_trim=pi_model_trim and year_introduced=to_date(pi_year_introduced, 'yyyy-mm-dd');
        dbms_output.put_line('v_mid is '||v_mid);
        return v_mid;
    exception
        when ex_arg_null then
            dbms_output.put_line('Fundamental arguments not provided, abort. args: [' || pi_manufacturer|| '] [' || pi_model_name || '].');
        when ex_manufacturer_not_exist then
            dbms_output.put_line('Please create a manufacturer first: ['||pi_manufacturer||'].');
        when TOO_MANY_ROWS then
            dbms_output.put_line('Too many rows.');
        when others then
            dbms_output.put_line(SQLERRM);
    
    end upsert_model;
    
end pkg_car_model_mgmt;
/


