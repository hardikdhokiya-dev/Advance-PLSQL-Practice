set serveroutput on;

/**************************************************** EXECUTE IMMIDIATE USING CLAUSE **********************************************/




create table login_user_data (login_id number, first_name varchar2(20));


create or replace function insert_values (login_id in number, first_name in varchar2) return pls_integer is 

    begin
            execute immediate 'insert into login_user_data values (:a, :b)' 
            USING login_id, first_name; -- By default using clause will have the IN parameter
            
            return sql%rowcount;
    
    end insert_values;
    
    
declare
    v_row pls_integer;
    
begin

    v_row := insert_values (1, 'MARK');
    dbms_output.put_line (v_row || ' is inserted!');

end;

select * from login_user_data;

/**************************************************** Get a column value using the RETRUNING INTO clause ****************************************************/
/*
OUT mode is not used in the USING clause of EXECUTE IMMEDIATE. USING supports only IN and IN OUT binds. OUT values from dynamic SQL are handled exclusively through the RETURNING INTO clause, 
which captures values from DML operations after execution
*/

ALTER TABLE login_user_data ADD (last_name varchar2(20));


create or replace function f_update_table (login_id in number, first_name out varchar2, last_name in varchar2) return pls_integer is 
    
        v_dynamic_sql varchar2(500);
        
    begin
        
            v_dynamic_sql := 'update login_user_data set last_name = :a where login_id = :b returning first_name into :c';
            
            execute immediate v_dynamic_sql using in last_name, login_id returning into first_name;

            -- if we use returning into clasue,  all other bind variables must be IN mode
            --USING → binds BEFORE execution ; RETURNING → captures AFTER execution
        
        return sql%rowcount;
        
    end f_update_table;


    
declare
    v_row pls_integer;
    v_first_name varchar2(20);
    
begin

    v_row := f_update_table (1, v_first_name, 'WOOD' );
    dbms_output.put_line (v_row || ' is UPDATED!');
    dbms_output.put_line (v_first_name);
end;


/**************************************************** EXECUTE IMMIDIATE USING CLAUSE AND INTO CLAUSES **********************************************/


create or replace function get_count (v_table_name in varchar2) return pls_integer is
    
    v_row_count pls_integer;
    
    begin
    
        execute immediate 'select count(*) from ' ||v_table_name  into v_row_count; 
    
        return v_row_count;

    end get_count;
    

declare 
    v_row pls_integer;
    

begin
    
    for r_table in (Select table_name from user_tables) loop
    v_row := get_count(r_table.table_name);
    dbms_output.put_line('No of rows is : '||v_row || ' in the '||r_table.table_name);
    end loop;
end;    


-- We can not use the bind arguments for the schema objects like table_name etc..

CREATE TABLE stock_managers AS SELECT * FROM employees WHERE job_id = 'ST_MAN';
select * from stock_managers;

CREATE TABLE stock_clerks AS SELECT * FROM employees WHERE job_id = 'ST_CLERK';

-- we will receive an error for executing below code as p_table can not be used as bind arguments

CREATE OR REPLACE FUNCTION get_avg_sals (p_table IN VARCHAR2, p_dept_id IN NUMBER) RETURN PLS_INTEGER IS
    v_average PLS_INTEGER;
BEGIN
    EXECUTE IMMEDIATE 'SELECT AVG(salary) FROM :1 WHERE department_id = :2' INTO v_average USING p_table, p_dept_id;
    RETURN v_average;
END;


SELECT get_avg_sals('stock_clerks','50') FROM dual;

------------------------ Correct way --------------------------------------------------------------

CREATE OR REPLACE FUNCTION get_avg_sals (p_table IN VARCHAR2, p_dept_id IN NUMBER) RETURN PLS_INTEGER IS
    v_average PLS_INTEGER;
BEGIN
    EXECUTE IMMEDIATE 'SELECT AVG(salary) FROM '||p_table||' WHERE department_id = :2' INTO v_average USING p_dept_id;
    RETURN v_average;
END;



SELECT get_avg_sals('stock_managers','50') FROM dual;
    
    
    