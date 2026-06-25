SET SERVEROUTPUT ON;


/******************************************** Simple Loop *********************************************/
-- exit when c_emp%notfound;  important inside the loop --> last fetch retrieved a row not present

declare 
    cursor c_emp is select * from employees where department_id = 30;
    v_emp c_emp%rowtype;
    
begin
    open c_emp;
    
    loop
        fetch c_emp into v_emp;
    
        exit when c_emp%notfound;
        
        dbms_output.put_line(v_emp.first_name|| ' ' || v_emp.last_name || ' department id is ' ||v_emp.department_id );
    end loop;
    
    close c_emp;

end;

/******************************************** While Loop - NOT RECOMMENDED *********************************************/

declare 
    cursor c_emp is select * from employees where department_id = 30;
    v_emp c_emp%rowtype;
    
begin
    open c_emp;
    
    fetch c_emp into v_emp;
    
    while c_emp% found loop
    
        dbms_output.put_line(v_emp.first_name|| ' ' || v_emp.last_name || ' department id is ' ||v_emp.department_id );
        
        fetch c_emp into v_emp; 
        
    end loop;
    
    close c_emp;

end;

/******************************************** For Loop RECOMMENDED *********************************************/

-- when we want to use cursor for other/multiple purpose
declare 
    cursor c_emp is select * from employees where department_id = 30;
    
begin
    
    for i in c_emp loop
    
        dbms_output.put_line(i.first_name|| ' ' || i.last_name || ' department id is ' ||i.department_id );
        
    end loop;

end;


-- when we want to use cursor only once
   
begin
    
    for i in (select * from employees where department_id = 30) loop
    
        dbms_output.put_line(i.first_name|| ' ' || i.last_name || ' department id is ' ||i.department_id );
        
    end loop;

end;



