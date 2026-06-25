set serveroutput on;

/******************************************** Local subprogram creation and anonympous block *********************************************/
-- create table that includes high paid employees 

create table highest_paid_employees as select * from employees where 1=2;

DECLARE
 
 
----------------------------function to get the employee from the employees table using emp_id------------------------------------

    function get_emp (emp_id employees.employee_id%type) return employees%rowtype as
    
    emp employees%rowtype;
    
    begin 
    
        select * into emp from employees where employee_id = emp_id;
        return emp;
    
    end;

----------------------------procedure to insert values into highest_paid_employees table using emp_id------------------------------------
    procedure insert_high_paid_emp (emp_num in employees.employee_id%type) as
    
    emp employees%rowtype;
    
    begin
        
        emp := get_emp (emp_num);
        insert into highest_paid_employees values emp;
        
    end;

----------------- logic for highest paid employee --------------------------------

BEGIN

    for i in (select * from employees) loop
       
       if i.salary > 15000 then
            
            insert_high_paid_emp(i.employee_id);
        
        end if;
          
    end loop;

END;

------------------------------------------------------------------------------------

--select * from employees;

select * from highest_paid_employees;

--desc highest_paid_employees


/******************************************** Scope of emp variable *********************************************/

DECLARE
 
----------------------------procedure to insert values into highest_paid_employees table using emp_id------------------------------------

-- after delcare keyword we can ONLY write  begin, local function, pragma and local procedure

-- since the function is define under the procedure and function is at the same block of that variable we don;'t need to declare it twice (emp)

    procedure insert_high_paid_emp (emp_num in employees.employee_id%type) as
    
    emp employees%rowtype;
    
    function get_emp (emp_id employees.employee_id%type) return employees%rowtype as
    
        begin 
    
            select * into emp from employees where employee_id = emp_id;
            return emp;
    
        end;
    
    begin
        
        emp := get_emp (emp_num);
        insert into highest_paid_employees values emp;
        
    end;

----------------- logic for highest paid employee --------------------------------

BEGIN

    for i in (select * from employees) loop
       
       if i.salary > 15000 then
            
            insert_high_paid_emp(i.employee_id);
        
        end if;
          
    end loop;

END;

