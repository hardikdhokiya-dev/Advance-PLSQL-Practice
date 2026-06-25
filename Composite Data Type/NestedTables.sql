SET SERVEROUTPUT ON;

DECLARE 
    TYPE e_list_1 IS TABLE OF VARCHAR2(50);
    emps e_list_1;

BEGIN
    emps := e_list_1('BOB','RAME','ATM');
    FOR i IN 1..emps.count() LOOP
        dbms_output.put_line(emps(i));
    END LOOP;
    
END;

----------------------------------------------------------------------------------------------------------------------------
-- Whenever we add some values to nested table we need to use EXTEND keyword to increases the memory to be able to store value.

DECLARE 
    TYPE e_list_2 IS TABLE OF VARCHAR2(50);
    emps2 e_list_2;

BEGIN
    emps2 := e_list_2('BOB','RAME','ATM');
    emps2.EXTEND;
    emps2(4) := 'MACHINE';
    FOR i IN 1..emps2.count() LOOP
        dbms_output.put_line(emps2(i));
    END LOOP;
    

-- update the value

    emps2 := e_list_2('BOB','RAME','ATM');
    emps2.EXTEND;
    emps2(3) := 'MACHINE-UPDATED';
    FOR i IN 1..emps2.count() LOOP
        dbms_output.put_line(emps2(i));
    END LOOP;
    
END;


----------------------------------------------------------------------------------------------------------------------------
-- Get the values form the database

DECLARE 
    --TYPE e_list_3 IS TABLE OF VARCHAR2(50);
    TYPE e_list_3 IS TABLE OF employees.first_name %TYPE;
    emps3 e_list_3 := e_list_3();
    idx PLS_INTEGER := 1;

BEGIN

    FOR j IN 100..110 LOOP 
    emps3.EXTEND;
    SELECT first_name INTO emps3(idx) FROM employees WHERE employee_id = j;
    idx := idx + 1;
    END LOOP;
    
    FOR i IN 1..emps3.count() LOOP
        dbms_output.put_line(emps3(i));
    END LOOP;
    
END;

----------------------------------------------------------------------------------------------------------------------------

-- HOW TO DELETE VALUES FORM

DECLARE 
    TYPE e_list_4 IS TABLE OF employees.first_name %TYPE;
    emps4 e_list_4 := e_list_4();
    idx PLS_INTEGER := 1;

BEGIN

    FOR j IN 100..110 LOOP 
    emps4.EXTEND;
    SELECT first_name INTO emps4(idx) FROM employees WHERE employee_id = j;
    idx := idx + 1;
    END LOOP;
    
    emps4.DELETE(3);
    
    FOR i IN 1..emps4.count() LOOP
        IF emps4.EXISTS(i) THEN
            dbms_output.put_line(emps4(i));
        END IF;
    END LOOP;
    
END;


















