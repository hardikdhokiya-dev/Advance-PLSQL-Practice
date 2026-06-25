SET SERVEROUTPUT ON;


-- define entire row as a record
DECLARE
    EMP_REC employees %ROWTYPE;
    
BEGIN
    
    SELECT * INTO EMP_REC FROM employees WHERE employee_id = 101;
    dbms_output.put_line(emp_rec.First_Name);
    emp_rec.salary := 2000;
    dbms_output.put_line(emp_rec.first_name || ' '                ||
                         emp_rec.last_name  || ' earns '          ||
                         emp_rec.salary     || ' and hired at : ' || 
                         emp_rec.hire_date);
    
    
END;

--***************************************************************************************************************************

-- Create own record


DECLARE
    TYPE emp_rec_owntype IS RECORD (name employees.first_name%TYPE, 
                                    surname VARCHAR2(50), 
                                    salary employees.salary%TYPE, 
                                    hire_date DATE);

   EMP_REC emp_rec_owntype;  --Creating record from type we created above
    
BEGIN
    
    emp_rec.name := 'Darvin';
    emp_rec.surname := 'Max';
    emp_rec.salary := 1000;
    emp_rec.hire_date := SYSDATE;
    
    dbms_output.put_line(emp_rec.name || ' '                ||
                         emp_rec.surname || ' earns '          ||
                         emp_rec.salary     || ' and hired at : ' || 
                         emp_rec.hire_date);  
END;



--***************************************************************************************************************************

-- Create a record of an employee including the education

DECLARE
    TYPE edu_type IS RECORD (primary_school VARCHAR2(100),
                            high_school VARCHAR2(100),
                            university VARCHAR2(100),
                            uni_grad_date DATE);
    
    TYPE emp_rec IS RECORD (first_name VARCHAR2(50),
                            last_name employees.last_name%TYPE,
                            salary employees.salary%TYPE NOT NULL DEFAULT 1000,
                            hire_date DATE,
                            dept_id employees.department_id%TYPE,
                            department_rec departments%ROWTYPE,
                            edu_rec edu_type);
    
    emp_recrd emp_rec;
    
BEGIN

    SELECT first_name, last_name, salary, hire_date, department_id 
    INTO    emp_recrd.first_name, 
            emp_recrd.last_name, 
            emp_recrd.salary,
            emp_recrd.hire_date,
            emp_recrd.dept_id
    FROM employees
    WHERE employee_id = 146;
    
    -- Insert values in to department_rec from department table
    
    SELECT * INTO emp_recrd.department_rec FROM departments WHERE department_id = emp_recrd.dept_id;
    
    --Since we don't have any table for edu_rec we need to enter values manually.
    
    emp_recrd.edu_rec.primary_school := 'Smart School';
    emp_recrd.edu_rec.high_school := 'Science School';
    emp_recrd.edu_rec.university := 'GTU';
    emp_recrd.edu_rec.uni_grad_date := SYSDATE;
    
    
    -- Print the output
    
        dbms_output.put_line(emp_recrd.first_name || ' '                ||
                         emp_recrd.last_name || ' earns '          ||
                         emp_recrd.salary     || ' and hired at : ' || 
                         emp_recrd.hire_date);  
    
        dbms_output.put_line('Her Department is : ' || emp_recrd.department_rec.department_name); 
        
        dbms_output.put_line('She completed hey primary school from ' || emp_recrd.edu_rec.primary_school ||'. She completed her high school from ' 
                            || emp_recrd.edu_rec.high_school || ', then she graduated from '||emp_recrd.edu_rec.university || ' at ' || emp_recrd.edu_rec.uni_grad_date); 
    
--DESC employees; 
--DESC departments;

END;
    
--***************************************************************************************************************************
-- Create table and insert data into the records


create table retired_employees as select * from employees where 1 = 2;    -- 1 = 2 is used to copy table with structure BUT not data
--DROP TABLE retired_employess;

SELECT * FROM retired_employees;

DESC retired_employees;


DECLARE 
    rec_emp_1 employees %ROWTYPE;

BEGIN
    SELECT * INTO rec_emp_1 FROM employees WHERE employee_id = 104;
    rec_emp_1.SALARY := 0;
    rec_emp_1.COMMISSION_PCT := 0;
    INSERT INTO retired_employees VALUES rec_emp_1;

END;

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE using ROW keyword :- Updating entire row with the values
DECLARE 
    rec_emp_1 employees %ROWTYPE;

BEGIN
    SELECT * INTO rec_emp_1 FROM employees WHERE employee_id = 104;
    rec_emp_1.SALARY := 100;
    rec_emp_1.COMMISSION_PCT := 0;
    UPDATE retired_employees SET ROW = rec_emp_1 WHERE employee_id = 104;

END;































