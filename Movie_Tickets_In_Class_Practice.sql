/*
-- Modules
(A) pkg_customer_ mgmt 
        upsert customer
            email
        first_name
        last_name
    inactivate_customer
        email
    is_customer_active
        email
    get_customer_registration
        email
    get_customer_registration
        first_name
        last_name
        
-- B pkg_movies_mgmt
        add_movies
            movie_name
            movie_lang
            movie_length
            release_date
        inactive_movies
            movie_name
        active_movies
            movie_name
        update_movies
            movie_name
            movie_title
            movie_length
            movie_lang
        link_movies_to_screen
            movie_id
            screen_id
            show_date
        
-- C pkg_tickets_mgmt
        book_ticket
            screen_name
            num_of_tickets
            customer_id
        cancel_tickets
            ticket_id
        get_available_seats
            screen_name

-- D pkg_seat_mgmt

*/
set serveroutput on;
exec pkg_customer_mgmt.upsert_customer(null, null, null);

create or replace package pkg_customer_mgmt
as
procedure upsert_customer (pi_email varchar, pi_first_name varchar, pi_last_name varchar);
procedure inactivate_customer (pi_email varchar);
function is_customer_active (pi_email varchar) return varchar;
function get_customer_registration (pi_email varchar) return number;
function get_customer_registration (pi_first_name varchar, pi_last_name varchar)return number;
end pkg_customer_mgmt;
/




create or replace package body pkg_customer_mgmt
as
procedure upsert_customer (pi_email varchar, pi_first_name varchar, pi_last_name varchar)
is
ex_invalid_email exception;
ex_invalid_name exception;
begin

if pi_email is NULL or instr(pi_email,'@') <1 then
    raise ex_invalid_email;
end if;

if pi_first_name is null or pi_last_name is null then
    raise ex_invalid_name;
end if;

merge into customers
    using (
        select pi_email as email, pi_first_name fname, pi_last_name lname, 'Y' is_active from dual
    )   src
        on (tgt.email = src.email)
        when matched then update set tgt.is_active='Y', tgt.first_name=src.fname, tgt.last_name=src.lname, tgt.modified_by = user, tgt.modified_dt=sysdate
        when not matched then insert (
            id,
            email,
            first_name,
            last_name,
            is_active,
            created_by,
            created_dt
        ) values (
            customer_id_sequence.nextval,
            src.email,
            src.fname,
            src.lname,
            user,
            sysdate);
    commit;
    dbms_output.put_line('User upserted successful!');
exception
    when ex_invalid_email then
        dbms_output.put_line('Email is null. Error!');
    when ex_invalid_name then
        dbms_output.put_line('Name is not legal. Error!');

end upsert_customer;


procedure inactivate_customer (pi_email varchar)
is
    ex_invalid_email exception;
begin
    update customers set is_active = 'N',
        modified_by=user, 
        modified_dt=sysdate
        where email=pi_email;
    
    if sql%rowcount<=0 then
        raise ex_invalid_email;
    end if;
    
    commit;
exception
    when ex_invalid_email then
        dbms_output.put_line('Email is null. Error!');
    
end inactivate_customer;


function is_customer_active (pi_email varchar) return varchar
is
begin
null;
end is_customer_active;


function get_customer_registration (pi_email varchar) return number
is
    v_cust_reg_id number;

begin
    select id into v_cust_reg_id
        from customers
        where email=pi_email;
    return v_cust_reg_id;
    exception
        when no_data_found then
            dbms_output.putline('No data found');
            return -1;

end get_customer_registration;


function get_customer_registration (pi_first_name varchar, pi_last_name varchar)return number
is
begin
null;
end get_customer_registration;

end pkg_customer_mgmt;
/





