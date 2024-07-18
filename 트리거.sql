select to_char(sysdate, 'D')
from dual;

-- 문장 트리거 
SELECT TO_CHAR(SYSDATE,'DY'), TO_CHAR(SYSDATE,'D')
  FROM DUAL ; 

CREATE OR REPLACE TRIGGER secure_emp
  BEFORE INSERT ON emp
BEGIN
  IF (TO_CHAR(SYSDATE,'D') IN ('7','1')) OR
     (TO_CHAR(SYSDATE,'HH24:MI') NOT BETWEEN '08:00' AND '18:00') THEN -- 업무 시간 외에 실행한 경우 오류 발생
  
     RAISE_APPLICATION_ERROR(-20500, 'You may insert into EMP table only during business hours.');
  END IF;
END;
/

-- 행 트리거 
CREATE OR REPLACE TRIGGER restrict_salary
   BEFORE INSERT OR UPDATE OF salary ON employees -- salary 칼럼 업데이트 하는것만 감지
   FOR EACH ROW
BEGIN
   IF NOT (:NEW.job_id IN ('AD_PRES', 'AD_VP')) -- 새로 insert 되려고 하는 값
      AND :NEW.salary > 15000 THEN
      RAISE_APPLICATION_ERROR (-20202,'Employee cannot earn more than $15,000.');
   END IF;
END;
/

CREATE OR REPLACE TRIGGER check_salary
   BEFORE INSERT OR UPDATE OF sal,deptno ON emp
   FOR EACH ROW
DECLARE
   v_minsalary	emp.sal%TYPE;
   v_maxsalary	emp.sal%TYPE;
BEGIN
   SELECT MIN(sal), MAX(sal)  INTO v_minsalary, v_maxsalary
   FROM emp
   WHERE deptno = :NEW.deptno;

   IF :NEW.sal < v_minsalary OR :NEW.sal > v_maxsalary THEN
     RAISE_APPLICATION_ERROR(-20505,'Out of range');
   END IF;
END;
/

update emp
set sal = 1500
where empno = 7369;

-- 함수 생성

CREATE OR REPLACE FUNCTION get_location
( p_deptname IN VARCHAR2) RETURN VARCHAR2 
AS
  v_loc_id NUMBER;
  v_city   VARCHAR2(30);
BEGIN
  SELECT d.location_id, l.city INTO v_loc_id, v_city
  FROM departments d, locations l
  WHERE department_name = p_deptname
  and d.location_id = l.location_id;
  RETURN v_city;
END GET_LOCATION;
/

-- Procedure 생성
CREATE OR REPLACE PROCEDURE emp_list 
(p_maxrows IN NUMBER) 
IS
CURSOR cur_emp IS
  SELECT d.department_name, e.employee_id, e.last_name,
         e.salary, e.commission_pct
  FROM  departments d, employees e
  WHERE d.department_id = e.department_id;
  rec_emp cur_emp%ROWTYPE;
  TYPE emp_tab_type IS TABLE OF cur_emp%ROWTYPE INDEX BY BINARY_INTEGER;
  emp_tab emp_tab_type;
i NUMBER := 1;
v_city VARCHAR2(30); 
BEGIN
  OPEN cur_emp;
  FETCH cur_emp INTO rec_emp;
  emp_tab(i) := rec_emp;
  WHILE (cur_emp%FOUND) AND (i <= p_maxrows) LOOP
     i := i + 1;
     FETCH cur_emp INTO rec_emp;
     emp_tab(i) := rec_emp;
     v_city := get_location (rec_emp.department_name);
     dbms_output.put_line('Employee ' || rec_emp.last_name ||
       ' works in ' || v_city );
  END LOOP;
  CLOSE cur_emp;
  FOR j IN REVERSE 1..i LOOP
     DBMS_OUTPUT.PUT_LINE(emp_tab(j).last_name);
  END LOOP;
END emp_list; 
/

-- Native Dynamic SQL 사용
CREATE OR REPLACE FUNCTION delete_all_rows
(p_table_name VARCHAR2) RETURN NUMBER IS
BEGIN
  EXECUTE IMMEDIATE 'DELETE FROM ' || p_table_name ; 
  RETURN SQL%ROWCOUNT ;
END;
/
EXECUTE DBMS_OUTPUT.PUT_LINE ( 'Rows Deleted : '|| delete_all_rows ('EMP') ) 

CREATE OR REPLACE PROCEDURE rename_col 
( p_tab_name	VARCHAR2, 
 p_old_name	VARCHAR2,
 p_new_name	VARCHAR2 ) IS 
BEGIN 
 EXECUTE IMMEDIATE 'ALTER TABLE ' || p_tab_name || ' RENAME COLUMN ' || p_old_name || ' TO ' || p_new_name;
