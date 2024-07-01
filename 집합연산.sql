-- 집합 연산
--  첫번째 select 문의 칼럼헤딩이 나옴
-- 위아래 쿼리의 컬럼의 갯수가 서로 같아야 한다.
-- 위아래 쿼리의 컬럼의 데이터 타입이 서로 같아야 한다
-- order by 절은 맨 아래 쿼리에만 사용할 수 있디.
-- 컬럼의 별칭은 맨 위의 쿼리의 컬럼에만 사용할 수 있다.
select deptno from emp 
union all -- 중복허용 합집합
select deptno from dept
order by deptno;

select deptno from emp
union -- 중복제거 합집합
select deptno from dept;

select deptno from emp
intersect -- 교집합
select deptno from dept;

select deptno from emp
minus -- 차집합
select deptno from dept;

select deptno from dept
minus 
select deptno from emp;

-- 칼럼 개수 맞추기 alias 줘여함
select ename, null as dname from emp
union all
select dname, null from dept
union all
select null, 'KOREA' from dual;

-- table에 대한 comment들이 있음
select * from user_tab_comments
where table_name = 'JOB_HISTORY';

desc job_history;

-- 각 칼럼에 대한 comment도 확인 가능
select * from user_col_comments 
where table_name = 'JOB_HISTORY';

-- 테이블 정보
select * from user_tables;

-- 변경 히스토리
select * from job_history;

-- 칼럼 자릿수 맞추기
select location_id, null city, department_name
from departments
union
select location_id, city, null
from locations;


-- 문제
-- emp에서 sal 값의 총합을 구해서 아래의 결과를 출력하시오!
select 1, sal
from emp;

select '전체토탈 : ', sum(sal)
from emp;

select job, sum(sal)
from emp
group by job
union all
select '전체토탈: ' , sum(sal)
from emp;

select * from emp;

select to_char(hiredate, 'YYYY') as "입사 년도", 
sum(sal) as "월급 합계"
from emp
group by to_char(hiredate, 'YYYY')
union all
select '전체토탈 : ', sum(sal)
from emp
order by 1;


