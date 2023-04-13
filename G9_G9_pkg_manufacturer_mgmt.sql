CREATE OR REPLACE
package body pkg_manufacturer_mgmt as
    function upsert_manufacturer (pi_manufacturer varchar, pi_country varchar, pi_descript varchar, pi_year_founded varchar) return number
    is
        ex_null_argument exception;
        v_fid number;
    begin
        if pi_manufacturer is null then
            raise ex_null_argument;
        end if;

        merge into manufacturer tgt
        using (select pi_manufacturer make, pi_country country, pi_descript descp, pi_year_founded y from dual)
            src on (tgt.make_name=src.make)
        when matched then update set 
            tgt.country = src.country,
            tgt.descript = src.descp,
            tgt.year_founded= src.y
        when not matched then insert (
            fid,
            make_name,
            country,
            descript,
            year_founded
        ) values (
            manufacturer_id.nextval,
            pi_manufacturer,
            pi_country,
            pi_descript,
            pi_year_founded);
            commit;
        dbms_output.put_line('Manufacturer upserted successful!');
        select fid into v_fid from manufacturer where make_name=pi_manufacturer;
        return v_fid;
    exception
        when ex_null_argument then
            dbms_output.put_line('Manufacturer cannot be null. Abort.');

        when others then
            dbms_output.put_line(SQLERRM);
    end upsert_manufacturer;
end pkg_manufacturer_mgmt;