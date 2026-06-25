SET SERVEROUTPUT ON;

DECLARE
    V_NAME VARCHAR2(50);
    V_SAL employees.salary%TYPE;
    
BEGIN
    SELECT first_name || ' ' || last_name, salary INTO V_NAME,V_SAL FROM employees WHERE employee_id = 100;
    dbms_output.put_line('The salary of '|| V_NAME || ' is : '|| V_SAL);

END;

--***************************************************************************************************************************

-- CREATE TABLE

CREATE TABLE employees_copy AS SELECT * FROM employees;

SELECT * FROM employees_copy;


--***************************************************************************************************************************
--INSERT RECORDS
    
BEGIN

    FOR i IN 207..216 LOOP
    INSERT INTO employees_copy (Employee_id, First_Name, Last_Name, Email, Hire_Date, Job_Id, Salary)
    VALUES
    (i,'employee_id#'||i,'temp_emp','abc@gmail.com',SYSDATE, 'IT_PROG',1000);
    END LOOP;
    
END;


--***************************************************************************************************************************
-- UPDATE SALARY
DECLARE
    V_SAL_INCREASE NUMBER := 400;
BEGIN

    FOR i IN 207..216 LOOP
    UPDATE employees_copy SET Salary = V_SAL_INCREASE + Salary WHERE employee_id = i;
    END LOOP;
    
END;

--***************************************************************************************************************************
--DELETE RECORDS

BEGIN

    FOR i IN 207..216 LOOP
    DELETE FROM employees_copy WHERE employee_id = i;
    END LOOP;
END;

--***************************************************************************************************************************
-- CRETAE SEQUENCE


CREATE SEQUENCE employee_id_seq
START WITH 207
INCREMENT BY 1;

--INSERT RECORDS USING SEQUENCE
BEGIN

    FOR i IN 1..10 LOOP
    INSERT INTO employees_copy (Employee_id, First_Name, Last_Name, Email, Hire_Date, Job_Id, Salary)
    VALUES
    (employee_id_seq.NEXTVAL,'employee_id#'||employee_id_seq.NEXTVAL,'temp_emp','abc@gmail.com',SYSDATE, 'IT_PROG',1000);
    END LOOP;
    
END;

--New way to define and use sequence

DECLARE
    V_SEQ_NUM NUMBER;
BEGIN

    V_SEQ_NUM := employee_id_seq.NEXTVAL;
    dbms_output.put_line(V_SEQ_NUM);
    dbms_output.put_line(employee_id_seq.CURRVAL);

END;


/****************************************************** Example 4 *******************************************************/
DECLARE
  v_name        VARCHAR2(50);
  v_salary      employees.salary%type;
  v_employee_id employees.employee_id%type := 130;
BEGIN 
  SELECT first_name ||' '|| last_name, salary 
  INTO   v_name, v_salary 
  FROM   employees 
  WHERE  employee_id = v_employee_id;
  dbms_output.put_line('The salary of '|| v_name || ' is : '|| v_salary );
END;