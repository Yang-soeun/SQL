SET SERVEROUTPUT ON
DECLARE 
  CURSOR emp_cur IS -- 1. ����ο� �����Ѵ�.
    SELECT * FROM emp WHERE deptno = 10 ; -- ���� ������ select �� �ۼ� �ϸ� ��
  emp_rec	emp_cur%ROWTYPE ; -- Ŀ�� ������ select ���� join, �̳� Ư�� Į���� �������� ��� �׳� ���̺��� ���� �������� Į������ ��ġ���� �ʾ� ������ �߻��ϹǷ� ���� Ŀ���� ���� �������� ����� ����Ѵ�.
BEGIN 
  -- 2. select ������ ����� �ʿ䰡 �ִ� ������ Ŀ���� �����Ѵ�!
  OPEN emp_cur ; -- ������ �����ȹ�� Ȯ���Ǹ鼭 ����� ����� ���� �ȴ�.

  FETCH emp_cur INTO emp_rec ; -- ���� ���� ��� �� �ϳ��� �ุ ���簡 �ȴ�.
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
    EXIT WHEN emp_cur%NOTFOUND ; -- ����� Ŀ���� �Ӽ� �̿��Ͽ� ����������
    DBMS_OUTPUT.PUT_LINE ( emp_rec.empno || ' ' || emp_rec.ename ) ; 
  END LOOP ; 
  CLOSE emp_cur ; 
END ;
/

DECLARE 
  CURSOR emp_cur IS 
    SELECT * FROM emp WHERE deptno = 10 ; 
    -- emp_rec�� ������� �������� Ȯ���� �� �ִ�.
BEGIN 
-- ����ο� Ŀ���� ������ �� �Ѱܿ� ���ڵ带 �������� �ʾƵ� �ȴ�(emp_rec)
-- emp_rec�ش� Ŀ���� rowtype���� �ϳ��� ���� �������� Ÿ������ ���ǵȴ�.
  FOR emp_rec IN emp_cur LOOP -- �� �������� ���۵Ǵ� ������ Ŀ���� �ڵ����� ���µȴ�.
    DBMS_OUTPUT.PUT_LINE ( emp_rec.empno || ' ' || emp_rec.ename ) ; 
  END LOOP ; 
-- ����ο� �������� �ʾ����Ƿ� LOOP���� ���������� emp_rec�� ����� �� ����.
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
