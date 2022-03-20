 SET SCHEMA FN71981@
 
 --- FIRST PROCEDURE FOR INDICATING THE SALARY OF AN EMPLOYEE
 
 SELECT * FROM FLIGHTS@
 SELECT * FROM DESTINATIONS@
 SELECT * FROM AIRLINES@
 
 CALL FN71981.CNT_FLIGHTS(?)@
 
 CREATE OR REPLACE PROCEDURE CNT_FLIGHTS(OUT v_cnt_flights INTEGER)
 BEGIN
    DECLARE ROW ANCHOR ROW FLIGHTS;
    DECLARE end_table INT DEFAULT 0; 
     
    DECLARE not_found CONDITION FOR SQLSTATE '02000';
    
    DECLARE C1 CURSOR FOR SELECT * FROM FLIGHTS;
    
    DECLARE CONTINUE HANDLER FOR not_found
    SET end_table = 1;
             
    OPEN C1;
    SET v_cnt_flights = 0;
    FETCH C1 INTO ROW;
    
    WHILE end_table = 0 DO
       SET v_cnt_flights = v_cnt_flights + 1;
       FETCH C1 INTO ROW;
    END WHILE;
    CLOSE C1;
 END@
 
 
 
 
 CALL FN71981.MOST_COMMON_AIRLINE(?)@
 
 
 CREATE PROCEDURE SELECT_SALARY(IN p_empno ANCHOR EMP.EMPNO, OUT p_salary ANCHOR EMP.SALARY)
 SPECIFIC select_salary
 BEGIN
    DECLARE out_of_range CONDITION FOR SQLSTATE '22001';
    DECLARE CONTINUE HANDLER FOR out_of_range
    SET p_empno ='000010';
    
    SELECT SALARY INTO p_salary
    FROM EMP
    WHERE EMPNO = p_empno;
 END@
 
 -- SECOND PROCEDURE FOR INCREASING SALARY AN  EMPLOYE FROM THE PREVIOUS PROCEDURE
 
 CREATE OR REPLACE PROCEDURE HW4_INCREASE_SALARY(IN p_empno ANCHOR EMP.EMPNO)
 SPECIFIC increase_salary
 BEGIN

   DECLARE current_salary ANCHOR EMP.SALARY DEFAULT 0.0;
   DECLARE new_salary ANCHOR EMP.SALARY DEFAULT 0.0;
  
   CALL FN71981.SELECT_SALARY(p_empno, current_salary);
          
    SET new_salary = current_salary + current_salary * 0.1;
    INSERT INTO HW4_RESULT_TABLE(MSG) VALUES('BEFORE INCREASE: ' || current_salary 
                                          || '  AFTER INCREASE:  ' || new_salary 
                                          || '  for emp: '        || p_empno);   
   UPDATE EMP
     SET SALARY = new_salary
     WHERE EMPNO = p_empno;
 END@
 
 ----- THIRD PROCEDURE FOR DECREASING SALARY
 
 CREATE OR REPLACE PROCEDURE HW4_DECREASE_SALARY(IN p_empno ANCHOR EMP.EMPNO)
 SPECIFIC decrease_salary
 BEGIN
   DECLARE current_salary ANCHOR EMP.SALARY DEFAULT 0.0;
   DECLARE new_salary ANCHOR EMP.SALARY DEFAULT 0.0;
    CALL FN71981.SELECT_SALARY(p_empno, current_salary);
    
    SET new_salary = current_salary - current_salary * 0.1;
    INSERT INTO HW4_RESULT_TABLE(MSG) VALUES('BEFORE DECREASE:  ' || current_salary 
                                           ||' AFTER DECREASE:  ' || new_salary
                                           || '  for emp: ' || p_empno);  
   UPDATE EMP
     SET SALARY = new_salary
     WHERE EMPNO = p_empno;
  END@
 
 ----- CALLING PROCEDURES
 CALL FN71981.SELECT_SALARY('000010', ?)@  -- MUST BE CALL FROM THE 'STORED PROCEDURES' FOLDER
 
 CALL FN71981.HW4_INCREASE_SALARY('000010')@
 
 CALL FN71981.HW4_DECREASE_SALARY('000010')@
 
 ------------------------
 drop table hw4_result_table@
 
 CREATE TABLE HW4_RESULT_TABLE(
    MSG VARCHAR(500)
 )@
 
 SELECT * FROM HW4_RESULT_TABLE@
 
 SELECT * FROM EMP@
 
 
 