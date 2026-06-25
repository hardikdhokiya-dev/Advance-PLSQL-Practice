set serveroutput on;

/******************************************** Creating a function to calculate the avg salary based on departments *********************************************/

create or replace function get_avg_sal (dept_id in departments.department_id%type) return number as
v_avg_sal number;

begin

    select avg(salary) into v_avg_sal from employees where department_id = dept_id;
    
    return v_avg_sal;

end;

/******************************************** Calling a function *********************************************/
select * from departments;

select * from employees;

------------------------------------------------------------------------------------------------------------------
declare
    v_avg_salary number;

begin
    
    v_avg_salary := get_avg_sal(50);
    print (v_avg_salary);

end;


------------------------------------------------------------------------------------------------------------------
-- we can also call it wihtout assigning to variable

 begin
    
    print (get_avg_sal(50));

end;

------------------------------------------------------------------------------------------------------------------
-- we can use the inside the select statement, basically whenever we use variable we can use functions as well at that place.
    
    select employee_id, first_name, department_id, get_avg_sal(department_id) avg_salary from employees;
    

------------------------------------------------------------------------------------------------------------------

-- we can use it inside the where clause

select employee_id, first_name, department_id, get_avg_sal(department_id) avg_salary from employees where salary > get_avg_sal(department_id);

------------------------------------------------------------------------------------------------------------------

-- we can use it inside the where clause, group by and order by clause

select get_avg_sal(department_id) avg_salary from employees 
where salary > get_avg_sal(department_id)
group by get_avg_sal(department_id)
order by get_avg_sal(department_id);









