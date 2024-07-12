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
      ,hiredate - NUMTOYMINTERVAL(1,'YEAR') AS "1 years ago" -- hiredate에서 1년 빼기
      ,hiredate
      ,hiredate + NUMTOYMINTERVAL(1,'YEAR') AS "1 years later" -- hiredate에서 1년 더하기
      ,SUM(sal) OVER(ORDER BY hiredate RANGE NUMTOYMINTERVAL(1,'YEAR') PRECEDING)         AS SUM1 --끝점이 생략된 경우 current
      ,SUM(sal) OVER(ORDER BY hiredate RANGE BETWEEN NUMTOYMINTERVAL(1,'YEAR') PRECEDING --전
                                                 AND NUMTOYMINTERVAL(1,'YEAR') FOLLOWING) AS SUM2 --후
  FROM emp ;
  
  
  
SELECT 단축코드, 일자, 종가
      ,TRUNC(AVG(종가) OVER(PARTITION BY 단축코드 
                            ORDER BY 일자 DESC 
                            ROWS BETWEEN CURRENT ROW AND 4 FOLLOWING)) AS "이평선(5일)" --4일 빼기
      ,TRUNC(AVG(종가) OVER(PARTITION BY 단축코드 
                            ORDER BY 일자 DESC 
                            RANGE BETWEEN CURRENT ROW AND 4 FOLLOWING)) AS "이평선(5일)"
  FROM 종목현황; 
  
-- 1. 주의사항
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
1. 종목현황 테이블을 이용하여 대비, 등락률을 검색하세요.
대비   = 종가 - 전일종가 
등락률 = ROUND(((종가-전일 종가)/전일 종가) * 100,2)
*/
select 단축코드, 일자, 종가
, lead(종가) over(partition by 단축코드 order by 일자 desc) as 전일종가,
종가 - lead(종가) over(partition by 단축코드 order by 일자 desc) as 대비
from 종목현황;


/*
2. ORDERS 테이블을 이용하여 2024년 5월달에, 고객별 주문의 평균 간격을 검색하고 싶다.
예: 2024년 5월 1일, 3일, 5일, 7일, 9일에 주문 이력이 있는 고객이라면, 평균 2일을 검색해야 한다. 
   => (2+2+2+2)/4 
Q1. 2024년 5월에 고객번호(CUST_ID) 107 의 평균 주문 간격 일수는?
Q2. 2024년 5월에 고객별 평균 주문 간격 일수는? 
*/
select a.cust_id, round(avg(a.주기), 2) as 평균주기
from (select cust_id, order_date - lag(order_date) over(partition by cust_id order by order_date) as 주기
        from (select distinct order_date, cust_id
        from orders
        where order_date between to_date('2024/05/01') and to_date('2024/05/31'))) a
group by a.cust_id
order by a.cust_id;

/*
3. TACCT 테이블에서 지점별(BRANCH) 대출 평균 금액(AVG(LN_AMT))을 계산하고, 
지점별 평균 금액과  ±500만원 범위 내에 있는 지점의 수를 검색하세요. 
- 대출 계좌만을 대상으로 (LMT_TYP IS NULL)
- 평균 금액으로 정렬 (100만원 단위 절사)
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
 