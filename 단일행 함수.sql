-- 단일행 함수

-- 문자 조작 함수
select * from dual; -- 더미 테이블 행이 1개

select lower('SQL Course') as lower,
upper('SQL Course') as upper,
initcap('SQL Course') as initcap
from dual;

select lower('SQL Course') as lower,
upper('SQL Course') as upper,
initcap('SQL Course') as initcap
from dept; -- dept 테이블의 건수만큼 나옴

-- data저장값을 정확히 모를때
select employee_id, last_name, department_id
from employees
where last_name = 'higgins'; -- 실제는 Higgins로 저장되어 있기 때문에 이렇게 하면 안나옴

-- 이렇게 사용하면 데이터를 정확히 몰라도 찾을 수 있음
select employee_id, last_name, lower(last_name), department_id
from employees
where lower(last_name) = 'higgins';

-- 문자열 관련 함수
-- 1부터 시작
select concat('hello', 'World') as concat,
substr('HelloWorld', 1, 5) as substr,
length('HelloWorld') as length,
instr('HelloWorld', 'W') as instr
from dual;

-- 숫자 관련 함수
-- 반올림
select round(54.923, 2), round(45.923, 0), round(45.923,-1)
from dual;

select trunc(54.923, 2), trunc(45.923), trunc(45.923, -1)
from dual;

-- 날짜 조작 함수
select sysdate from dual; -- 현재 날짜
alter session set nls_date_format = 'RR/MM/DD HH:MI:SS'; -- 날짜 format 변경
select sysdate from dual;
alter session set nls_date_format = 'YYYY/MM/DD';

-- 날짜 + 숫자
select ADD_MONTHS('2004/01/01', 1) from dual; -- 한달 더하기

-- 변환 함수
select employee_id, to_char(hire_date, 'MM/YY') Month_Hired
from employees
where last_name = 'Higgins';

select employee_id, to_char(hire_date, 'year') Month_Hired
from employees
where last_name = 'Higgins';

select employee_id, to_char(hire_date, 'YYYY') Month_Hired
from employees
where last_name = 'Higgins';

-- 달러로 변환
select to_char(salary, 'L99G999D00') salary
from employees
where last_name = 'Higgins';

-- null이면 0으로
select empno, comm, nvl(comm, 0), deptno
from emp;

select empno, sal, comm, sal+nvl(comm, 0)
from emp;

-- case
select last_name, job_id,
case job_id when 'IT_PROG' then 1.10*salary
when 'ST_CLERK' then 1.15*salary
when 'SA_REP' then 1.20*salary
else salary end "REVISED_SALARY"
from employees;


