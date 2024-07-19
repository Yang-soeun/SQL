SET TIMING ON 
DECLARE 
       CURSOR cur_sales IS SELECT /*+ cursor1 */ * FROM sales ; 
       rec_sales  cur_sales%rowtype ; 
     BEGIN
       OPEN cur_sales ; 
       LOOP 
         FETCH cur_sales INTO rec_sales ; 
         EXIT WHEN cur_sales%NOTFOUND ; 
       END LOOP ;  
       CLOSE cur_sales ;
     END ;
/

DECLARE 
       CURSOR cur_sales IS SELECT /*+ cursor2 */ * FROM sales ;  
     BEGIN
       FOR rec_sales IN cur_sales LOOP 
         NULL ; 
       END LOOP ;  
     END ;
/

SELECT SQL_TEXT, EXECUTIONS, FETCHES, BUFFER_GETS, ROWS_PROCESSED
FROM V$SQL 
WHERE SQL_TEXT LIKE 'SELECT /*+ cursor%' ;

DROP TABLE sales2 PURGE ; 
CREATE TABLE sales2 AS SELECT * FROM sales WHERE 1 = 0 ; 

BEGIN
       INSERT /*+ test1 */ INTO sales2 SELECT * FROM sales ;
END ;
/

DECLARE 
   CURSOR cur_sales IS SELECT /*+ test2 */ * FROM sales ;  
 BEGIN
   FOR rec_sales IN cur_sales LOOP 
	 INSERT /*+ test2 */ INTO sales2 VALUES rec_sales ; 
   END LOOP ;  
 END ;
/

DECLARE 
   CURSOR cur_sales IS SELECT /*+ test3 */ * FROM sales ; 
   rec_sales  cur_sales%rowtype ; 
 BEGIN
   OPEN cur_sales ; 
   LOOP 
	 FETCH cur_sales INTO rec_sales ; 
	 EXIT WHEN cur_sales%NOTFOUND ; 
	   INSERT /*+ test3 */ INTO sales2 VALUES rec_sales ; 
   END LOOP ;  
   CLOSE cur_sales ;
 END ;
/

SELECT sql_text, executions, fetches, rows_processed, cpu_time, elapsed_time 
  FROM v$sql 
 WHERE sql_text LIKE 'SELECT /*+ test%' ;

SELECT sql_text, executions, fetches, rows_processed, cpu_time, elapsed_time 
  FROM v$sql 
 WHERE sql_text LIKE 'INSERT /*+ test%' ;

SELECT sql_text, executions, fetches, rows_processed, cpu_time, elapsed_time 
  FROM v$sql 
 WHERE sql_text LIKE 'INSERT /*+ test%' ;

SELECT sql_text, executions, fetches, rows_processed, cpu_time, elapsed_time 
 FROM v$sql 
 WHERE sql_text LIKE 'SELECT /*+ test%' ;

SELECT sql_text, executions, fetches, rows_processed, cpu_time, elapsed_time 
 FROM v$sql 
 WHERE sql_text LIKE 'INSERT /*+ test%' ;

SET SERVEROUTPUT ON 
DECLARE
   TYPE emp_tab_typ		IS TABLE OF emp%ROWTYPE INDEX BY PLS_INTEGER ;
   emp_tab			emp_tab_typ ;
 BEGIN
   SELECT * BULK COLLECT INTO emp_tab FROM emp WHERE deptno = 20 ;
   FOR i IN emp_tab.FIRST .. emp_tab.LAST LOOP 
     DBMS_OUTPUT.PUT_LINE( emp_tab(i).empno || ' ' || emp_tab(i).ename ) ; 
   END LOOP ; 
 END ; 
/

DECLARE
   CURSOR emp_cur  	IS SELECT * FROM emp WHERE deptno = 20 ;
   TYPE emp_tab_typ IS TABLE OF emp_cur%ROWTYPE INDEX BY PLS_INTEGER ;
   emp_tab 		emp_tab_typ ;
 BEGIN
   OPEN emp_cur ;
   FETCH emp_cur BULK COLLECT INTO emp_tab ;
   CLOSE emp_cur ;
   FOR i IN emp_tab.FIRST .. emp_tab.LAST LOOP 
	 DBMS_OUTPUT.PUT_LINE( emp_tab(i).empno || ' ' || emp_tab(i).ename ) ; 
   END LOOP ; 
 END ;
/

DECLARE
   CURSOR emp_cur  	IS SELECT * FROM emp WHERE deptno = 20 ;
   TYPE emp_tab_typ IS TABLE OF emp_cur%ROWTYPE INDEX BY PLS_INTEGER;
   emp_tab 		emp_tab_typ ;
 BEGIN
   OPEN emp_cur ;
   FETCH emp_cur BULK COLLECT INTO emp_tab LIMIT 3 ;
   FOR i IN emp_tab.FIRST .. emp_tab.LAST LOOP 
	 DBMS_OUTPUT.PUT_LINE( '1st :' || emp_tab(i).empno || ' ' || emp_tab(i).ename ) ; 
   END LOOP ;

 FETCH emp_cur BULK COLLECT INTO emp_tab LIMIT 3 ;
   FOR i IN emp_tab.FIRST .. emp_tab.LAST LOOP 
	 DBMS_OUTPUT.PUT_LINE( '2nd :' || emp_tab(i).empno || ' ' || emp_tab(i).ename ) ; 
   END LOOP ;
   CLOSE emp_cur ;
 END ;
/
