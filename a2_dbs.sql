SET SERVEROUTPUT ON 

---------------------------------------------------------------------------------------------------------------------------
--                                                 QUESTION 1
---------------------------------------------------------------------------------------------------------------------------                                       
-- Creating a Table
CREATE TABLE student09 (
    s_id NUMBER(3) PRIMARY KEY,
    marks NUMBER(3) NOT NULL,
    grade VARCHAR2(2)  );
                     
-- Inserting the data
INSERT ALL
    INTO student09 ( s_id, marks) values (1,80)
    INTO student09 ( s_id, marks) values (2,90)
    INTO student09 ( s_id, marks) values (3,70)
    INTO student09 ( s_id, marks) values (4,67)
    INTO student09 ( s_id, marks) values (5, 79)
    INTO student09 ( s_id, marks) values (6,21)
    INTO student09 ( s_id, marks) values (7, 75)
    INTO student09 ( s_id, marks) values (8,35)
    INTO student09 ( s_id, marks) values (9, 59)
    INTO student09 ( s_id, marks) values (10,71)
SELECT * FROM dual;
                                            
-- Working on the procedure
CREATE OR REPLACE PROCEDURE update_display 
AS
    p_sid student09.s_id%type;
    p_mk student09.marks%type;
    p_gd student09.grade%type;
    
    CURSOR get_values IS
        SELECT s_id, marks
        FROM student09;
     
    CURSOR display_all IS
        SELECT s_id, marks, grade
        FROM student09;   
BEGIN
    OPEN get_values;
    LOOP
        FETCH get_values INTO p_sid, p_mk;
            EXIT WHEN get_values%notfound;  
            
            IF p_mk >= 80 THEN
                p_gd := 'A';
            ELSIF p_mk >= 75 AND p_mk <=79 THEN
                p_gd := 'B+'; 
            ELSIF p_mk >= 70 AND p_mk <=74 THEN
                p_gd := 'B'; 
            ELSIF p_mk >= 60 AND p_mk <=69 THEN
                p_gd := 'C'; 
            ELSIF p_mk >= 50 AND p_mk <=59 THEN
                p_gd := 'D'; 
            ELSE
                p_gd := 'F'; 
            END IF;

        UPDATE student09 
        SET grade = p_gd
        WHERE s_id = p_sid;
    
    END LOOP;
    CLOSE get_values;
    
    FOR item IN display_all
        LOOP
        DBMS_OUTPUT.PUT_LINE ('SID = ' || item.s_id || ' MARKS = ' || item.marks || ' GRADE = ' || item.grade);
        END LOOP;
    IF display_all%ISOPEN THEN
    		CLOSE display_all;
    END IF;
END update_display;
/
                                     PAUSE Press enter for Question One to display
BEGIN
  update_display();
END;
/

---------------------------------------------------------------------------------------------------------------------------
--                                                 QUESTION 2
--------------------------------------------------------------------------------------------------------------------------- 

CREATE OR REPLACE PROCEDURE upmarks09
AS
    p_sid student09.s_id%type;
    p_mk student09.marks%type;
      
    CURSOR get_values IS
        SELECT s_id, marks
        FROM student09;
     
    CURSOR display_all IS
        SELECT s_id, marks, grade
        FROM student09;   
BEGIN
    OPEN get_values;
    LOOP
        FETCH get_values INTO p_sid, p_mk;
            EXIT WHEN get_values%notfound;  
            
            p_mk := round(p_mk + (p_mk * 11.5) / 100);
            
            IF  p_mk > 100 THEN
                p_mk := 100;
            END IF;

        UPDATE student09 
        SET marks = p_mk
        WHERE s_id = p_sid;
    
    END LOOP;
    CLOSE get_values;
    
    FOR item IN display_all
        LOOP
        DBMS_OUTPUT.PUT_LINE ('SID = ' || item.s_id || ' UPDATED MARKS = ' || item.marks || ' GRADE = ' || item.grade);
        END LOOP;
    IF display_all%ISOPEN THEN
    		CLOSE display_all;
    END IF;
END;
/
                        PAUSE Press enter for Question two to display
                        
BEGIN
  upmarks09();
END;
/

---------------------------------------------------------------------------------------------------------------------------
--                                                 QUESTION 3
--------------------------------------------------------------------------------------------------------------------------- 
                        PAUSE Press enter for Question three to display

DECLARE
  smallXX 	NUMBER := 9;
  largeXX 	NUMBER := 7;
  temp 	NUMBER;
BEGIN
  IF smallXX > largeXX
  then temp := smallXX;
       smallXX := largeXX;            
       largeXX := temp;  
  END IF;
  DBMS_OUTPUT.PUT_LINE ('smallXX = : ' || smallXX);
  DBMS_OUTPUT.PUT_LINE ('largeXX = : ' || largeXX);
END;

/
---------------------------------------------------------------------------------------------------------------------------
--                                                 QUESTION 4
--------------------------------------------------------------------------------------------------------------------------- 

-- Creating the Table
CREATE TABLE EMP09
    AS (SELECT * FROM employees);

-- Inserting the bonus column
ALTER TABLE EMP09
    ADD bonus NUMBER(8,2);

-- Working on the procedure
CREATE OR REPLACE PROCEDURE Cal_TDS
AS
    p_e emp09.employee_id%type;
    p_l emp09.last_name%type;
    p_s emp09.bonus%type;
    p_b emp09.bonus%type;
    
    CURSOR get_values IS
        SELECT 
            e.employee_id, 
            e.last_name, 
            SUM(ol.price * ol.qty)
        FROM emp09 e
        INNER JOIN customers c ON e.employee_id = c.sales_rep
        INNER JOIN orders o ON c.cust_no = o.cust_no
        INNER JOIN orderlines ol ON o.order_no = ol.order_no
        GROUP BY  e.employee_id, e.last_name;
     
    CURSOR display_all IS
        SELECT 
            employee_id, 
            last_name, 
            salary,
            bonus
        FROM emp09 
        WHERE job_id = 'SA_REP' AND bonus > 0;        
BEGIN
    OPEN get_values;
    LOOP
        FETCH get_values INTO p_e, p_l, p_s;
            EXIT WHEN get_values%notfound;  
                           
            IF  p_s > 150000 THEN
                p_b := round((p_s * 4) / 100);
            ELSIF p_s >= 50000 AND p_s <= 150000 THEN
                p_b := round((p_s * 2.5) / 100);
            ELSE 
                p_b := round((p_s * 1) / 100);
            END IF;

        UPDATE emp09 
        SET bonus = p_b
        WHERE employee_id = p_e;    
    END LOOP;
    CLOSE get_values;
    
     DBMS_OUTPUT.PUT_LINE ('ID   LAST_NAME    SALARY      BONUS
     ');
    FOR item IN display_all
        LOOP
        DBMS_OUTPUT.PUT_LINE (item.employee_id || '    ' || item.last_name || '      ' || item.salary || '     ' || item.bonus);
        END LOOP;
    IF display_all%ISOPEN THEN
    		CLOSE display_all;
    END IF;
END;
/
                        PAUSE Press enter for Question four to display                
BEGIN
  Cal_TDS();
END;
/
---------------------------------------------------------------------------------------------------------------------------
--                                                 QUESTION 5
--------------------------------------------------------------------------------------------------------------------------- 
--     Parth Gulati       