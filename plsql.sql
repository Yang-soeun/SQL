-- 이걸 설정해야 디버깅용 DBMS_OUTPUT을 사용할 수 있음
SET SERVEROUTPUT ON 
DECLARE 
  emp_rec   emp%ROWTYPE ;
  sum_rec   emp_sum%ROWTYPE ; 

BEGIN 
  SELECT * INTO emp_rec 
  FROM emp
  WHERE empno = 7788 ; 

  DELETE emp
  WHERE empno = 7788 ; 

  UPDATE emp_sum
  SET sum_sal = sum_sal - emp_rec.sal 
  WHERE deptno = emp_rec.deptno ; 

  SELECT * INTO sum_rec
  FROM emp_sum
  WHERE deptno = emp_rec.deptno ; 

  DBMS_OUTPUT.PUT_LINE ( 'SUM Salary : ' || sum_rec.sum_sal ) ; -- 디버깅 용

END ;
/


CREATE OR REPLACE PROCEDURE delete_emp 
( p_empno   NUMBER)  AS
   emp_rec   emp%ROWTYPE ;
   sum_rec   emp_sum%ROWTYPE ; 
BEGIN 
  SELECT * INTO emp_rec 
  FROM emp
  WHERE empno = p_empno ; 

  DELETE emp
  WHERE empno = p_empno ; 

  UPDATE emp_sum
  SET sum_sal = sum_sal - emp_rec.sal 
  WHERE deptno = emp_rec.deptno ; 

  SELECT * INTO sum_rec
  FROM emp_sum
  WHERE deptno = emp_rec.deptno ; 

  DBMS_OUTPUT.PUT_LINE ( 'SUM Salary : ' || sum_rec.sum_sal ) ; 

END ;
/

SET SERVEROUTPUT ON
EXECUTE delete_emp (7788)

-- 변수 선언
SET SERVEROUTPUT ON
DECLARE
  v_hiredate 		DATE ;
  v_deptno 		NUMBER(2) NOT NULL 	DEFAULT 10 ;
  v_location 		VARCHAR2(13) 			:= 'Atlanta';
  c_comm 			CONSTANT NUMBER 		:= 1400 ; 
BEGIN 
  DBMS_OUTPUT.PUT_LINE ( v_hiredate ) ; 
  DBMS_OUTPUT.PUT_LINE ( v_deptno ) ; 
  DBMS_OUTPUT.PUT_LINE ( v_location ) ; 
  DBMS_OUTPUT.PUT_LINE ( c_comm ) ; 
END ; 
/

-- %TYPE
DECLARE
  V_SAL   EMP.SAL%TYPE ; 
BEGIN 
  SELECT SAL INTO V_SAL 
    FROM EMP 
   WHERE DEPTNO = 50 ; 
 
END ; 
/

SET SERVEROUTPUT ON 
BEGIN 
  UPDATE emp 
  SET sal = 4000 
  WHERE empno = 7788 ; 
  DBMS_OUTPUT.PUT_LINE ( SQL%ROWCOUNT || ' rows updated') ; -- 암시적 커서의 속성(SQL%ROWCOUNT), 영향받은 행의 건수를 얻을 수 있음

  DELETE emp 
  WHERE deptno = 10 ; 
  DBMS_OUTPUT.PUT_LINE ( SQL%ROWCOUNT || ' rows deleted') ;
END ;
/

ROLLBACK ;

-- select 문
SET SERVEROUTPUT ON 
DECLARE 
   v_ename	VARCHAR2(10) ;  
   v_sal		emp.sal%TYPE ;
BEGIN 
   SELECT ename, sal INTO v_ename, v_sal 
   FROM emp 
   WHERE empno = 7788 ; 

   DBMS_OUTPUT.PUT_LINE ( v_ename || ' : ' || v_sal ) ; 
END ;
/

SET SERVEROUTPUT ON 
DECLARE 
   v_ename	VARCHAR2(10) ;  
   v_sal		emp.sal%TYPE ;
BEGIN 
   SELECT ename, sal INTO v_ename, v_sal 
   FROM emp 
   WHERE deptno = 10 ; 

   DBMS_OUTPUT.PUT_LINE ( v_ename || ' : ' || v_sal ) ; 
END ;
/

SET SERVEROUTPUT ON 
DECLARE 
   v_ename	VARCHAR2(10) ;  
   v_sal		emp.sal%TYPE ;
BEGIN 
   SELECT ename, sal INTO v_ename, v_sal 
   FROM emp 
   WHERE deptno = 1111 ; -- 없는 경우 예외 발생

   DBMS_OUTPUT.PUT_LINE ( v_ename || ' : ' || v_sal ) ; 
END ;
/


-- IF 문
SET SERVEROUTPUT ON
DECLARE
  v_myage	NUMBER := 10 ;
BEGIN
  IF v_myage < 11 THEN
    DBMS_OUTPUT.PUT_LINE(' I am a child ');
  END IF;
END;
/

-- LOOP문
SET SERVEROUTPUT ON
DECLARE
  v_count	NUMBER(2) := 1 ;
BEGIN
  LOOP
    DBMS_OUTPUT.PUT_LINE ('count: '||to_char(v_count)) ;
    v_count := v_count + 1 ;
    EXIT WHEN v_count = 4 ;
  END LOOP ;
END;
/

SET SERVEROUTPUT ON
BEGIN 
  FOR i IN REVERSE 1..3 LOOP 
    DBMS_OUTPUT.PUT_LINE ('count: '||to_char(i)) ;
  END LOOP ;
END ;
/

-- 조합 데이터 유형
-- %ROWTYPE 사용
SET SERVEROUTPUT ON 
DECLARE 
  emp_rec	emp%ROWTYPE ; 
BEGIN 
  SELECT * INTO emp_rec 
  FROM emp 
  WHERE empno = 7788 ; 
  
  DBMS_OUTPUT.PUT_LINE(emp_rec.ename||' '||emp_rec.sal); 
END ;
/

-- PL/SQL Record
DECLARE 
  TYPE emp_rec_typ IS RECORD 
  ( ename	VARCHAR2(10), 
   sal		emp.sal%TYPE, 
   job		emp.job%TYPE := 'NONE' ) ; 

  emp_rec	EMP_REC_TYP ; 
BEGIN 
  SELECT ename, sal, job INTO emp_rec 
  FROM emp 
  WHERE empno = 7788 ; 
END ;
/

-- Record Type 사용
CREATE TABLE copy_emp 
  AS 
  SELECT * FROM emp 
  WHERE deptno = 10 ; 

DECLARE 
  emp_rec	emp%ROWTYPE ; 
BEGIN 
  SELECT * INTO emp_rec 
  FROM emp 
  WHERE empno = 7788 ; 

  INSERT INTO copy_emp 
  VALUES emp_rec ;

  SELECT * INTO emp_rec 
  FROM emp 
  WHERE empno = 7782 ; 

  emp_rec.sal      := emp_rec.sal * 1.2 ; 
  emp_rec.hiredate := SYSDATE ; 

  UPDATE copy_emp 
  SET ROW = emp_rec 
  WHERE empno = 7782 ; 
END ;
/

SELECT empno, ename, sal, hiredate, deptno
FROM copy_emp ; 

ROLLBACK ; 
