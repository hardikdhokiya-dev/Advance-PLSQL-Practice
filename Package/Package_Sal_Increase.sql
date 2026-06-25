CREATE OR REPLACE PACKAGE PKG AS

    -- We will use the associative array with the subprograms and send - get the variables created with that type
    -- PLS_INTEGER is fatser than number type
    
    TYPE ass_arr_emp_table_type IS TABLE OF employees%ROWTYPE INDEX BY PLS_INTEGER;
    --------------------------------------------------------------------------------------------------------------------------------------------  
    -- variables 
    
    v_sal_increase  number := 1000;
    v_min_sal number := 5000;
 
 
    --------------------------------------------------------------------------------------------------------------------------------------------   
    /*
        functions to return all the employees from the employees table,
        since we already defined the type in our package, we can send associative array of that type to other program easily
    */
    
    --function get_emp return ass_arr_emp_table_type;
    
   -------------------------------------------------------------------------------------------------------------------------------------------- 
    
    /*
        functions to eliminate the employees whose salary is greater than the min sal standard
        It will delete those employees from the associative array because their sal will not be increased
    */
    
    --function emp_sal_to_be_increse return ass_arr_emp_table_type;

    --------------------------------------------------------------------------------------------------------------------------------------------
    /*
        Procedure to increase the salary using other subprograms
    */
    
    procedure increase_low_salaries;
    
    --------------------------------------------------------------------------------------------------------------------------------------------
    /*
        function to check the salary still lower according to standard, it it is then it will rounded up salary to match the standard
        This function will be called from the procedure, it will return the record of the employee table type
    */
    
    --function arrange_for_min_sal (v_emp in out employees%rowtype) return employees%rowtype;


END PKG;