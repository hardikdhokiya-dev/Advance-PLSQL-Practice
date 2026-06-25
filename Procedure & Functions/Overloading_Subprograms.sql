set serveroutput on;

/******************************************** Local subprogram overloading *********************************************/

--create table highsal_employees as select * from employees where 1=2;

DECLARE
    
    procedure insert_highest_paid_employees (p_emp in employees%rowtype) as
    
    vg_emp employees%rowtype; -- global variable
    
    ------------------------------------------using employee_id ----------------------------------------------- 
    
    function f_get_emps (emp_num in employees.employee_id%type) return employees%rowtype as
      
            begin
            
                select * into vg_emp  from employees where employee_id = emp_num;
            
                return vg_emp;
                
            end;
    ------------------------------------------using email- function overloading ----------------------------------------------- 
    function f_get_emps (emp_email in employees.email%type) return employees%rowtype as
      
            begin
            
                select * into vg_emp  from employees where email = emp_email;
            
                return vg_emp;
                
            end;
    
    ------------------------------------------using first name and last name - function overloading ----------------------------------------------- 
    function f_get_emps (emp_first_name in employees.first_name%type, emp_last_name in employees.last_name%type) return employees%rowtype as
      
            begin
            
                select * into vg_emp  from employees where first_name  = emp_first_name and last_name = emp_last_name;
            
                return vg_emp;
                
            end;
    
    begin
    
        vg_emp := f_get_emps (p_emp.first_name, p_emp.last_name);
        
        insert into highsal_employees values vg_emp;
        
        vg_emp := f_get_emps (p_emp.employee_id);
        
        insert into highsal_employees values vg_emp;
        
        vg_emp := f_get_emps (p_emp.email);
        
        insert into highsal_employees values vg_emp;
        
    end;


BEGIN

    for emp in (select * from employees) loop
        
        if emp.salary > 15000 then
            
            insert_highest_paid_employees (emp);
        
        end if;
        
    end loop;

END;


--TRUNCATE table highsal_employees;
select * from highsal_employees;

--desc highsal_employees;