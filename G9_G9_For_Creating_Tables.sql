
--CLEANUP SCRIPT
set serveroutput on
declare
    v_table_exists varchar(1) := 'Y';
    v_sql varchar(2000);
begin
   dbms_output.put_line('Start schema cleanup');
   for i in (select 'EMP' table_name from dual union all
             select 'DEPT' table_name from dual
   )
   loop
   dbms_output.put_line('....Drop table '||i.table_name);
   begin
       select 'Y' into v_table_exists
       from USER_TABLES
       where TABLE_NAME=i.table_name;

       v_sql := 'drop table '||i.table_name;
       execute immediate v_sql;
       dbms_output.put_line('........Table '||i.table_name||' dropped successfully');
       
   exception
       when no_data_found then
           dbms_output.put_line('........Table already dropped');
   end;
   end loop;
   dbms_output.put_line('Schema cleanup successfully completed');
exception
   when others then
      dbms_output.put_line('Failed to execute code:'||sqlerrm);
end;
/

--CREATE TABLES AS PER DATA MODEL
create table customer (
    cid number(12) constraint customer_pk primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    address varchar(255),
    area_code number(3),
    phone_number number(18),
    year_joined date
)
/
create table dealer (
    did number(8) constraint dealer_pk primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    address varchar(255),
    area_code number(3),
    phone_number number(18),
    year_joined date
)
/
create table emp (
  empno number(4),
  ename varchar2(10),
  job varchar2(9),
  mgr number(4,0),
  hiredate date,
  sal number(7,2),
  comm number(7,2),
  deptno number(4)
)
/
insert into DEPT (DEPTNO, DNAME, LOC)
  select 10, 'ACCOUNTING', 'NEW YORK' from dual union all
  select 20, 'RESEARCH',   'DALLAS'   from dual union all
  select 30, 'SALES',      'CHICAGO'  from dual union all
  select 40, 'OPERATIONS', 'BOSTON'   from dual;
  
insert into emp (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
  select 7839, 'KING',   'PRESIDENT', null, to_date('17-11-1981','dd-mm-yyyy'),    5000, null, 10 from dual union all
  select 7698, 'BLAKE',  'MANAGER',   7839, to_date('1-5-1981','dd-mm-yyyy'),      2850, null, 30 from dual union all
  select 7782, 'CLARK',  'MANAGER',   7839, to_date('9-6-1981','dd-mm-yyyy'),      2450, null, 10 from dual union all
  select 7566, 'JONES',  'MANAGER',   7839, to_date('2-4-1981','dd-mm-yyyy'),      2975, null, 20 from dual union all
  select 7788, 'SCOTT',  'ANALYST',   7566, to_date('13-JUL-87','dd-mm-rr') - 85,  3000, null, 20 from dual union all
  select 7902, 'FORD',   'ANALYST',   7566, to_date('3-12-1981','dd-mm-yyyy'),     3000, null, 20 from dual union all
  select 7369, 'SMITH',  'CLERK',     7902, to_date('17-12-1980','dd-mm-yyyy'),     800, null, 20 from dual union all
  select 7499, 'ALLEN',  'SALESMAN',  7698, to_date('20-2-1981','dd-mm-yyyy'),     1600,  300, 30 from dual union all
  select 7521, 'WARD',   'SALESMAN',  7698, to_date('22-2-1981','dd-mm-yyyy'),     1250,  500, 30 from dual union all
  select 7654, 'MARTIN', 'SALESMAN',  7698, to_date('28-9-1981','dd-mm-yyyy'),     1250, 1400, 30 from dual union all
  select 7844, 'TURNER', 'SALESMAN',  7698, to_date('8-9-1981','dd-mm-yyyy'),      1500,    0, 30 from dual union all
  select 7876, 'ADAMS',  'CLERK',     7788, to_date('13-JUL-87', 'dd-mm-rr') - 51, 1100, null, 20 from dual union all
  select 7900, 'JAMES',  'CLERK',     7698, to_date('3-12-1981','dd-mm-yyyy'),      950, null, 30 from dual union all
  select 7934, 'MILLER', 'CLERK',     7782, to_date('23-1-1982','dd-mm-yyyy'),     1300, null, 10 from dual;

commit;