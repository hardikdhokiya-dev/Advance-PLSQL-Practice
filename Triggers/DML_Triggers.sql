set serveroutput on;

/** before row trigger with raise application error and conditional predicates along with Referencing ***/

create or replace trigger before_row_emp_cpy
    before insert or update or delete on employees_copy
    referencing old as O new as N
    for each row
    
    begin
    
    dbms_output.put_line ('Before row trigger is fired..!');
    dbms_output.put_line ('Before value ' || :o.salary || '==>'|| 'After value ' || :n.salary);
    
    /*
    only one conditional predicates can be true at the same time
    Update and Update ('columnname') can be true at the same time
    */
    
    -- we will restrict the insert of future hire date
     if inserting then
     
        if (:n.hire_date > sysdate) then
            
            raise_application_error (-20001, 'Can not enter the future hire date');
            
        end if;
        
        dbms_output.put_line ('Inserted the data in the table');
    
    
    -- we will restrict the update of beyond 50000
    
   elsif updating ('salary') then
     
        if (:n.salary > 50000) then
            
            raise_application_error (-20002, 'Can not updte the salary more than 50000');
            
        end if;
        
        dbms_output.put_line ('Updated the table and salary column');
        
    /* here both update will become true since it is at the same level and updating one column is also an update operation on the row 
    if updating ('salary') then
     
        dbms_output.put_line ('Updated the table and salary column');
            
    end if;
    
    if updating then
     
        dbms_output.put_line ('Updated the table');
            
    end if; */



    
    elsif updating then
        
        dbms_output.put_line ('Updated the table');
        
    
    -- delete record is not allowed
    
    elsif deleting then
    
        raise_application_error (-20003, 'delete is not allowed');
        dbms_output.put_line ('deleted the record');
    
    end if;
    
    end;
            
               
/***  Run the above trigger and validation ***/

select * from employees_copy;

insert into employees_copy select * from employees;

delete from employees_copy;

update employees_copy set salary = 60000;

update employees_copy set salary = 40000;

alter table employees_copy disable all triggers;

/*********************************************************************************************************************************************************/
/*********** update of trigger ******************/


create or replace trigger prevent_update_of_constant_columns
    before update of hire_date, salary on employees_copy
    for each row
    
    begin
    
        raise_application_error (-20004, 'Can not modify hire date and salary');

    end;


update employees_copy set salary = 4000;

alter table employees_copy disable all triggers;

/*********************************************************************************************************************************************************/
/*********** when caluse on trigger, since the body is not executed, we will have the better performance  ******************/


create or replace trigger prevent_high_salaries
    before insert or update of salary on employees_copy
    referencing old as o new as n
    for each row
    when (n.salary > 50000)
    
    begin
    
        raise_application_error (-20004, 'Salary can not be higher than 50000');

    end;


update employees_copy set salary = 60000;

alter table employees_copy disable all triggers;














