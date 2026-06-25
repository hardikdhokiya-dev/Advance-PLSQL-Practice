set serveroutput on;

/******************************************** Exception handling in subprograms *********************************************/

create or replace function get_emp (emp_num in employees.employee_id%type) return employees %rowtype as

r_emp employees %rowtype;


begin
    
    select * into r_emp from employees where employee_id = emp_num;
    
    return r_emp;
    
exception 
    when no_data_found then
    dbms_output.put_line ('No data found with the given id : ' || emp_num);
    return null;
    --raise no_data_found;
    
    when others then
    dbms_output.put_line('Something unexpected happened!.');
    return null;
end;



/******************************************** calling fucntions in anonymus block *********************************************/


declare
    v_emp employees %rowtype;

begin
    
    dbms_output.put_line ('Fetching the employee data..!');
    v_emp := get_emp(100);
    dbms_output.put_line('Some information of the employee are : ');
    dbms_output.put_line('The name of the employee is : '|| v_emp.first_name);

end;



