CREATE OR REPLACE PACKAGE BODY PKG AS
    
    /*
        Forward reference handeling so that we do no need to worry about the function sequence and it's execution oder
        Also, these are not defined in the package body so order will be important and we handeled with the forward referenceing
    */
    
    function get_emp return ass_arr_emp_table_type;
    function emp_sal_to_be_increse return ass_arr_emp_table_type;
    --procedure increase_low_salaries;
    function arrange_for_min_sal (v_emp in out employees%rowtype) return employees%rowtype;


    /*
        This function will return all the employees from the employes table in the associative array
    */
    
    function get_emp return ass_arr_emp_table_type is
    v_emps ass_arr_emp_table_type;
    
    begin
    
        for cur_emps in (select * from employees_copy) loop
        
            v_emps(cur_emps.employee_id) := cur_emps;
        
        end loop;
        
        return v_emps;
    
    end;
    
    
    /*
        This function will return all the employees whose salary is under the minimum salary of the company standard
    */
    
    
    function emp_sal_to_be_increse return ass_arr_emp_table_type is
    v_emps ass_arr_emp_table_type;
    i employees.employee_id%type;
    
    
    begin
        
        v_emps := get_emp;
        i := v_emps.first();
        
        while i is not null loop
            if v_emps(i).salary > v_min_sal then
                v_emps.delete(i);
            end if;
            i := v_emps.next(i);
        end loop;
        
        return v_emps;
    end;
    
    
    /*
        This procedure increases the salaries of the employees who has a lower salary than the company standard
    */
    
    procedure increase_low_salaries is
    v_emps ass_arr_emp_table_type;
    r_emp employees%rowtype;
    i employees.employee_id %type;
    
    begin
    
        v_emps := emp_sal_to_be_increse;
        
        i := v_emps.first();
        
        while i is not null loop
    
            r_emp := arrange_for_min_sal (v_emps(i));
            
            update employees_copy set row = r_emp where employee_id = i;
    
            i := v_emps.next(i);
    
        end loop;    
    
    end;
    
    
    /*
        This function returns the employee by arranging the salary based on the company standard
        IN parameter is only read only we can not use it for the modification
    */
    
    
    function arrange_for_min_sal (v_emp in out employees%rowtype) return employees%rowtype is
    
    begin
    
        v_emp.salary := v_emp.salary + v_sal_increase;
        
        if v_emp.salary < v_min_sal then
        
            v_emp.salary := v_min_sal;
        
        end if;
        
        return v_emp;
    
    end;

END PKG;


--exec pkg.increase_low_salaries;