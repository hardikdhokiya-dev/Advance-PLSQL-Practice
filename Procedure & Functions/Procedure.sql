set serveroutput on;

/******************************************** Creating or Modifying a procedure *********************************************/

create or replace procedure salary_increase as
    
    v_sal_increase number := 0.10;
    v_old_sal number;

    cursor c_emp is select * from employees_copy for update;

begin

    for r_emp in c_emp loop
        v_old_sal := r_emp.salary;
        r_emp.salary := r_emp.salary + (r_emp.salary * v_sal_increase) + r_emp.salary * nvl(r_emp.commission_pct,0);
        update employees_copy set row = r_emp where current of c_emp;
        dbms_output.put_line ('the salary for ' || r_emp.employee_id || ' is incrased from ' || v_old_sal ||' to ' || r_emp.salary);
    end loop;
    
    dbms_output.put_line('Procedure finished executing!');
end;


/******************************************** Calling a procedure *********************************************/

--execute salary_increase;

begin

    salary_increase;

end;


/******************************************** Creating procedure using in and out parameter *********************************************/
-- get the salary increase percent and return the average increase percent of the salaries

create or replace procedure salary_increase 
                                            (v_sal_increase in out number ,  
                                             v_dept_id in number,
                                             v_affected_employee_count out number) as

    --v_sal_increase number := 0.10;
    v_old_sal number;
    v_sal_inc_avgpct number := 0;

    cursor c_emp is select * from employees_copy where department_id = v_dept_id for update;

begin

    v_affected_employee_count :=0;
    
    for r_emp in c_emp loop
        v_old_sal := r_emp.salary;
        r_emp.salary := r_emp.salary + (r_emp.salary * v_sal_increase) + r_emp.salary * nvl(r_emp.commission_pct,0);
        update employees_copy set row = r_emp where current of c_emp;
        dbms_output.put_line ('the salary for ' || r_emp.employee_id || ' is incrased from ' || v_old_sal ||' to ' || r_emp.salary);
        v_affected_employee_count := v_affected_employee_count +1;
        v_sal_inc_avgpct := v_sal_inc_avgpct + v_sal_increase + nvl(r_emp.commission_pct,0);
    end loop;
    
    
    v_sal_increase := v_sal_inc_avgpct/v_affected_employee_count;
    dbms_output.put_line('Procedure finished executing!');
end;





/******************************************** Creating procedure for printing *********************************************/

create procedure print (text in varchar2) as

begin
    dbms_output.put_line(text);
end;

exec print('Priting');

--default parameter 
exec print();

-- with null value, it will be consider as a null value and null means it will print nothing just blank 
exec print(null);



/******************************************** Calling a procedure with parameter *********************************************/



declare 
    
    v_sal_inc_avgpct number := .20;
    v_aff_count number;
    
    
begin
    
    print('salary increase started');
    salary_increase (v_sal_inc_avgpct, 80 , v_aff_count);
    print('The affected employee count is : '|| v_aff_count);
    print('The average salary increase is : '|| v_sal_inc_avgpct || ' percent!..');
    print('salary increase finished');
    
end;


/******************************************** Procedure with default parameter *********************************************/

create or replace procedure add_job (job_id in number, job_title in varchar2, min_salary in number default 2000, max_salary in number default null) as


begin

    insert into jobs values (job_id,job_title, min_salary, max_salary);
    print (job_id || ' Is added..!');
end;



/******************************************** Calling a procedure with positional notation *********************************************/

begin

    --add_job('1234','QA');
    add_job('12341','QA1',3000,5000);

end;

/******************************************** Calling a procedure with mixed notation *********************************************/

begin

    -- Not allowed add_job(min_salary => 6000, '1234','QA');
    add_job(min_salary => 6000, job_id=> '123412',job_title =>'QA12',max_salary => 3000);

end;

select * from jobs;






































