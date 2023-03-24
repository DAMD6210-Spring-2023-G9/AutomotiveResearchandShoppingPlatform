show user;
set serveroutput on;

declare
    v_user_exists varchar(1) := 'Y';
    v_sql varchar(2000);
begin
   dbms_output.put_line('Start schema cleanup');
   for i in (select 'ZONGYAO' user_name from dual union all
             select 'FANGYU' user_name from dual union all
             select 'MING' user_name from dual union all
             select 'G9' user_name from dual
   )
   loop
   dbms_output.put_line('....Drop user '||i.user_name);
   begin
        v_sql := 'drop user '|| i.user_name ||' cascade';
       dbms_output.put_line(v_sql);
       execute immediate v_sql;
       
       dbms_output.put_line('........User '||i.user_name||' dropped successfully');
       
   exception
       when others then
           dbms_output.put_line('........User already dropped: ' || sqlerrm);
   end;
   end loop;
   dbms_output.put_line('Schema cleanup successfully completed');
exception
   when others then
      dbms_output.put_line('Failed to execute code:'||sqlerrm);
end;
/

create user zongyao identified by G9IsTheBestTeam;
create user fangyu identified by G9IsTheBestTeam;
create user ming identified by G9IsTheBestTeam;

-- G9 is used to create tables.
create user G9 identified by Team9IsTheBestTeam;


grant connect to fangyu, ming, G9, zongyao;
alter user zongyao quota unlimited on data;
alter user fangyu quota unlimited on data;
alter user ming quota unlimited on data;
alter user G9 quota unlimited on data;

-- give access to developers
grant resource to zongyao, fangyu, ming, G9;

