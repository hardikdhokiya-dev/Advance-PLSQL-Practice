create or replace trigger trg_com_emps
    for insert or update or delete on employees_copy
    compound trigger
    
    v_dml_type varchar2(10);  -- declaration and it is optional based on requirement
    
    before statement is 
        begin
            if inserting then 
                v_dml_type := 'insert';
            elsif updating then
                v_dml_type := 'update';
            elsif deleting then
                v_dml_type := 'delete';
            end if;
        dbms_output.put_line('Before line statement trigger is executed with ' || v_dml_type ||' event..!');
    end before statement;
        
    
    before each row is
        begin
            dbms_output.put_line('Before each row trigger is executed with ' || v_dml_type ||' event..!');
    end before each row;
        
    
    after each row is
        begin
            dbms_output.put_line('After each row trigger is executed with ' || v_dml_type ||' event..!');
    end after each row;
        
    after statement is 
        begin
        dbms_output.put_line('after line statement trigger is executed with ' || v_dml_type ||' event..!');
    end  after statement;
    
end;

/********************************************************************************************************************************************/

/* create a trigger that will check the salaries after the update or inesrts
   if the salaries is greater than 15% of the avg salary of its department, then trigger will prevent the update 
*/


/*
    In the before statement we got the average salaries of the each department into the associative array that we created.
    In this way we perform the check much faster
    how --> let's say 100 rows to be updated - if we get the avg salary of the specific department in each update, we will query the database 100 times
            and too much contex switcing
    Instead we got the whole avg into our memory table (assosiative array) and in the updates we will get them from the memoery much faster
    Since we can easily get the average salaries much faster with using their indexes,it will increase the performance so much.
    
    BEFORE STATEMENT => Load avg salaries into collection
    AFTER EACH ROW => Validate each employee salary
    
    
    
    Row is modified
     ↓
    AFTER EACH ROW fires
     ↓
    Get :NEW.SALARY
    Get :NEW.DEPARTMENT_ID
     ↓
    Lookup avg salary from collection
     ↓
    Compare with threshold (avg + 15%)
     ↓
    If exceeded → ERROR → rollback
    

*/

create or replace trigger emp_copy_trg 
    for insert or update or delete on employees_copy
    compound trigger

    type avg_sal_arr_type is table of employees_copy.salary%type index by pls_integer;
    avg_sal_arr avg_sal_arr_type;
    
    
    --BEFORE STATEMENT => Load avg salaries into collection
    
    before statement is 
        
        begin
        
            for avg_sal in (select avg (salary) avg_salary, nvl(department_id,999) department_id from employees_copy group by department_id) loop
            
                avg_sal_arr(avg_sal.department_id) := avg_sal.avg_salary;
            
            end loop;
        
    end before statement;
    
    
    --AFTER EACH ROW => Validate each employee salary
     
    after each row is
    
        v_allow_perc number := 15;
        
        begin
        
            if (:new.salary > (avg_sal_arr(:new.department_id) + (avg_sal_arr(:new.department_id)*v_allow_perc/100))) then
                
                raise_application_error(-200004, 'A raise cannot be '|| v_allow_perc|| ' percent higher than its department''s average!');
                
            end if;               
        
    end after each row;
    
    
    after statement is
    
        begin
        
            dbms_output.put_line('All the changes are done successfully!');
    
    end after statement;


end;


/********************************************************************************************************************************************/

update employees_copy set salary = salary + 50000 where employee_id = 154;



