END ;
/

EXECUTE rename_col ( 'emp', 'empno', 'id' ) 
EXECUTE rename_col ( 'emp', 'id', 'empno' ) 

CREATE OR REPLACE FUNCTION get_sal 
( p_empno	NUMBER) RETURN NUMBER IS 
 v_sal	NUMBER ; 
BEGIN 
 EXECUTE IMMEDIATE 'SELECT sal FROM emp WHERE empno = :id ' INTO v_sal USING p_empno ; 
 RETURN v_sal ; 
END get_sal ; 
/

SET SERVEROUTPUT ON 
EXECUTE DBMS_OUTPUT.PUT_LINE ( get_sal(7788) )

-- REF CURSOR
CREATE OR REPLACE PROCEDURE get_sal
(p_empno  IN  NUMBER DEFAULT NULL)  IS 
  TYPE emp_refcsr IS REF CURSOR ; -- weak type
  emp_cv	emp_refcsr ; 
  emp_rec	emp%rowtype; 
  stmt		VARCHAR2(1000) := 'SELECT * FROM emp'; 
BEGIN 
  IF p_empno IS NULL THEN 
    OPEN emp_cv FOR stmt ; 
  ELSE
    stmt := stmt || ' WHERE empno = :id' ;
    OPEN emp_cv FOR stmt USING p_empno ; 
  END IF ; 

  LOOP 
    FETCH emp_cv INTO emp_rec ;
    EXIT WHEN emp_cv%NOTFOUND ; 
    dbms_output.put_line(emp_rec.ename||':'||emp_rec.sal);
  END LOOP ; 
  
  CLOSE emp_cv ;
END get_sal ; 
/

CREATE OR REPLACE PROCEDURE get_data
(p_x OUT sys_refcursor)
AS
  l_query VARCHAR2(400) :='SELECT deptno ';
BEGIN

  FOR x IN (SELECT DISTINCT JOB 
            FROM emp ORDER BY 1) LOOP
    l_query := l_query ||REPLACE(', SUM(DECODE(job,''$X'',sal)) AS $X ' ,'$X',x.job );
  END LOOP;
  
  l_query := l_query ||' FROM emp GROUP BY deptno ORDER BY deptno';

  OPEN p_x FOR l_query;
END;
/


VARIABLE x refcursor -- 커서 변수
EXECUTE get_data(:x) 
PRINT x

-- Bulk Binding
DECLARE 
   TYPE typ_sales IS TABLE OF sales%rowtype INDEX BY PLS_INTEGER ;  -- collection 데이터 타입
   tab_sales     typ_sales ;  
 BEGIN
   SELECT /*+ test4 */ * BULK COLLECT INTO tab_sales FROM sales ; -- 둘이상 행의 저장할 수 있음
   FORALL i IN tab_sales.FIRST .. tab_sales.LAST
   INSERT /*+ test4 */ INTO sales2 
   VALUES tab_sales(i) ; 
 END ;
/

-- FORALL 문과 EXCEPTION
DECLARE 
   CURSOR cur_emp IS SELECT empno, ename, sal * 0.5 AS new_sal FROM emp ; 
   TYPE typ_emp IS TABLE OF cur_emp%rowtype INDEX BY PLS_INTEGER ; 
   tab_emp    typ_emp ;  
   bulk_errors 	EXCEPTION ;
   PRAGMA 		EXCEPTION_INIT(bulk_errors, -24381) ;
 BEGIN 
   OPEN cur_emp ; 
   FETCH cur_emp BULK COLLECT INTO tab_emp ; 
   CLOSE cur_emp ; 

   FORALL i IN tab_emp.FIRST .. tab_emp.LAST 
   SAVE EXCEPTIONS 
	 UPDATE emp2 
	 SET sal       = tab_emp(i).new_sal
	 WHERE empno   = tab_emp(i).empno ; 
	 -- 중간에 에러 생기면 -24381 에러가 발생함
	 DBMS_OUTPUT.PUT_LINE ('Total :' || SQL%ROWCOUNT || ' rows updated') ; 

 EXCEPTION
   WHEN bulk_errors THEN
	 DBMS_OUTPUT.PUT_LINE('Number of errors is : '|| SQL%BULK_EXCEPTIONS.COUNT) ;

	 FOR j IN 1..SQL%BULK_EXCEPTIONS.COUNT LOOP
	   DBMS_OUTPUT.PUT_LINE(SQL%BULK_EXCEPTIONS(j).ERROR_INDEX ||' / '||  -- ERROR_INDEX는 tab_emp의 인덱스
							SQLERRM(-SQL%BULK_EXCEPTIONS(j).ERROR_CODE) );
	 END LOOP;
 END ;
/