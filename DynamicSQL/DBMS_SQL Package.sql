set serveroutput on;


declare
    v_table_name varchar2(30);
    v_cursur_id pls_integer;
    v_affected_row pls_integer;
    


begin
    v_table_name := 'employees_copy' ;
    v_cursur_id := dbms_sql.open_cursor();
    
    dbms_sql.parse (v_cursur_id, 'update ' || v_table_name || ' set salary = salary + :inc where job_id = :jid', dbms_sql.native);
    
    dbms_sql.bind_variable(v_cursur_id, ':inc', 500);
    
    dbms_sql.bind_variable(v_cursur_id, ':jid', 'IT_PROG');
    
    v_affected_row := dbms_sql.execute(v_cursur_id);
    
    dbms_output.put_line (v_affected_row || ' is updated..!');
    
    dbms_sql.close_cursor(v_cursur_id);


end;



select * from employees_copy;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
    > user_tab_colums view has all the columns of the table that the user has
    
    > Method 4 is a way of executing fully dynamic SQL using the DBMS_SQL package, where even the structure of the query (number of columns, datatypes, etc.) is NOT known at compile time.
    
    > Method 4 refers to dynamic SQL using DBMS_SQL, which allows parsing, binding, defining columns, executing, and fetching results when the SQL statement and its structure are completely 
    dynamic and unknown beforehand.
    
    > Method 4 is the most advanced form of dynamic SQL in Oracle using the DBMS_SQL package, where both the SQL statement and its structure (columns and datatypes) are determined at 
    runtime, requiring explicit parsing, binding, column definition, execution, and row fetching.











*/


select * from user_tab_columns where table_name = 'LOCATIONS';



















