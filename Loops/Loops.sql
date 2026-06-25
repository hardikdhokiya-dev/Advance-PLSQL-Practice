SET SERVEROUTPUT ON;

----------------------------------- Basic Loop Just Like Do While------------------------------------------

DECLARE
    V_COUNT NUMBER(2) := 1;
    
BEGIN
    LOOP
    dbms_output.put_line('My counter is : ' || V_COUNT);
    V_COUNT := V_COUNT + 1;
        IF V_COUNT = 10 THEN  dbms_output.put_line('I Reached the maximum value : ' ||V_COUNT);
        EXIT;
        END IF;
    END LOOP;

END;

/***************************** Example 2 ******************************/

DECLARE
    V_COUNT NUMBER(2) := 1;
    
BEGIN
    LOOP
    dbms_output.put_line('My counter is : ' || V_COUNT);
    V_COUNT := V_COUNT + 1;
    EXIT WHEN V_COUNT = 10;
    END LOOP;

END;

----------------------------------- While Loop------------------------------------------
/***************************** Example 1 ******************************/

DECLARE
    V_COUNT NUMBER(2) := 1;
    
BEGIN
    WHILE V_COUNT <=10 LOOP
    dbms_output.put_line('My counter is : ' || V_COUNT);
    V_COUNT := V_COUNT + 1;
    --EXIT WHEN V_COUNT = 3;
    END LOOP;

END;

----------------------------------- FOR Loop------------------------------------------

BEGIN
    FOR i IN 1..3 LOOP
    dbms_output.put_line('My counter is : ' || i);
    END LOOP;
END;

--This will be executed once
BEGIN
    FOR i IN 3..3 LOOP
    dbms_output.put_line('My counter is : ' || i);
    END LOOP;
END;


BEGIN
    FOR i IN REVERSE 1..3 LOOP
    dbms_output.put_line('My counter is : ' || i);
    END LOOP;
END;

----------------------------------- Nested Loop------------------------------------------

DECLARE
    V_INNER NUMBER;
    
BEGIN
    
    FOR V_OUTER IN 1..5 LOOP
    dbms_output.put_line('My Outer value is : ' || V_OUTER);
        
        V_INNER :=1;
        LOOP 
            V_INNER := V_INNER + 1;
            dbms_output.put_line('  My Inner value is : ' || V_INNER);
            EXIT WHEN V_OUTER * V_INNER >= 15;
        END LOOP;

    END LOOP;

END;


-- USING LABLES FOR NESTED LOOPS

DECLARE
    V_INNER NUMBER;
    
BEGIN
    <<OUTER_LOOP>>
    FOR V_OUTER IN 1..5 LOOP
    dbms_output.put_line('My Outer value is : ' || V_OUTER);
        
        <<INNER_LOOP>>
        V_INNER :=1;
        LOOP 
            V_INNER := V_INNER + 1;
            dbms_output.put_line('  My Inner value is : ' || V_INNER);
            EXIT OUTER_LOOP WHEN V_OUTER * V_INNER >= 16;
            EXIT WHEN V_OUTER * V_INNER >= 15;
        END LOOP INNER_LOOP;

    END LOOP OUTER_LOOP;

END;


----------------------------------- CONTINUE STATEMENT ------------------------------------------

DECLARE
    V_INNER NUMBER := 1;
    
BEGIN

    FOR V_OUTER IN 1..10 LOOP
    dbms_output.put_line('My Outer value is : ' || V_OUTER);
    
        V_INNER :=1;
        WHILE V_INNER * V_OUTER < 15 LOOP
        V_INNER := V_INNER + 1;
        CONTINUE WHEN MOD (V_INNER * V_OUTER,3) = 0;
        dbms_output.put_line(' My Inner value is : ' || V_INNER);
        END LOOP;

    END LOOP;
END;

-- USING LABLES FOR NESTED LOOPS


DECLARE
    V_INNER NUMBER := 1;
    
BEGIN
    
    <<OUTER_LOOP>>
    FOR V_OUTER IN 1..10 LOOP
    dbms_output.put_line('My Outer value is : ' || V_OUTER);
        
        <<INNER_LOOP>>
        V_INNER :=1;
        WHILE V_INNER * V_OUTER < 15 LOOP
        V_INNER := V_INNER + 1;
        CONTINUE OUTER_LOOP WHEN V_INNER = 5 ;
        dbms_output.put_line(' My Inner value is : ' || V_INNER);
        END LOOP INNER_LOOP;

    END LOOP OUTER_LOOP;
END;



----------------------------------- GO TO STATEMENT ------------------------------------------

/******** Finding Prime Numbers Using GOTO Statement ********/

DECLARE
    V_SEARCHED_NUMBER NUMBER := 2390;
    V_IS_BOOLEAN BOOLEAN := true;

BEGIN
    FOR X IN 2..V_SEARCHED_NUMBER-1 LOOP
        IF MOD(V_SEARCHED_NUMBER,X) = 0 THEN dbms_output.put_line(V_SEARCHED_NUMBER || ' Is Not Prime Number');
        V_IS_BOOLEAN := FALSE;
        GOTO end_point;
        END IF;
    END LOOP;

    IF V_IS_BOOLEAN THEN dbms_output.put_line(V_SEARCHED_NUMBER || ' Is Prime Number');
    END IF;

    <<end_point>>
    dbms_output.put_line('Check Complete..');

END;


















