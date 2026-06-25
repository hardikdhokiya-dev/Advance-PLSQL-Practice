SET SERVEROUTPUT ON;

declare
    cursor c_emp is select first_name, last_name from employees;
    v_first_name employees.first_name%type;
    v_last_name employees.last_name%type;
    
begin
    open c_emp;
    
    fetch c_emp into v_first_name, v_last_name;
    dbms_output.put_line(v_first_name|| ' ' || v_last_name);
    
    fetch c_emp into v_first_name, v_last_name;
    dbms_output.put_line(v_first_name|| ' ' || v_last_name);
    
    close c_emp;
end;

----------------------------------------------------------------------------------------------------------------------------------
declare
    cursor c_emp is select first_name, last_name from employees;
    v_first_name employees.first_name%type;
    v_last_name employees.last_name%type;
    
begin
    open c_emp;
    
    fetch c_emp into v_first_name, v_last_name;
    fetch c_emp into v_first_name, v_last_name;
    fetch c_emp into v_first_name, v_last_name;
    dbms_output.put_line(v_first_name|| ' ' || v_last_name);
    
    fetch c_emp into v_first_name, v_last_name;
    dbms_output.put_line(v_first_name|| ' ' || v_last_name);
    
    close c_emp;
end;

----------------------------------------------------------------------------------------------------------------------------------
/****************** Cursor with join example (any valid query works) *********************************************/


declare
    --cursor c_emp is select e.first_name, e.last_name, d.department_name from employees e JOIN departments d ON e.department_id = d.department_id WHERE e.department_id BETWEEN 30 AND 60;
    cursor c_emp is select first_name, last_name, department_name from employees join departments using (department_id) where department_id between 30 and 60;
    v_first_name employees.first_name%type;
    v_last_name employees.last_name%type;
    v_dept_name departments.department_name%type;
    
begin
    open c_emp;
    
    fetch c_emp into v_first_name, v_last_name, v_dept_name;

    dbms_output.put_line(v_first_name|| ' ' || v_last_name|| ' in the department of '|| v_dept_name);
    
    close c_emp;
end;





















