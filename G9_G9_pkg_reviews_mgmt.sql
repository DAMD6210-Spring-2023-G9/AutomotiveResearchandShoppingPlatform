create or replace package body pkg_reviews_mgmt as
    procedure write_review (pi_cid number, pi_did number, pi_content varchar)
        is
            ex_null_arg exception;
        begin
            if pi_cid is null or pi_did is null then
                raise ex_null_arg;
            end if;
            insert into reviews (
                rid,
                cid,
                did,
                date_reviewed,
                content
            ) values (
                reviews_id.nextval,
                pi_cid,
                pi_did,
                sysdate,
                pi_content);
            dbms_output.put_line('Conversation created.');

            commit;
    exception
            when ex_null_arg then
                dbms_output.put_line('CID or DID is null. Review not created.');
            when others then
                dbms_output.put_line(SQLERRM);
    
    end write_review;
    
    

    
    
    procedure delete_review (pi_rid number)
        is 
            ex_null_arg exception;
        begin
            if pi_rid is null then
                raise ex_null_arg;
            end if;
            delete from reviews where rid=pi_rid;
            commit;
    exception
            when ex_null_arg then
                dbms_output.put_line('ID required.');
            when others then
                dbms_output.put_line(SQLERRM);
    
    end delete_review;


    procedure update_review (pi_rid number, pi_content varchar)
        is 
            ex_null_arg exception;
        begin
            if pi_rid is null then
                raise ex_null_arg;
            end if;
            update reviews set content=pi_content where rid=pi_rid;
            commit;
        exception
            when ex_null_arg then
                dbms_output.put_line('ID required.');
            when others then
                dbms_output.put_line(SQLERRM);
    end update_review;
end pkg_reviews_mgmt;