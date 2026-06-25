set serveroutput on;


/*

Variables inside q'[]' are treated as plain text, NOT PL/SQL variables.

*/ 
declare
    
    type t_emp_ref is ref cursor;
    v_emp_ref t_emp_ref;
    r_emp5 employees%rowtype;
    v_table_name varchar2(50);
    
begin
    
    v_table_name := 'empoloyees';
    
    open v_emp_ref for q'[select * from v_table_name where job_id = :job]' using 'IT_PROG'; -- error invalid table name inside q we can not use variables

    fetch v_emp_ref into r_emp5;
    
        dbms_output.put_line (r_emp5.first_name);

    close v_emp_ref;



end;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

declare
    
    type t_emp_ref is ref cursor;
    v_emp_ref t_emp_ref;
    r_emp5 employees%rowtype;
    v_table_name varchar2(50);
    
begin
    
    v_table_name := 'employees';
    
    open v_emp_ref for 'select * from ' ||v_table_name|| ' where job_id = :job' using 'IT_PROG'; -- error invalid table name inside q we can not use variables

    loop
        fetch v_emp_ref into r_emp5;
        
        exit when v_emp_ref%notfound;
    
            dbms_output.put_line (r_emp5.first_name);

    end loop;
        
        close v_emp_ref;
        
    


end;


select * from employees where job_id = 'IT_PROG';