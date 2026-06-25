set serveroutput on;

/******************************************** User-defined exceptions handling *********************************************/

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

-- without exception handles it gives "ORA-06510: PL/SQL: unhandled user-defined exception" error

exception 
    when too_high_salary then
    dbms_output.put_line('This salary is too high. You need to decrease it.');

end;


/******************************************** Raising a Predefined Exception ********************************************/

declare

    too_high_salary exception;
    v_sal pls_integer;
    
begin
    
    select salary into v_sal from employees where employee_id = 100;
    
    if v_sal > 20000 then
        raise invalid_number;
    end if;

-- if the salary is under 2000 then print the below line
   
    dbms_output.put_line('This is valid number');

-- without exception handles it gives "ORA-06510: PL/SQL: unhandled user-defined exception" error

exception 
    when invalid_number then
    dbms_output.put_line('This salary is too high. You need to decrease it.');

end;

/******************************************** Raising Inside of the Exception ********************************************/

declare

    too_high_salary exception;
    v_sal pls_integer;
    
begin
    
    select salary into v_sal from employees where employee_id = 100;
    
    if v_sal > 20000 then
        raise invalid_number;
    end if;

-- if the salary is under 2000 then print the below line
   
    dbms_output.put_line('This is valid number');

-- without exception handles it gives "ORA-06510: PL/SQL: unhandled user-defined exception" error

exception 
    when invalid_number then
    dbms_output.put_line('This salary is too high. You need to decrease it.');
    raise;
--  if we write raise keyword again,it will raise the same excpetion again
end;
















