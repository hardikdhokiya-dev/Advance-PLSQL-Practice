create table department_copy1 as select * from departments;

select * from department_copy1;

select * from employees;

select department_name, salary from employees join department_copy1 using (department_id);

----------------- creating a complex view -----------------

create or replace view vw_emp_det1 as
    select upper(department_name) dept_name , max(salary) max_sal, min(salary) min_sal
    from employees join department_copy1
    using (department_id)
    group by department_name;
    
select * from vw_emp_det1;

----------------- updating the complex view -----------------

update vw_emp_det1 set dept_name = 'abc' where upper(dept_name) = 'EXECUTIVE';


----------------- Creating sequence for department id so it will always have new unique value -----------------

select max(department_id) from department_copy1;

create sequence dept_id_seq
start with 270
increment by 10
NOCACHE;




------------------------------ Instead of trigger --------------------------------------------------------------------------------

create or replace trigger t_vw_emp_det1
    instead of insert or delete or update on vw_emp_det1
    referencing old as o new as n
    for each row
    
    declare
    
        v_dept_id pls_integer;
        
    
    begin
    
    if inserting then
       
       v_dept_id := dept_id_seq.nextval;
       
       insert into department_copy1 values (v_dept_id, :n.dept_name, null, null);
       
    elsif deleting then
        
        delete from department_copy1 where upper(department_name) = upper(:o.dept_name);
        
    elsif updating ('dept_name') then
        
        update department_copy1 set department_name = :n.dept_name where upper(department_name) = upper(:o.dept_name);
    
    else
        
        raise_application_error (-20007, 'You cannot update any data other than department name!.');
    
    end if;
    
    end;
    
/********************************************************************************************************************************************/


update vw_emp_det1 set dept_name = 'abc' where upper(dept_name) = 'EXECUTIVE';


select * from vw_emp_det1;

select * from department_copy1;

delete from vw_emp_det1 where dept_name = 'ABC';

Insert into vw_emp_det1 values ('Execution', null, null);

update vw_emp_det1 set min_sal = 5000 where upper(dept_name) = 'ACCOUNTING';


/********************************************************************************************************************************************/


select * from user_triggers;

alter trigger t_vw_emp_det1 disable;


/********************************************************************************************************************************************/

-- audit log tables and log triggers for departments_copy table

desc department_copy;


-- log table for department copy

create table log_department_copy
    (Log_user varchar2(30), Log_date date, DML_Type varchar2(10),
     old_department_id varchar2 (4), new_department_id varchar2 (4),
     old_department_name varchar2(30), new_department_name varchar2(30),
     old_manager_id number(6), new_manager_id number(6),
     old_location_id number(4), new_location_id number(4));
    
-- crating trigger for each DML operation for department_copy table
-- we used after timings becuase if any error occurs in the actual table, this trigger will not be executed.This will increase the performance.
-- if we used Before trigger and error occurs during the insertion than it will rollback the changes automatically

create or replace trigger log_dept_copy_trg 
    after insert or update or delete on department_copy
    referencing old as o new as n
    for each row
    
    declare
        v_DML_Type varchar2(10);
    
    begin
    
        if inserting then
            
            v_DML_Type := 'Insert';
            
        elsif updating then
            
            v_DML_Type := 'Update';
    
        elsif deleting then
            
            v_DML_Type := 'Delete';
    
        end if;
        
        insert into log_department_copy values (
        
            user , sysdate , v_DML_Type,
            :o.department_id , :n.department_id,
            :o.department_name , :n.department_name,
            :o.manager_id, :n.manager_id,
            :o.location_id, :n.location_id
 
        );
    
    
    
    end;


/************************* DML Operaion to check the log table ********************************/


insert into department_copy values (300, 'Cyber security', 100, 700);

select * from department_copy;

select * from log_department_copy;

update department_copy set manager_id = 500 where department_name = 'Cyber security';

delete from department_copy where department_name = 'Cyber security';
























