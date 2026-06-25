SET SERVEROUTPUT ON;


/******************************************** STRONG OR RESTRICTIVE REF CURSOR *********************************************/
declare
    type tr_emp is ref cursor return employees%rowtype;
    
    rf_emp tr_emp;
    
    r_emp employees%rowtype;
    
    /*WE CAN CREATE A RECORD USING REF CURSOR TYPE TOO FOR STRONG CURSOR
    --r_emp rf_emp%rowtype;
    
    CREATED ANOTHER TYPE FROM USING PREVIOUS ONE
    type tr_emp2 is ref cursor return rf_emp%rowtype;
    */

begin

    --open rf_emp for select * from employees;
    open rf_emp for select * from retired_employees;
    
    loop
        fetch rf_emp into r_emp;
        exit when rf_emp %notfound;
        dbms_output.put_line('First name: '||r_emp.first_name || ' and Last Name: '||r_emp.last_name);
    end loop;
    
    close rf_emp;
    
    dbms_output.put_line('----------------------------');
    
    open rf_emp for select * from employees where job_id = 'IT_PROG';
    
    loop
        fetch rf_emp into r_emp;
        exit when rf_emp %notfound;
        dbms_output.put_line('First name: '||r_emp.first_name || ' and Last Name: '||r_emp.last_name);
    end loop;
    
    close rf_emp;

end;




/******************************************** Example of using with %type when declaring records  *********************************************/
-- WE MUST USE %TYPE FOR THAT


declare

    r_emp employees%rowtype;
    
    type tr_emp is ref cursor return r_emp %TYPE;
    
    rf_emp tr_emp;  

begin

    --open rf_emp for select * from employees;
    open rf_emp for select * from retired_employees;
    
    loop
        fetch rf_emp into r_emp;
        exit when rf_emp %notfound;
        dbms_output.put_line('First name: '||r_emp.first_name || ' and Last Name: '||r_emp.last_name);
    end loop;
    
    close rf_emp;
    
    dbms_output.put_line('----------------------------');
    
    open rf_emp for select * from employees where job_id = 'IT_PROG';
    
    loop
        fetch rf_emp into r_emp;
        exit when rf_emp %notfound;
        dbms_output.put_line('First name: '||r_emp.first_name || ' and Last Name: '||r_emp.last_name);
    end loop;
    
    close rf_emp;

end;


/************************************* manually declared record type with cursors example **********************************************/

declare
    type rt_emp is record (e_id number,
                           first_name employees.first_name%type,
                           last_name employees.last_name%type,
                           department_name departments.department_name%type);
                           
    r_emps rt_emp;
    
    type trf_emps is ref cursor return rt_emp;                             

    rf_emps trf_emps;


begin

    open rf_emps for select employee_id, first_name, last_name, department_name from employees join departments using (department_id);
    
    loop
         fetch rf_emps into r_emps;
         exit when rf_emps%notfound;
         dbms_output.put_line(r_emps.first_name|| ' ' || r_emps.last_name|| ' is at the department of : '|| r_emps.department_name );
    end loop;
    
    close rf_emps;

end;


/************************************* first example of weak ref cursors **********************************************/

declare
    type ty_emps is record (e_id number, 
                         first_name employees.first_name%type, 
                         last_name employees.last_name%type,
                         department_name departments.department_name%type);
    r_emps ty_emps;
    
    type t_emps is ref cursor;
    
    rc_emps t_emps;
    
    q varchar2(200);

begin
  q := 'select employee_id,first_name,last_name,department_name 
                      from employees join departments using (department_id)';
  open rc_emps for q;
    loop
      fetch rc_emps into r_emps;
      exit when rc_emps%notfound;
      dbms_output.put_line(r_emps.first_name|| ' ' || r_emps.last_name|| 
            ' is at the department of : '|| r_emps.department_name );
    end loop;
  close rc_emps;
end;




/************************************* bind variables with cursors example **********************************************/

declare
    type ty_emps is record (e_id number, 
                         first_name employees.first_name%type, 
                         last_name employees.last_name%type,
                         department_name departments.department_name%type);
    r_emps ty_emps;
    
    type t_emps is ref cursor;
    
    rc_emps t_emps;
    
    r_depts departments%rowtype;
    
    --r t_emps%rowtype;
    
    q varchar2(200);

begin
    q := 'select employee_id,first_name,last_name,department_name 
                      from employees join departments using (department_id)
                      where department_id = :t';
  
  open rc_emps for q using '50';
    loop
      fetch rc_emps into r_emps;
      exit when rc_emps%notfound;
      dbms_output.put_line(r_emps.first_name|| ' ' || r_emps.last_name|| 
            ' is at the department of : '|| r_emps.department_name );
    end loop;
  close rc_emps;
  
  open rc_emps for select * from departments;
    loop
      fetch rc_emps into r_depts;
      exit when rc_emps%notfound;
      dbms_output.put_line(r_depts.department_id|| ' ' || r_depts.department_name);
    end loop;
  close rc_emps;
end;



/************************************* sys_ref cursor example **********************************************/


declare
    type ty_emps is record (e_id number, 
                         first_name employees.first_name%type, 
                         last_name employees.last_name%type,
                         department_name departments.department_name%type);
    r_emps ty_emps;
-- type t_emps is ref cursor;
    rc_emps sys_refcursor;
    r_depts departments%rowtype;
 --r t_emps%rowtype;
 q varchar2(200);
begin
  q := 'select employee_id,first_name,last_name,department_name 
                      from employees join departments using (department_id)
                      where department_id = :t';
  open rc_emps for q using '50';
    loop
      fetch rc_emps into r_emps;
      exit when rc_emps%notfound;
      dbms_output.put_line(r_emps.first_name|| ' ' || r_emps.last_name|| 
            ' is at the department of : '|| r_emps.department_name );
    end loop;
  close rc_emps;
  
  open rc_emps for select * from departments;
    loop
      fetch rc_emps into r_depts;
      exit when rc_emps%notfound;
      dbms_output.put_line(r_depts.department_id|| ' ' || r_depts.department_name);
    end loop;
  close rc_emps;
end;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--> If we are using a table type as a return type of the cursor then %rowtype
--> If we are returning a record type that has a table type then %type
--> If we are using manully created record type then typename only





























