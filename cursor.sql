SET SERVEROUTPUT ON
DECLARE 
  CURSOR emp_cur IS -- 1. 선언부에 선언한다.
    SELECT * FROM emp WHERE deptno = 10 ; -- 동작 가능한 select 문 작성 하면 됨
  emp_rec	emp_cur%ROWTYPE ; -- 커서 내부의 select 문에 join, 이나 특정 칼럼만 가져오는 경우 그냥 테이블을 행을 가져오면 칼럼들이 일치하지 않아 문제가 발생하므로 보통 커서의 행을 가져오는 방법을 사용한다.
BEGIN 
  -- 2. select 문장이 실행될 필요가 있는 시점에 커서를 오픈한다!
  OPEN emp_cur ; -- 문장의 실행계획이 확보되면서 실행된 결과가 담기게 된다.

  FETCH emp_cur INTO emp_rec ; -- 여러 행의 결과 중 하나의 행만 복사가 된다.
  DBMS_OUTPUT.PUT_LINE ( emp_rec.empno || ' ' || emp_rec.ename ) ; 

  FETCH emp_cur INTO emp_rec ; 
  DBMS_OUTPUT.PUT_LINE ( emp_rec.empno || ' ' || emp_rec.ename ) ; 

  CLOSE emp_cur ; 
END ;
/


DECLARE  
  CURSOR emp_cur IS 
    SELECT * FROM emp WHERE deptno = 10 ; 
  emp_rec	emp_cur%ROWTYPE ; 
BEGIN 
  OPEN emp_cur ; 
  LOOP 
    FETCH emp_cur INTO emp_rec ; 
    EXIT WHEN emp_cur%NOTFOUND ; -- 명시적 커서의 속성 이용하여 빠져나가기
    DBMS_OUTPUT.PUT_LINE ( emp_rec.empno || ' ' || emp_rec.ename ) ; 
  END LOOP ; 
  CLOSE emp_cur ; 
END ;
/

DECLARE 
  CURSOR emp_cur IS 
    SELECT * FROM emp WHERE deptno = 10 ; 
    -- emp_rec이 선언되지 않은것을 확인할 수 있다.
BEGIN 
-- 선언부에 커서가 열렸을 떄 넘겨올 레코드를 선언하지 않아도 된다(emp_rec)
-- emp_rec해당 커서의 rowtype으로 하나의 행을 가져오는 타입으로 정의된다.
  FOR emp_rec IN emp_cur LOOP -- 이 루프문이 동작되는 시점에 커서가 자동으로 오픈된다.
    DBMS_OUTPUT.PUT_LINE ( emp_rec.empno || ' ' || emp_rec.ename ) ; 
  END LOOP ; 
-- 선언부에 선언하지 않았으므로 LOOP문을 빠져나오면 emp_rec은 사용할 수 없다.
END ;
/

BEGIN 
  FOR emp_rec IN ( SELECT * 
                     FROM emp 
                    WHERE deptno = 10 ) LOOP
    DBMS_OUTPUT.PUT_LINE ( emp_rec.empno || ' ' || emp_rec.ename ) ; 
  END LOOP ; 
END ;
/
