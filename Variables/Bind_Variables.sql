SET SERVEROUTPUT ON;

SET AUTOPRINT ON;

VARIABLE V_BIND1 VARCHAR2(30);
VARIABLE V_BIND2 NUMBER;  -- WE CAN NOT ASSIGN PRECISION AND SCALE FOR NUMBERS



DECLARE 
    V_PLSQL_VARIABLE VARCHAR2(30);

BEGIN
    
    :V_BIND1 := 'This is Bind Variable';
    :V_BIND2 := 50;
    V_PLSQL_VARIABLE := :V_BIND1;
    
    dbms_output.put_line(:V_BIND1);
    dbms_output.put_line(:V_BIND2);
    dbms_output.put_line('Printed from PLSQL variable ' || V_PLSQL_VARIABLE);

END;


PRINT V_BIND1;
