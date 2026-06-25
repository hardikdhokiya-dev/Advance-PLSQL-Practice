create or replace package emp as

    v_sal_increase_rate number := .20;
    
    procedure sal_inc ;
    
    function avg_sal (v_dept_id in number) return number;
    
    
    










end emp;