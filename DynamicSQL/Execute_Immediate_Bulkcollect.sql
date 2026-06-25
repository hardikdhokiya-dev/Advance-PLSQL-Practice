set serveroutput on;


/*
    BULK COLLECT automatically initializes nested tables and fills them with data. Even if no rows are returned, the collection is initialized as an empty collection (COUNT = 0), not NULL.
    BULK COLLECT fills everything — no EXTEND, no EXISTS.
    
    BULK COLLECT INTO names;
    1. Initialize collection
    2. Allocate required size
    3. Populate all elements
    
    Situation	                    Best loop
    BULK COLLECT (dense)	        1..COUNT ✔
    Associative array (sparse)	    FIRST/NEXT ✔
    Mixed/unknown	                FIRST/NEXT ✔ safest
    
    For BULK COLLECT, associative arrays must use numeric index (PLS_INTEGER)
    BULK COLLECT + associative array = numeric index only, dense result.
    
*/
declare
    type t_name is table of varchar2(20);
    names t_name;
    
begin
    
    execute immediate 'select distinct first_name from employees' bulk collect into names ;
    
    for i in 1..names.count() loop
    
        dbms_output.put_line (names(i));
    
    end loop;


end;


------------------------------------------------------------------------------------------------------------------------------
/* place holder after the returning clause inside the dynamic sql text is not considered as bind variables. They are returned into the variable we defined at the into clause

Step 1: SQL parsed
Step 2: UPDATE executed
Step 3: first_name values collected
Step 4: Returned into "names" collection

*/

declare
    type t_name is table of varchar2(20);
    names t_name;
    
begin
    
    execute immediate 'update employees_copy set salary = salary + 1000 where department_id = 30 returning first_name into :c' 
    returning bulk collect into names ;
    
    for i in 1..names.count() loop
    
        dbms_output.put_line (names(i));
    
    end loop;


end;


alter table employees_copy disable all triggers;


