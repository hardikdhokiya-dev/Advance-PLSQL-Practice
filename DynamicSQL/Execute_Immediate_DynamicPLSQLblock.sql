set serveroutput on;

/*
    dynamic plsql block can reach to global objects like functions, prodecures, the elements of the package spec etc..
    directly we can not pass the local variable to the dynamic plsql block for that
    we need to use the bind variables place holder in the dynamic plsql and then send it with using command
    we should handle the exeption outside the dynamic plsql block
    
    q'[...]' --> It is an alternative quoting mechanism in PL/SQL used to define string literals without escaping quotes.

*/

BEGIN
    FOR r_emp in (SELECT * FROM employees) LOOP
        dbms_output.put_line(r_emp.first_name||' '||r_emp.last_name);
    END LOOP;
END;
/



DECLARE
    v_dynamic_text varchar2(1000);
BEGIN
    v_dynamic_text := q'[BEGIN
                            FOR r_emp in (SELECT * FROM employees) LOOP
                            dbms_output.put_line(r_emp.first_name||' '||r_emp.last_name);
                            END LOOP;
                        END;]';
    EXECUTE IMMEDIATE v_dynamic_text;
END;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- we can not use the local variable inside the dynamic plsql block , error received

DECLARE
    v_dynamic_text VARCHAR2(1000);
    v_department_id PLS_INTEGER := 30;
BEGIN
    v_dynamic_text := q'[BEGIN
                            FOR r_emp in (SELECT * FROM employees WHERE department_id = v_department_id) LOOP
                            dbms_output.put_line(r_emp.first_name||' '||r_emp.last_name);
                            END LOOP;
                        END;]';
    EXECUTE IMMEDIATE v_dynamic_text;
END;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- defining under the dynamic plsql block


DECLARE
    v_dynamic_text VARCHAR2(1000);
    --v_department_id pls_integer := 30;
BEGIN
    v_dynamic_text := q'[DECLARE
                            v_department_id pls_integer := 30;
                        BEGIN
                            FOR r_emp in (SELECT * FROM employees WHERE department_id = v_department_id) LOOP
                            dbms_output.put_line(r_emp.first_name||' '||r_emp.last_name);
                            END LOOP;
                        END;]';
    EXECUTE IMMEDIATE v_dynamic_text;
END;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- global elements can be used inside the dynamic plsql

CREATE OR REPLACE PACKAGE pkg_temp AS
v_department_id_pkg PLS_INTEGER := 50;
END;



DECLARE
    v_dynamic_text VARCHAR2(1000);
    --v_department_id pls_integer := 30;
BEGIN
    v_dynamic_text := q'[BEGIN
                            FOR r_emp in (SELECT * FROM employees WHERE department_id = pkg_temp.v_department_id_pkg) LOOP
                            dbms_output.put_line(r_emp.first_name||' '||r_emp.last_name);
                            END LOOP;
                        END;]';
    EXECUTE IMMEDIATE v_dynamic_text;
END;



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- LOCAL VARIABLE USAGE WITH USING CLASUE


DECLARE
    v_dynamic_text VARCHAR2(1000);
    v_department_id PLS_INTEGER := 30;
BEGIN
    v_dynamic_text := q'[BEGIN
                        FOR r_emp in (SELECT * FROM employees WHERE department_id = :1) LOOP
                            dbms_output.put_line(r_emp.first_name||' '||r_emp.last_name);
                            END LOOP;
                        END;]';
    EXECUTE IMMEDIATE v_dynamic_text USING v_department_id;
END;



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- IN OUT USAGE


DECLARE
    v_dynamic_text VARCHAR2(1000);
    v_department_id PLS_INTEGER := 30;
    v_max_salary PLS_INTEGER := 0;
BEGIN
    v_dynamic_text := q'[BEGIN
                            FOR r_emp in (SELECT * FROM employees WHERE department_id = :1) LOOP
                                dbms_output.put_line(r_emp.first_name||' '||r_emp.last_name);
                                if r_emp.salary > :sal then
                                    :sal := r_emp.salary;
                                end if;
                            END LOOP;
                        END;]';
    EXECUTE IMMEDIATE v_dynamic_text USING v_department_id, IN OUT v_max_salary;
    dbms_output.put_line('The maximum salary of this department is : '||v_max_salary);
END;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- EXCEPTION HANDLING IN OUTSIDE BLOCK

DECLARE
    v_dynamic_text VARCHAR2(1000);
    v_department_id PLS_INTEGER := 30;
    v_max_salary PLS_INTEGER := 0;
BEGIN
    v_dynamic_text := q'[BEGIN
                            FOR r_emp in (SELECT * FROM employeese WHERE department_id = :1) LOOP
                                dbms_output.put_line(r_emp.first_name||' '||r_emp.last_name);
                                if r_emp.salary > :sal then
                                    :sal := r_emp.salary;
                                end if;
                            END LOOP;
                        END;]';
    EXECUTE IMMEDIATE v_dynamic_text USING v_department_id, IN OUT v_max_salary;
    dbms_output.put_line('The maximum salary of this department is : '||v_max_salary);
EXCEPTION
    WHEN OTHERS THEN
    dbms_output.put_line('The error is : '||sqlerrm);
END;



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- WE CAN NOT HANDLE THE EXCEPTION INSIDE THE DYNAMIC PLSQL BLOCK, OTHERWISE IT GIVES AN ERROR

DECLARE
    v_dynamic_text VARCHAR2(1000);
    v_department_id PLS_INTEGER := 30;
    v_max_salary PLS_INTEGER := 0;
BEGIN
    v_dynamic_text := q'[BEGIN
    FOR r_emp in (SELECT * FROM employeese WHERE department_id = :1) LOOP
        dbms_output.put_line(r_emp.first_name||' '||r_emp.last_name);
        if r_emp.salary > :sal then
            :sal := r_emp.salary;
        end if;
    END LOOP;
    EXCEPTION
    WHEN OTHERS THEN
    dbms_output.put_line('The error is : '||SQLERRM);
    END;]';
    EXECUTE IMMEDIATE v_dynamic_text USING v_department_id, IN OUT v_max_salary;
    dbms_output.put_line('The maximum salary of this department is : '||v_max_salary);
END;









DROP PACKAGE pkg_temp;