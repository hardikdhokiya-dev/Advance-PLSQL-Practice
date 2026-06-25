set serveroutput on;

/******************************************** raise_application_error procedure inside the begin-end block *********************************************/

declare

    too_high_salary exception;
    v_sal pls_integer;
    
begin
    
    select salary into v_sal from employees where employee_id = 100;
    
    if v_sal > 20000 then
        raise_application_error(-20211, 'The salary of the selected employee is too high!');
    end if;

-- if the salary is under 2000 then print the below line
   
    dbms_output.put_line('This is valid number');

-- without exception handles it gives "ORA-06510: PL/SQL: unhandled user-defined exception" error

exception 
    when too_high_salary then
    dbms_output.put_line('This salary is too high. You need to decrease it.');

end;


/******************************************** raise_application_error procedure inside the exception block *********************************************/

declare

    too_high_salary exception;
    v_sal pls_integer;
    
begin
    
    select salary into v_sal from employees where employee_id = 100;
    
    if v_sal > 20000 then
        raise too_high_salary;
    end if;

-- if the salary is under 2000 then print the below line
   
    dbms_output.put_line('This is valid number');

-- without exception handler it gives "ORA-06510: PL/SQL: unhandled user-defined exception" error

exception 
    when too_high_salary then
    dbms_output.put_line('This salary is too high. You need to decrease it.');
    raise_application_error(-20211, 'The salary of the selected employee is too high!', true);

end;

















