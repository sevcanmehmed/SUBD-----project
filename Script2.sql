CREATE PROCEDURE FN71981.Sample1 (OUT Parm1 CHAR(10))
LANGUAGE SQL
SET Parm1 = 'value1'@


CREATE PROCEDURE FN71981.SAMPLE2 (OUT Parm1 CHAR(10), OUT Parm2 CHAR(10))
LANGUAGE SQL
BEGIN
SET Parm1 = 'value1';
SET Parm2 = 'value2';

END @

CREATE PROCEDURE FN71981.FOO( out day_Of_Year int)
LANGUAGE SQL
P1: BEGIN

DECLARE c_Date DATE;
SET c_Date = CURRENT DATE;
SET day_Of_Year = dayofyear(c_Date);

END P1@

CREATE PROCEDURE FN71981.FOOWEEK( out day_Of_Year int)
LANGUAGE SQL
P1: BEGIN

DECLARE c_Date DATE;
SET c_Date = CURRENT DATE;
SET day_Of_Year = week(c_Date);

END P1@

CALL FN71981.FOOWEEK@

SELECT * FROM DB2INST1.EMP@

CREATE PROCEDURE FN71981.TEST1( IN V_WORKDEPT CHAR(3), OUT V_LASTNAME VARCHAR(15),
     OUT V_BIRTHDATE DATE, OUT V_DAY_YEAR INT, OUT V_DAY_NAME VARCHAR(20))
LANGUAGE SQL
P1: BEGIN

SELECT LASTNAME, BIRTHDATE, DAYOFYEAR(BIRTHDATE), DAYNAME(BIRTHDATE) 
INTO V_LASTNAME, V_BIRTHDATE, V_DAY_YEAR, V_DAY_NAME 
FROM DB2INST1.EMP
WHERE WORKDEPT = V_WORKDEPT
FETCH FIRST 1 ROWS ONLY;

END P1@

CALL FN71981.TEST1('B01', ?, ?, ?, ?)@


CREATE PROCEDURE FN71981.TEST2( IN V_WORKDEPT CHAR(3))
RESULT SETS 1
LANGUAGE SQL

P1: BEGIN

DECLARE C1 CURSOR WITH RETURN FOR
SELECT LASTNAME, BIRTHDATE, DAYOFYEAR(BIRTHDATE), DAYNAME(BIRTHDATE) 
FROM DB2INST1.EMP
WHERE WORKDEPT = V_WORKDEPT
ORDER BY BIRTHDATE;

OPEN C1;
END P1@

SET SCHEMA FN71981@

CREATE TABLE EMP LIKE DB2INST1.EMP@
CREATE TABLE DEPT LIKE DB2INST1.DEPT@


INSERT INTO EMP
SELECT * FROM DB2INST1.EMP@

INSERT INTO DEPT
SELECT * FROM DB2INST1.DEPT@


SELECT * FROM EMP@

CREATE MODULE ZAD1@

DROP TABLE EMP@
DROP TABLE DEPT@

-- PUBLISH
-- ADD

CREATE MODULE MYMOD.FN71981@

-- FIRST   PUBLISH
-- SECOND  ADD

-- DROP MODULE MYMOD -- DELETE MODULE 



CREATE PROCEDURE P_EMP_BONUS(IN V_DEPTNO CHAR(3))
BEGIN
DECLARE V_EMPNO ANCHOR EMP.EMPNO;
DECLARE V_WORKDEPT ANCHOR EMP.WORKDEPT;
DECLARE V_JOB ANCHOR EMP.JOB;
DECLARE V_SALARY ANCHOR EMP.SALARY;
DECLARE V_N_EMP INT;
DECLARE V_CNT INT;

DECLARE C1 CURSOR FOR SELECT EMPNO, WORKDEPT, JOB, SALARY FROM EMP WHERE BONUS IS NULL AND WORKDEPT = V_DEPTNO;

OPEN C1;
SET V_CNT = 0;
SET V_N_EMP = (SELECT COUNT(*) FROM EMP WHERE BONUS IS NULL AND WORKDEPT = V_DEPTNO);

IF V_N_EMP = 0 THEN 
   RETURN;
END IF;
L1:
LOOP
SET V_CNT = V_CNT + 1;
 FETCH C1 INTO V_EMPNO, V_WORKDEPT, V_JOB, V_SALARY;
 INSERT INTO EMP_BONUS VALUES (V_EMPNO, V_WORKDEPT, V_JOB, V_SALARY);
IF V_CNT = V_N_EMP 
THEN RETURN;
END IF;
END LOOP L1;

END@