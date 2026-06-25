SET SERVEROUTPUT ON;

DESC employees;

DECLARE

    V_NUM1 employees.Job_id%TYPE;
    V_NUM2 V_NUM1%TYPE;
    V_NUM3 employees.Job_id%TYPE;
    
    
    
BEGIN
    --V_Num1 := 'Datatype is copied form the referenced column and assigne to the declared variable';
    V_NUM1 := 'Datatype';
    V_NUM2 := 'Copied';
    V_NUM3 := NULL;
    dbms_output.put_line(V_NUM1);
    dbms_output.put_line(V_NUM2);
    dbms_output.put_line(V_NUM3 || 'Null valued not copied');

END;