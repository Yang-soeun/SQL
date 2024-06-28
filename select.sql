-- select
select * from departments;
select department_id, department_name, manager_id, location_id from departments;

-- desc == DESCRIBE
DESCRIBE employees;
desc departments;

-- 날짜 형식 변경**
alter session set nls_date_format = 'YYYY/MM/DD';

-- 사칙 연산
select last_name, salary, salary + 300
from employees;

-- 연산자 우선순위
select last_name, salary, 12*salary+100
from employees;

select last_name, salary, 12*(salary+100)
from employees;

-- null: 값 X
select last_name, job_id, salary, commission_pct
from employees;

-- null과의 산술연산 결과는 null
select last_name, 12*salary*commission_pct
from employees;

select last_name, salary, commission_pct, salary+commission_pct
from employees;

-- 날짜 연산
select last_name, hire_date, hire_date + 300
from employees;

select last_name, hire_date, hire_date - 300
from employees;

-- 날짜는 +-만 가능 * 불가능
select last_name, hire_date, hire_date * 300
from employees;

-- Alias 별칭
-- Alias의 머리글은 대문자로 나타낸다.
-- 공백, 특수 문자 포함, 대소문자를 구분하는 경우 alias 를 큰 따옴표로 묶음
-- || 두 개 연결

select last_name|| ' is a ' || job_id AS "Employees Details"
from employees;

-- 전부 대문자로 나옴
select last_name AS name, commission_pct comm
from employees;

-- 대소문자 구분돼서 나옴
select last_name AS "Name", salary*12 "Annual Salary"
from employees;

-- 중복 제거
select department_id
from employees;

-- distinct는 젤 앞에 와야함
-- department_id, distinct job_id 안됨
select distinct department_id, job_id
from employees;
