SET SERVEROUTPUT ON;

/******************************************** Not Recommended *********************************************/
declare

    type rt_emp is record (v_first_name employees.first_name%type, v_last_name employees.last_name%type);
    r_emp rt_emp;
    cursor c_emp is select first_name, last_name from employees;

    
begin
    open c_emp;
    
    fetch c_emp into r_emp;
    dbms_output.put_line(r_emp.v_first_name|| ' ' || r_emp.v_last_name);
    
    close c_emp;
end;

/******************************************** Not Recommended *********************************************/

declare

    r_emp employees%rowtype;
    cursor c_emp is select first_name, last_name from employees;

    
begin
    open c_emp;
    
    fetch c_emp into r_emp.first_name, r_emp.last_name;
    dbms_output.put_line(r_emp.first_name|| ' ' || r_emp.last_name);
    
    close c_emp;
end;


/******************************************** Recommended, Most Efficient *********************************************/

-- Create record using cursor%rowtype

declare 

    cursor c_emp is select first_name,last_name from employees;
    v_emp c_emp%rowtype;
    
begin
    open c_emp;
    
    fetch c_emp into v_emp;
    dbms_output.put_line(v_emp.first_name|| ' ' || v_emp.last_name);
    
    close c_emp;

end;











