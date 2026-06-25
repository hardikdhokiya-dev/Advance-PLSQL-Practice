SET SERVEROUTPUT ON;

DECLARE 
    TYPE e_list1 IS TABLE OF employees.first_name %TYPE INDEX BY PLS_INTEGER;
    emp e_list1;


BEGIN

    FOR i IN 100..110 LOOP
        SELECT  first_name INTO emp(i) FROM employees WHERE employee_id = i;
    END LOOP;
    
    FOR j IN emp.FIRST..emp.LAST LOOP
        dbms_output.put_line(emp(j));
    END LOOP;


END;

----------------------------------------------------------------------------------------------------------------------------------------

-- WE MOSTLY USE WHILE LOOP AND OTHER FUNCTIONS TO TRAVERSE THROUGH ASSOCIATIVE ARRAYS

DECLARE 
    TYPE e_list1 IS TABLE OF employees.first_name %TYPE INDEX BY PLS_INTEGER;
    emp e_list1;
    idx PLS_INTEGER;


BEGIN

    FOR i IN 100..110 LOOP
        SELECT  first_name INTO emp(i) FROM employees WHERE employee_id = i;
    END LOOP;
    
    idx := emp.FIRST();
    WHILE idx IS NOT NULL LOOP
        dbms_output.put_line(emp(idx));
        idx := emp.next(idx); --> it will returns the next index, not the grater one becuase idx is not sequencial in associative array.
                             ----> next means next key inserted after the first key 
    END LOOP;

END;

----------------------------------------------------------------------------------------------------------------------------------------
-- USING EMAILS AS A KEY

DECLARE 

    TYPE emp_list IS TABLE OF employees.first_name %TYPE INDEX BY employees.email%TYPE;
    emps emp_list;
    idx employees.email%TYPE;
    v_email employees.email%TYPE;
    v_first_name employees.first_name %TYPE;
    
BEGIN 
    FOR i IN 100..110 LOOP
        SELECT first_name,email INTO v_first_name,v_email FROM employees WHERE employee_id = i;
        emps(v_email) := v_first_name;
    END LOOP;
    
    idx := emps.FIRST();
    WHILE idx IS NOT NULL LOOP
        dbms_output.put_line('the email address for '|| emps(idx)|| ' is ' ||idx);
        idx := emps.NEXT(idx);
    END LOOP;


END;

----------------------------------------------------------------------------------------------------------------------------------------

-- USING RECORD IN THE ASSOCIATIVE ARRAYS


DECLARE 

    TYPE emp_list IS TABLE OF employees %ROWTYPE INDEX BY employees.email%TYPE;
    emps emp_list;
    idx employees.email%TYPE;
    v_email employees.email%TYPE;
    v_first_name employees.first_name %TYPE;
    
BEGIN 
    FOR i IN 100..110 LOOP
        SELECT * INTO emps(i) FROM employees WHERE employee_id = i;
    END LOOP;
    
    idx := emps.FIRST();
    WHILE idx IS NOT NULL LOOP
        dbms_output.put_line('the email of ' || emps(idx).first_name || ' ' || emps(idx).last_name|| 'is : ' || emps(idx).email);
        idx := emps.NEXT(idx);
    END LOOP;


END;

----------------------------------------------------------------------------------------------------------------------------------------

-- CREATE OWN TYPE OF RECORD IN THE ASSOCIATIVE ARRAYS



DECLARE 


    TYPE emp_rec_type IS RECORD ( first_name employees.first_name%TYPE,
                                  last_name employees.last_name%TYPE,
                                  email employees.email%TYPE);
    
    --r_emp emp_rec_type;
                          
                             
    TYPE emp_list IS TABLE OF emp_rec_type INDEX BY employees.email%TYPE;
    emps emp_list;
    idx employees.email%TYPE;
    v_email employees.email%TYPE;
    v_first_name employees.first_name %TYPE;
    
BEGIN 
    FOR i IN 100..110 LOOP
        SELECT first_name, last_name, email INTO emps(i) FROM employees WHERE employee_id = i;
    END LOOP;
    
    
    -- emps.DELETE(100);
    -- emps.DELETE (100, 104);
    idx := emps.FIRST();
    WHILE idx IS NOT NULL LOOP
        dbms_output.put_line('the email of ' || emps(idx).first_name || ' ' || emps(idx).last_name|| 'is : ' || emps(idx).email);
        idx := emps.NEXT(idx);
    END LOOP;


END;

----------------------------------------------------------------------------------------------------------------------------------------
-- TRAVERSE FROM LAST TO FIRST UISNG PRIOR() FUNCTION

DECLARE 


    TYPE emp_rec_type IS RECORD ( first_name employees.first_name%TYPE,
                                  last_name employees.last_name%TYPE,
                                  email employees.email%TYPE);
                                                
    TYPE emp_list IS TABLE OF emp_rec_type INDEX BY employees.email%TYPE;
    emps emp_list;
    idx employees.email%TYPE;
    v_email employees.email%TYPE;
    v_first_name employees.first_name %TYPE;
    
BEGIN 
    FOR i IN 100..110 LOOP
        SELECT first_name, last_name, email INTO emps(i) FROM employees WHERE employee_id = i;
    END LOOP;
    
    idx := emps.LAST;
    WHILE idx IS NOT NULL LOOP
        dbms_output.put_line('the email of ' || emps(idx).first_name || ' ' || emps(idx).last_name|| 'is : ' || emps(idx).email);
        idx := emps.PRIOR(idx);
    END LOOP;


END;

----------------------------------------------------------------------------------------------------------------------------------------
-- Create table -> create associative array -> copy data from employees table -> increase the salary by .2 for each employee and insert data into newly created table employees_salary_histry

CREATE TABLE employees_salary_histry AS SELECT * FROM employees WHERE 1=2;
ALTER TABLE employees_salary_histry ADD insert_date DATE;

SELECT * FROM employees_salary_histry;

DECLARE
    TYPE emp_list IS TABLE OF employees_salary_histry %ROWTYPE INDEX BY PLS_INTEGER;
    emp emp_list;
    idx PLS_INTEGER;

BEGIN

    FOR i IN 100..110 LOOP
        SELECT e.*, TO_DATE('11-DEC-2025', 'DD-MON-YYYY') INTO emp(i) FROM employees e WHERE employee_id = i;
    END LOOP;
    
    idx := emp.FIRST();
    WHILE idx IS NOT NULL LOOP
        emp(idx).salary := emp(idx).salary + emp(idx).salary * 0.2;
        INSERT INTO employees_salary_histry VALUES emp(idx);
        dbms_output.put_line('The employee '       || emp(idx).first_name ||
                         ' is inserted to the history table');
        idx := emp.next(idx);
    END LOOP;

END;

DROP TABLE employees_salary_histry;
























