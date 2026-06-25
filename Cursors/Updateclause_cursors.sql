SET SERVEROUTPUT ON;

declare
    
    cursor c_emps is select first_name, last_name, department_name, employee_id,phone_number from employees_copy join departments using (department_id) where employee_id in (100,101,103)
    for update of employees_copy.phone_number wait 5; --nowait ;
    
    
begin
    /*for r_emp in c_emps loop
        update employees_copy set phone_number = 3 where employee_id = r_emp.employee_id;
    end loop;*/
    open c_emps;
end;


select * from employees where department_id = 30;



/******************************************** Cursor with where current of clause *********************************************/
--row id is is much faster and will not work with joins and group functions 
-- when we use cursor with for update clause it return rows with rowid


select rowid, e.* from employees e where e.department_id = 30;

declare
    cursor c_emp is select * from employees where department_id = 30 for update;
    
begin

    for r_emp in c_emp loop
    
        update employees set salary = salary + 60 where current of c_emp;
    
    end loop;


end;

/******************************************** Without where current of clause when we have joins *********************************************/

select rowid, e.* from employees e where e.department_id = 30;

declare
    cursor c_emp1 is select e.rowid, e.salary from employees e join departments d on e.department_id = d.department_id where e.department_id = 30;
 
 
begin
    for e_emp in c_emp1 loop
    
        update employees e set salary = salary + 60 where rowid = e_emp.rowid;
    
    end loop;
    
end;























