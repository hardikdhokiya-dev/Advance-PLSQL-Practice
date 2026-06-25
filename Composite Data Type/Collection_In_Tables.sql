SET SERVEROUTPUT ON;

-- USING VARRAYS

CREATE OR REPLACE TYPE phone_number AS OBJECT (p_type VARCHAR(10), p_number NUMBER);

CREATE OR REPLACE TYPE phone_numbers IS VARRAY(3) OF phone_number;


CREATE TABLE emp_with_phones (  emp_id NUMBER,
                                first_name VARCHAR2(20),
                                last_name VARCHAR2(20),
                                p_numbers phone_numbers);
                            
SELECT * FROM emp_with_phones;    

INSERT INTO emp_with_phones VALUES (1, 'ALEXAN', 'DOBY', phone_numbers (phone_number ('work', 1593579854), phone_number ('cell', 1593570000), phone_number ('home', 198079004)));

INSERT INTO emp_with_phones VALUES (1, 'BOB', 'PANTHER', phone_numbers (phone_number ('work', 000111000), phone_number ('cell', 222555888)));

-- Key concept: TABLE() -- operator enable us to use the collections just like a table
-- TABLE(e.p_numbers) unnests the VARRAY
-- Each phone number becomes its own row
-- Alias p represents one phone_number object

SELECT e.first_name, e.last_name , p.p_type, p.p_number FROM emp_with_phones e, table (e.p_numbers) p;

----------------------------------------------------------------------------------------------------------------------------------------

-- USING NESTED TABLES



CREATE OR REPLACE TYPE phone_number AS OBJECT (p_type VARCHAR(10), p_number NUMBER);

CREATE OR REPLACE TYPE n_phone_numbers IS TABLE OF phone_number;


CREATE TABLE emp_with_phones2 (  emp_id NUMBER,
                                first_name VARCHAR2(20),
                                last_name VARCHAR2(20),
                                p_numbers n_phone_numbers)
                                NESTED TABLE p_numbers STORE AS phone_numbers_table;
                            
SELECT * FROM emp_with_phones2;    

INSERT INTO emp_with_phones2 VALUES (1, 'ALEXAN', 'DOBY', n_phone_numbers (phone_number ('work', 1593579854), phone_number ('cell', 1593570000), phone_number ('home', 198079004)));

INSERT INTO emp_with_phones2 VALUES (1, 'BOB', 'PANTHER', n_phone_numbers (phone_number ('work', 000111000), phone_number ('cell', 222555888)));

INSERT INTO emp_with_phones2 VALUES (10, 'BOBBY', 'PANTHER123', n_phone_numbers (phone_number ('work', 000111000)));


SELECT e.first_name, e.last_name , p.p_type, p.p_number FROM emp_with_phones2 e, table (e.p_numbers) p;

----------------------------------------------------------------------------------------------------------------------------------------

-- UPDATE VALUES IN THE NESTED TABLE

UPDATE emp_with_phones2 SET p_numbers = n_phone_numbers (phone_number ('work1', 1593579854), phone_number ('cell1', 1593570000), phone_number ('home1', 198079004), phone_number ('home12', 198079)) WHERE emp_id = 1 ;

----------------------------------------------------------------------------------------------------------------------------------------

/**** Adding a New Value into a Nested Inside of a Table ****/

DECLARE 
    p_num n_phone_numbers;
  

BEGIN
    SELECT p_numbers INTO p_num FROM emp_with_phones2 WHERE emp_id = 10 ;
    p_num.EXTEND;
    p_num(5) := phone_number('FAX',9999999);
    
    UPDATE emp_with_phones2 SET p_numbers = p_num WHERE  emp_id  = 10;
    

END;



















