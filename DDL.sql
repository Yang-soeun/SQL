-- DDL
create table copy2_emp
as select empno, sal+comm as revenue from emp; --> +- 이런 연산자는 칼럼 이름으로는 불가능함, alias를 사용해서 해야함

select * from copy2_emp;

create table hire_dates
(id number(8),
hire_date date default sysdate);

select table_name, column_name, data_type, data_default
from user_tab_columns
where table_name = 'HIRE_DATES';

-- hire date 열에 null 삽입
insert into hire_dates values(45, null);

-- hire date 열에 sysdate 삽입
insert into hire_dates(id) values(35);
select * from hire_dates;

-- data type
/*
CHAR - 고정 길이 문자(최대 2,000byte)
VARCHAR - 가변 길이 문자(최대 4,000byte)
CLOB - 가변 길이 문자(최대(4GB -1) * db_block_size)
NUMBER(p, s) - 숫자(자릿수, 소수점 자릿수)
DATE - 날짜 및 시간 (YYYY/MM/DD HH:MI:SS)
*/

-- 1.1.1 char 타입 주의점
-- char는 조건을 비교할 경우 공백 문자를 붙여 양쪽 값을 더 긴 쪽과 동일하게 한다.
create table chr_typ(c1 char(5), c2 varchar2(5));
insert into chr_typ values('ABC', 'ABC');
select c1, dump(c2), c2, dump(c2) from chr_typ;

select * from chr_typ
where c1 = 'ABC';

select * from chr_typ
where c1 = 'ABC  '; --공백 2개: 결과 나옴

select * from chr_typ
where c1 = 'ABC     '; -- 공백 5개: 결과 나옴

select * from chr_typ
where c2 = 'ABC';

select * from chr_typ
where c2 = 'ABC  '; --공백 2개: 결과 안나옴

select * from chr_typ
where c2 = 'ABC     '; -- 공백 5개: 결과 안나옴

create table num_typ(
c1 number,
c2 number(4, 2),
c3 number(4),
c4 number(2, 4),
c5 number(4, -1) -- 전체 4자리 인데 -1 = 10의 자리 -> 의미는 10의자리까지만 나올 수 있게
);

insert into num_typ(c2, c3, c4, c5) values(0,0,0,0);
select * from num_typ;

insert into num_typ(c2) values(12.34567);
insert into num_typ(c2) values(99.999); --반올림 하면 넘어가서 안됌

insert into num_typ(c3) values(12.34566);
insert into num_typ(c3) values(12);
insert into num_typ(c3) values(9999.34567);
insert into num_typ(c3) values(99999); -- 이거 안됨

insert into num_typ(c4) values(12.34566);
insert into num_typ(c4) values(12);
insert into num_typ(c4) values(9999.34567);
insert into num_typ(c4) values(0.1111);
insert into num_typ(c4) values(0.0099); -- 이거만 됨
insert into num_typ(c4) values(0.0123); -- 숫자가 3개라서 안됨
insert into num_typ(c4) values(0.004);
insert into num_typ(c4) values(0.1);


insert into num_typ(c5) values(12.34566);
insert into num_typ(c5) values(12);
insert into num_typ(c5) values(9999.34567);
insert into num_typ(c5) values(0.1111);
insert into num_typ(c5) values(0.0099); 
insert into num_typ(c5) values(99999); --이거 안됨
insert into num_typ(c5) values(0.004);
insert into num_typ(c5) values(0.1);

rollback;

SELECT c5 FROM num_typ ;
rollback;

/* date type */
-- date type : 세기, 연도, 월, 일, 시, 분, 초 7가지 값
-- timestamp type : date확장형, 소수점이하 초의 정밀한 시간저장

CREATE TABLE dt_typ
(c1 DATE) ;

INSERT INTO dt_typ VALUES ( SYSDATE ) ;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD HH24:MI:SS' ;
SELECT * FROM dt_typ ; -- 'YYYY/MM/DD HH24:MI:SS' 포맷으로 출력
-- 2024/07/03 16:18:38
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD' ;
SELECT * FROM dt_typ ; -- 'YYYY/MM/DD' 포맷으로 출력

SELECT DUMP(c1)
FROM dt_typ ;

-- 실제저장된 날짜타입은 시분초까지
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD';

-- sysdate 현재날짜값으로 비교, 시분초는 00:00:00으로 비교되므로 no data
SELECT * FROM dt_typ
WHERE c1 = TO_DATE('2024/07/03','YYYY/MM/DD') ;

-- sysdate 현재날짜값 시분초까지 동일해야함
SELECT * FROM dt_typ
WHERE c1 = TO_DATE('2024/07/03 16:18:38','YYYY/MM/DD HH24:MI:SS');

-- 저장된 시분초값 모를경우 to_char이용하거나 between으로 검색가능
select * from dt_typ
where to_char(c1, 'YYYY/MM/DD') = '2024/07/03';

SELECT * FROM dt_typ
WHERE c1 BETWEEN TO_DATE('2024/07/03 00:00:00','YYYY/MM/DD HH24:MI:SS')
AND TO_DATE('2024/07/03 23:59:59','YYYY/MM/DD HH24:MI:SS') ;


