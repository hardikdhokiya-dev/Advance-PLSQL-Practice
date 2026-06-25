SET SERVEROUTPUT ON;

declare
    
    cursor c_emp (v_dept_id number) is select first_name,last_name,department_name from employees join departments using (department_id) where department_id = v_dept_id; 
    
    v_emp c_emp %rowtype;
    
begin
    
    open c_emp (:b_dept_id);
    fetch c_emp into v_emp;
    dbms_output.put_line ('Department name is ' || v_emp.department_name);
    close c_emp;
    
-- print all employees who are working in department entered in bind variable
    open c_emp (:b_dept_id);
    loop
        fetch c_emp into v_emp;
        exit when c_emp %notfound;
        dbms_output.put_line ('Working employee name is ' || v_emp.first_name || ' ' || v_emp.last_name);
    end loop;
    close c_emp;
    
    
-- With second parameter as a bind variable
    
    open c_emp (:b_dept_id2);
    fetch c_emp into v_emp;
    dbms_output.put_line ('Department name is ' || v_emp.department_name);
    close c_emp;
    
-- print all employees who are working in department entered in second bind variable
  /*  open c_emp (:b_dept_id2);
    loop
        fetch c_emp into v_emp;
        exit when c_emp %notfound;
        dbms_output.put_line ('Working employee name is ' || v_emp.first_name || ' ' || v_emp.last_name);
    end loop;
    close c_emp;*/
    
-- Using for loop

    for i in c_emp (:b_dept_id2) loop
        
        dbms_output.put_line ('Working employee name is ' || i.first_name || ' ' || i.last_name);
    
    end loop;
    
end;


/******************************************** Cursor with two parameter *********************************************/

declare
    
    cursor c_emp (v_dept_id number , v_job_id varchar2) is select first_name,last_name,department_name,job_id  
                                                           from employees join departments using (department_id) where department_id = v_dept_id and job_id = v_job_id; 
    
    
begin

    for i in c_emp (:b_dept_id1, :b_job_id1) loop
    --for i in c_emp (50, 'ST_MAN') loop
        
        dbms_output.put_line (i.first_name || ' ' || i.last_name || '-' || i.job_id);
    
    end loop;
    
    dbms_output.put_line ('-----------------------------------------------');
    
    --for i in c_emp (80, 'SA_MAN') loop
    for i in c_emp (:b_dept_id2, :b_job_id2) loop
        
        dbms_output.put_line (i.first_name || ' ' || i.last_name || '-' || i.job_id);
    
    end loop;
end;












































