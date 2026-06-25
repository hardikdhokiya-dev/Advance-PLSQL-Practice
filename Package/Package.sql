set serveroutput on;

/******************************************** Create package spec *********************************************/

create or replace package emp_pkg as

    v_sal_increase_rate number := .01;
    
    cursor cur_emp is select * from employees_copy for update;
    
    procedure sal_inc ;
    
    function avg_sal (v_dept_id in number) return number;
    
end emp_pkg;

/******************************************** Create package body *********************************************/

create or replace package body emp_pkg as

    --- forward reference handling can be done while defining function, procedure etc must be define before the first subprogram just like we did in the package spec so that it can be use further 
    
    

    procedure sal_inc is
    
        begin
        
            for i in cur_emp loop
            
                update employees_copy set salary = salary + (salary * v_sal_increase_rate);
            
            end loop;
         
        end sal_inc;


    function avg_sal (v_dept_id in number) return number is
    
    v_avg_sal number :=0;
    
        begin
            
            select avg(salary) into v_avg_sal from employees_copy where department_id = v_dept_id;
            
            return v_avg_sal;
    
        end avg_sal;
        
        

end emp_pkg;

/******************************************** Calling procedures, functions.. *********************************************/

exec emp_pkg.sal_inc;

-- becuase we can't standlone run functions same as procedure
begin
    
    print(emp_pkg.avg_sal(50));
    print (emp_pkg.v_sal_increase_rate);

end;


