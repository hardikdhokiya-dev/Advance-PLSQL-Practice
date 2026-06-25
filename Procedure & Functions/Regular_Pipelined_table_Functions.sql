--select * from user_objects;

--select * from user_source;

set serveroutput on;

/******************************************** Regular table function *********************************************/


create or replace type t_days as object (v_date date , v_day_number number); -- created a object similar to record becuase we can not create the record at a schema level

create type t_days_tab is table of t_days;  -- created a nested table (list/array of t_days objects)


-- create function 

create or replace function f_get_days (v_start_date in date, v_day_number in number) return t_days_tab is 

v_days t_days_tab := t_days_tab();

begin
    
    for i in 1..v_day_number loop
        
        v_days.extend();
    
        v_days(i) := t_days (v_start_date + i, to_number(to_char(v_start_date + i, 'DDD'))); 
    
    end loop;
    
    return v_days;

end;


----------------- querying from the regular table function

select * from (f_get_days(sysdate, 10));



/******************************************** Pipeline function *********************************************/
-- pipeline function returns values only when we want to get it and partially, so tool gets the data by a specific numbers of rows and then display to us and if we scroll down it gets the next N rows

create or replace type t_obj_days as object (t_date date, t_daynum number);

create or replace type t_table_type is table of t_obj_days;

create or replace function get_days_piped (v_date in date, v_days in number default 1 ) return t_table_type pipelined is 


begin
 
    for j in 1..v_days loop
    
        pipe row (t_obj_days(v_date + j, to_number(to_char(v_date + j, 'DDD'))));
    
    end loop;
    
    return;  -- we don't return anything in pipelined function becuase it by default return one by one row

end;


----------------- querying from the pipelined table function

select * from (get_days_piped(sysdate, 10));

select * from (get_days_piped(sysdate)); 



























