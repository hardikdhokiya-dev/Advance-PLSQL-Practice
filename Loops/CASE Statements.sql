SET SERVEROUTPUT ON;

/************************ Example 1 *************************/

-- HERE WE COMPARE ONLY ONE VALUE OF SAME VARIABLE

DECLARE 
    V_JOB_CODE VARCHAR(10) := 'SAM';
    V_SAL_INCREASE NUMBER;
    
BEGIN
    V_SAL_INCREASE := CASE V_JOB_CODE
        WHEN 'SAM' THEN 0.2
        WHEN 'DAM' THEN 0.6
        ELSE 0
        END;
        
    dbms_output.put_line('Salary increase is : ' ||V_SAL_INCREASE);

END;


/************************ Example 2 *************************/
-- HERE WE COMPARE MULTIPLE VALUES OF DIFFERENT VARIABLE
DECLARE 
    V_JOB_CODE VARCHAR(10) := 'KEM';
    V_SAL_INCREASE NUMBER;
    V_DEPT VARCHAR2(10) := 'ITT';
    
BEGIN
    V_SAL_INCREASE := CASE 
        WHEN V_JOB_CODE = 'SAM' THEN 0.2
        WHEN V_JOB_CODE IN ('DAM', 'REM') THEN 0.6
        WHEN V_JOB_CODE = 'KEM' AND V_DEPT <> 'IT' THEN 0.8
        ELSE 0
        END;
        
    dbms_output.put_line('Salary increase is : ' ||V_SAL_INCREASE);

END;


/********************* CASE Statements **********************/
DECLARE
  v_job_code        VARCHAR2(10) := 'IT_PROG';
  v_department      VARCHAR2(10) := 'IT';
  v_salary_increase NUMBER;
BEGIN
  CASE
    WHEN v_job_code = 'SA_MAN' THEN
      v_salary_increase := 0.2;
      dbms_output.put_line('The salary increase for a Sales Manager is: '|| v_salary_increase);
    WHEN v_department = 'IT' AND v_job_code = 'IT_PROG' THEN
      v_salary_increase := 0.2;
      dbms_output.put_line('The salary increase for a Sales Manager is: '|| v_salary_increase);
    ELSE
      v_salary_increase := 0;
      dbms_output.put_line('The salary increase for this job code is: '|| v_salary_increase);
  END CASE;
END;
/************************************************************/
