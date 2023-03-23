show user;

alter user zongyao identified by G9IsTheBestTeam;

create user fangyu identified by G9IsTheBestTeam;
create user ming identified by G9IsTheBestTeam;

-- G9 is used to create tables.
create user G9 identified by Team9IsTheBestTeam;
create user user_operator identified by G9Bot; -- failed, change password


grant connect to fangyu, ming, G9;
alter user zongyao quota unlimited on data;
alter user fangyu quota unlimited on data;
alter user ming quota unlimited on data;
alter user G9 quota unlimited on data;

-- show current user.
SELECT
    user "USER"
FROM
    "SYS"."DUAL" "A1";

-- give access to developers
grant resource to zongyao, fangyu, ming, G9;


