create or replace package body pkg_features_mgmt as
    procedure insert_features (pi_mid number, pi_cylinders number, pi_mpg varchar, pi_fuel varchar, pi_drive_type varchar, pi_transmission varchar, SUNROOF char, MOONROOF char, HEATED_SEATS char,MULTIMEDIA char, CRUISE_CONTROL char)
    is
        ex_null_arg exception;
        
    begin
        if pi_mid is null then
            raise ex_null_arg;
        end if;
        insert into features (
            ftid,
            mid,
            cylinders,
            mpg,
            fuel,
            drive_type,
            transmission,
            sunroof,
            moonroof,
            heated_seats,
            multimedia,
            cruise_control)
        values (
            features_id.nextval,
            pi_mid,
            pi_cylinders ,
            pi_mpg ,
            pi_fuel ,
            pi_drive_type ,
            pi_transmission ,
            SUNROOF ,
            MOONROOF ,
            HEATED_SEATS ,
            MULTIMEDIA ,
            CRUISE_CONTROL);
    dbms_output.put_line('Successfully inserted.');

    exception
        when ex_null_arg then
            dbms_output.put_line('Mid cannot be null. Abort.');
        when others then
            dbms_output.put_line(SQLERRM);
    
    end insert_features;
    
    
    
    
    procedure update_features (pi_ftid number, pi_mid number, pi_cylinders number, pi_mpg varchar, pi_fuel varchar, pi_drive_type varchar, pi_transmission varchar, pi_SUNROOF char, pi_MOONROOF char, pi_HEATED_SEATS char,pi_MULTIMEDIA char, pi_CRUISE_CONTROL char)
    is
        ex_null_arg exception;
        
    begin
        if pi_mid is null or pi_ftid is null then
            raise ex_null_arg;
        end if;
        update features set
            mid=pi_mid,
            cylinders=pi_cylinders,
            mpg=pi_mpg,
            fuel=pi_fuel,
            drive_type=pi_drive_type,
            transmission=pi_transmission,
            sunroof=pi_SUNROOF ,
            moonroof=pi_MOONROOF,
            heated_seats=pi_HEATED_SEATS,
            multimedia=pi_MULTIMEDIA ,
            cruise_control=pi_CRUISE_CONTROL
        where ftid=pi_ftid;
    dbms_output.put_line('Successfully updated.');

    exception
        when ex_null_arg then
            dbms_output.put_line('Ftid and Mid cannot be null. Abort.');
        when others then
            dbms_output.put_line(SQLERRM);
    end update_features;
end pkg_features_mgmt;