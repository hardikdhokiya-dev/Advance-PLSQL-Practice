SET SERVEROUTPUT ON;

/******************************************** no data found exception handling *********************************************/
declare 
    v_name employees.first_name%type;

begin

    select first_name into v_name from employees where employee_id = 510;
    dbms_output.put_line('First Name is ' || v_name);
    
exception 
    
    when no_data_found then 
    dbms_output.put_line('There is no employee with the selected id');

end;

/******************************************** multiple exceptions handling *********************************************/

-- no data found and too man rows


declare 
    v_name employees.first_name%type;
    v_dept_name varchar2(200);

begin

    select first_name into v_name from employees where employee_id = 100;
    select department_id into v_dept_name from employees where first_name = v_name;
    dbms_output.put_line('First Name is ' || v_name);
    dbms_output.put_line('Hello '|| v_name || '. Your department id is : '|| v_dept_name );
    
exception 
    
    when no_data_found then 
    dbms_output.put_line('There is no employee with the selected id');

    when too_many_rows then
    dbms_output.put_line('There are more than one employees with the name '|| v_name);
    dbms_output.put_line('Try with a different employee');

end;

/******************************************** using when others then *********************************************/


declare 
    v_name employees.first_name%type;
    --v_name varchar2(2);
    v_dept_name varchar2(200);

begin

    select first_name into v_name from employees where employee_id = 101;
    select department_id into v_dept_name from employees where first_name = v_name;
    dbms_output.put_line('First Name is ' || v_name);
    dbms_output.put_line('Hello '|| v_name || '. Your department id is : '|| v_dept_name );
    
exception 
    
    when no_data_found then 
    dbms_output.put_line('There is no employee with the selected id');

    when too_many_rows then
    dbms_output.put_line('There are more than one employees with the name '|| v_name);
    dbms_output.put_line('Try with a different employee');
    
    when others then
    dbms_output.put_line('An unexpected error happened. Connect with the programmer..');

end;


/******************************************** Using sqlcode and sqlerrm functions *********************************************/


declare 
    --v_name employees.first_name%type;
    v_name varchar2(2);
    v_dept_name varchar2(200);

begin

    --select first_name into v_name from employees where employee_id = 10;
    --select first_name into v_name from employees where employee_id = 100;
    select first_name into v_name from employees where employee_id = 103;
    select department_id into v_dept_name from employees where first_name = v_name;
    dbms_output.put_line('First Name is ' || v_name);
    dbms_output.put_line('Hello '|| v_name || '. Your department id is : '|| v_dept_name );
    
exception 
    
    when no_data_found then 
    dbms_output.put_line('There is no employee with the selected id');
    dbms_output.put_line('Error code is :  ' || sqlcode || ' and error discription is: ' || sqlerrm);

    when too_many_rows then
    dbms_output.put_line('There are more than one employees with the name '|| v_name);
    dbms_output.put_line('Try with a different employee');
    dbms_output.put_line('Error code is :  ' || sqlcode || ' and error discription is: ' || sqlerrm);
    
    when others then
    dbms_output.put_line('An unexpected error happened. Connect with the programmer..');
    dbms_output.put_line('An unexpected error happened. Connect with the programmer..');
    dbms_output.put_line('Error code is :  ' || sqlcode || ' and error discription is: ' || sqlerrm);
    
end;

/******************************************** Inner block and exception *********************************************/

declare 
    v_name employees.first_name%type;
    v_dept_name varchar2(200);

begin

    select first_name into v_name from employees where employee_id = 10;
    dbms_output.put_line('First Name is ' || v_name);
    
        begin
            select department_id into v_dept_name from employees where first_name = v_name;
            dbms_output.put_line('Hello '|| v_name || '. Your department id is : '|| v_dept_name );
        exception 
            when too_many_rows then
            dbms_output.put_line('There are more than one employees with the name '|| v_name);
            dbms_output.put_line('Try with a different employee');
        end;

exception 
    
    when no_data_found then 
    dbms_output.put_line('There is no employee with the selected id');

end;















--select * from employees --where first_name = 'Steven';




