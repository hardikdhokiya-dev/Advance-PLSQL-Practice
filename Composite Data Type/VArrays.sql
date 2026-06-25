SET SERVEROUTPUT ON;

DECLARE
    TYPE e_list IS VARRAY(5) OF VARCHAR2(50);
    employees e_list;
    
    
BEGIN
    employees := e_list('Alex', 'Bruce', 'John', 'Bob', 'dfasd');
    FOR i IN 1..employees.count() LOOP
        dbms_output.put_line(employees(i));
    END LOOP;

END;

-------------------------------------------------------------------------------------------------------------------------------

DECLARE
    TYPE e_list IS VARRAY(5) OF VARCHAR2(50);
    employees e_list;
    
    
BEGIN
    employees := e_list('Alex', 'Bruce', 'John', 'Bob', 'dfasd');
    FOR i IN 1..5 LOOP
        IF employees.exists(i) THEN
            dbms_output.put_line(employees(i));
        END IF;
    END LOOP;

END;


-------------------------------------------------------------------------------------------------------------------------------


DECLARE
    TYPE e_list IS VARRAY(5) OF VARCHAR2(50);
    employees e_list;
    
    
BEGIN
    employees := e_list('Alex', 'Bruce', 'John', 'Bob');
    dbms_output.put_line(employees.LIMIT());

END;


-------------------------------------------------------------------------------------------------------------------------------
-- Initialization at the time of declaration

DECLARE
    TYPE e_list IS VARRAY(5) OF VARCHAR2(50);
    employees e_list := e_list('Alex', 'Bruce', 'John', 'Bob');
    
    
BEGIN

    dbms_output.put_line(employees.LIMIT());

END;

-------------------------------------------------------------------------------------------------------------------------------

DECLARE 
    TYPE e_list IS VARRAY(15) OF VARCHAR(50);
    employees1 e_list := e_list();
    idx NUMBER := 1;

BEGIN
    
    FOR i IN 100..110 LOOP
    employees1.EXTEND; -- EXTEND allocates memory for a new element in a PL/SQL collection so that a value can be stored at that index.
    SELECT first_name INTO employees1(idx) FROM employees WHERE employee_ID = i;
    idx := idx + 1;
    END LOOP;
    
    FOR j IN 1..employees1.count() LOOP 
    dbms_output.put_line(employees1(j));
    END LOOP;

END;

-------------------------------------------------------------------------------------------------------------------------------

-- An Example for the Schema-Level Varray Types

CREATE TYPE e_list IS VARRAY(15) OF VARCHAR2(50);

-- FOR UPDATE THE TYPE USE -> REPLACE -> CREATE OR REPLACE TYPE e_list AS VARRAY(20) OF VARCHAR2(100);
-- FOR DROP THE TYPE -> DROP -> DROP TYPE e_list;

DECLARE 
    employees1 e_list := e_list();
    idx NUMBER := 1;

BEGIN
    
    FOR i IN 100..110 LOOP
    employees1.EXTEND; -- EXTEND allocates memory for a new element in a PL/SQL collection so that a value can be stored at that index.
    SELECT first_name INTO employees1(idx) FROM employees WHERE employee_ID = i;
    idx := idx + 1;
    END LOOP;
    
    FOR j IN 1..employees1.count() LOOP 
    dbms_output.put_line(employees1(j));
    END LOOP;

END;


--------------------------------------------------------------------------------------------------------------------------------------------
/* Error detail :

* Subscript outside of limit --> varray defined with less size (VARRAY(4)) and tried to store with more than 4 elements.

* Reference to uninitialized collection --> if we do not defined the Varray with element (e.g employees e_list := e_list('Alex', 'Bruce', 'John', 'Bob');)

* Subscript beyond count --> we tried to reach to the element that does not exists

* Limit() --> To get the maximum size of the varray, NOT the element count inside the varray


*/

















