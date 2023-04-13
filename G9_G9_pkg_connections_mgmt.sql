create or replace package body pkg_connections_mgmt as
    procedure create_connection (pi_cid number, pi_did number, pi_content varchar)
        is
            ex_null_arg exception;
        begin
            if pi_cid is null or pi_did is null then
                raise ex_null_arg;
            end if;
            insert into connections (
                cid,
                did,
                date_connected,
                content
            ) values (
                pi_cid,
                pi_did,
                sysdate,
                pi_content);
                dbms_output.put_line('Conversation created.');

            commit;
    exception
            when ex_null_arg then
                dbms_output.put_line('CID or DID is null. Conversation not created.');
            when others then
                dbms_output.put_line(SQLERRM);
    
    end create_connection;
end pkg_connections_mgmt;