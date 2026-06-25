SET SERVEROUTPUT ON;


/**************************************************** EXECUTE IMMIDIATE USAGE **********************************************/

-- PLSQL block must be end with ;
BEGIN

  execute immediate 'grant create access to hr';
    
END;


/**************************************************** Handles the DDL commands **********************************************/


-- create table procedure

create or replace procedure prc_create_table (v_table_name in varchar2, v_columns_name in varchar2) is

begin

    execute immediate 'Create table ' ||v_table_name|| ' ('||v_columns_name||' )';

end;

exec prc_create_table('login', 'ID number primary key, Email varchar2(20)');

select * from login;


-- generic sql running procedure

create or replace procedure prc_gen (v_sql_str in varchar2) is

begin

    execute immediate v_sql_str;

end;


exec prc_gen('DROP TABLE LOGIN');
exec prc_gen('DROP PROCEDURE prc_create_table');

DROP PROCEDURE prc_gen










