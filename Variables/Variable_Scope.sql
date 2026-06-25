SET SERVEROUTPUT ON;

/*  Inner block can access the outblock varibales.
    However, outerblock can not access the variables from the inner block
    */
    
DECLARE

    V_TEXTOUTER VARCHAR2(50) := 'This is outer block varibale';

BEGIN

    DECLARE 
        V_TEXTINNER VARCHAR2(50) := 'This is Inner block varibale';
    BEGIN
    
        dbms_output.put_line('Accessed through inner block ' || V_TEXTINNER);
        dbms_output.put_line('Accessed through inner block ' || V_TEXTOUTER);
        
    END;

    -- dbms_output.put_line(V_TEXTINNER); Gives an error, trying to access innerblock variable from outerblock
    dbms_output.put_line(V_TEXTOUTER);

END;






------------------------------------------------------------------------------------------------------------------------------------------------


 /* We can create same name varibale in different nested blocks, but we cannot create same name varibale in the same block.*/
 
DECLARE

    V_TEXT VARCHAR2 (30) := 'Outer block variable';

BEGIN

    DECLARE
        V_TEXT VARCHAR2 (30) := 'Inner block variable';
    
    BEGIN
        dbms_output.put_line(V_TEXT);
        dbms_output.put_line(V_TEXT);
    
    END;

    dbms_output.put_line(V_TEXT);
    
END;

------------------------------------------------------------------------------------------------------------------------------------------------
--If we want to call outer block variable, then we need to use the BEGIN KEYWORD with some name before the DECLARE and END keyword at the end

BEGIN <<outer>>

DECLARE

    V_TEXT VARCHAR2 (30) := 'Outer block variable';

BEGIN

    DECLARE
        V_TEXT VARCHAR2 (30) := 'Inner block variable';
    
    BEGIN
        dbms_output.put_line(V_TEXT);
        dbms_output.put_line(outer.V_TEXT);
    
    END;

    dbms_output.put_line(V_TEXT);
    
END;
END outer;


















 
 
