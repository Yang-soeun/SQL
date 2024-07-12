SELECT empno, ename, sal, deptno
      ,SUM(sal) OVER(ORDER BY empno)                                       AS SUM1
      ,SUM(sal) OVER(ORDER BY empno ROWS BETWEEN UNBOUNDED PRECEDING 
                                             AND CURRENT ROW)              AS SUM2
      ,SUM(sal) OVER(ORDER BY empno ROWS BETWEEN CURRENT ROW
                                             AND UNBOUNDED FOLLOWING)      AS SUM3
      ,SUM(sal) OVER(ORDER BY empno ROWS BETWEEN 1 PRECEDING 
                                             AND 1 FOLLOWING)              AS SUM5
  FROM emp ; 
  
SELECT empno, ename, mgr, sal
      ,hiredate - NUMTOYMINTERVAL(1,'YEAR') AS "1 years ago" -- hiredate���� 1�� ����
      ,hiredate
      ,hiredate + NUMTOYMINTERVAL(1,'YEAR') AS "1 years later" -- hiredate���� 1�� ���ϱ�
      ,SUM(sal) OVER(ORDER BY hiredate RANGE NUMTOYMINTERVAL(1,'YEAR') PRECEDING)         AS SUM1 --������ ������ ��� current
      ,SUM(sal) OVER(ORDER BY hiredate RANGE BETWEEN NUMTOYMINTERVAL(1,'YEAR') PRECEDING --��
                                                 AND NUMTOYMINTERVAL(1,'YEAR') FOLLOWING) AS SUM2 --��
  FROM emp ;
  
  
  
SELECT �����ڵ�, ����, ����
      ,TRUNC(AVG(����) OVER(PARTITION BY �����ڵ� 
                            ORDER BY ���� DESC 
                            ROWS BETWEEN CURRENT ROW AND 4 FOLLOWING)) AS "����(5��)" --4�� ����
      ,TRUNC(AVG(����) OVER(PARTITION BY �����ڵ� 
                            ORDER BY ���� DESC 
                            RANGE BETWEEN CURRENT ROW AND 4 FOLLOWING)) AS "����(5��)"
  FROM ������Ȳ; 
  
-- 1. ���ǻ���
SELECT empno, ename, sal, hiredate, deptno, 
       ROUND(AVG(sal) OVER(PARTITION BY deptno),2) AS AVG_SAL
  FROM emp
 WHERE hiredate BETWEEN TO_DATE('1981/01/01','YYYY/MM/DD') 
                    AND TO_DATE('1982/01/01','YYYY/MM/DD') - 1/86400 ;


SELECT empno, ename, sal, hiredate, deptno, avg_sal
  FROM (SELECT empno, ename, sal, hiredate, deptno, 
               ROUND(AVG(sal) OVER(PARTITION BY deptno),2) AS AVG_SAL
         FROM emp) 
 WHERE hiredate BETWEEN TO_DATE('1981/01/01','YYYY/MM/DD') 
                    AND TO_DATE('1982/01/01','YYYY/MM/DD') - 1/86400 ;

/*
1. ������Ȳ ���̺��� �̿��Ͽ� ���, ������� �˻��ϼ���.
���   = ���� - �������� 
����� = ROUND(((����-���� ����)/���� ����) * 100,2)
*/
select �����ڵ�, ����, ����
, lead(����) over(partition by �����ڵ� order by ���� desc) as ��������,
���� - lead(����) over(partition by �����ڵ� order by ���� desc) as ���
from ������Ȳ;


/*
2. ORDERS ���̺��� �̿��Ͽ� 2024�� 5���޿�, ���� �ֹ��� ��� ������ �˻��ϰ� �ʹ�.
��: 2024�� 5�� 1��, 3��, 5��, 7��, 9�Ͽ� �ֹ� �̷��� �ִ� ���̶��, ��� 2���� �˻��ؾ� �Ѵ�. 
   => (2+2+2+2)/4 
Q1. 2024�� 5���� ����ȣ(CUST_ID) 107 �� ��� �ֹ� ���� �ϼ���?
Q2. 2024�� 5���� ���� ��� �ֹ� ���� �ϼ���? 
*/
select a.cust_id, round(avg(a.�ֱ�), 2) as ����ֱ�
from (select cust_id, order_date - lag(order_date) over(partition by cust_id order by order_date) as �ֱ�
        from (select distinct order_date, cust_id
        from orders
        where order_date between to_date('2024/05/01') and to_date('2024/05/31'))) a
group by a.cust_id
order by a.cust_id;

/*
3. TACCT ���̺��� ������(BRANCH) ���� ��� �ݾ�(AVG(LN_AMT))�� ����ϰ�, 
������ ��� �ݾװ�  ��500���� ���� ���� �ִ� ������ ���� �˻��ϼ���. 
- ���� ���¸��� ������� (LMT_TYP IS NULL)
- ��� �ݾ����� ���� (100���� ���� ����)
*/
WITH TAVG AS (SELECT BRANCH
                    ,TRUNC(AVG(LN_AMT),-6) AS AVG_AMT
                FROM TACCT 
               WHERE LMT_TYP IS NULL
               GROUP BY BRANCH)
SELECT A.BRANCH, A.AVG_AMT, COUNT(*) AS CNT 
  FROM TAVG A 
  JOIN TAVG B 
    ON A.AVG_AMT BETWEEN B.AVG_AMT - 5000000 AND B.AVG_AMT + 5000000 
GROUP BY A.BRANCH, A.AVG_AMT     
ORDER BY 2 ;

SELECT BRANCH
      ,TRUNC(AVG(LN_AMT),-6) AS AVG_AMT
      ,COUNT(*) OVER(ORDER BY TRUNC(AVG(LN_AMT),-6)
                     RANGE BETWEEN 5000000 PRECEDING 
                               AND 5000000 FOLLOWING) AS CNT
  FROM TACCT 
 WHERE LMT_TYP IS NULL
 GROUP BY BRANCH 
 ORDER BY AVG_AMT ; 
 