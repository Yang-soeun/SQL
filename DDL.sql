-- DDL
create table copy2_emp
as select empno, sal+comm as revenue from emp; --> +- �̷� �����ڴ� Į�� �̸����δ� �Ұ�����, alias�� ����ؼ� �ؾ���

select * from copy2_emp;

create table hire_dates
(id number(8),
hire_date date default sysdate);

select table_name, column_name, data_type, data_default
from user_tab_columns
where table_name = 'HIRE_DATES';

-- hire date ���� null ����
insert into hire_dates values(45, null);

-- hire date ���� sysdate ����
insert into hire_dates(id) values(35);
select * from hire_dates;

-- data type
/*
CHAR - ���� ���� ����(�ִ� 2,000byte)
VARCHAR - ���� ���� ����(�ִ� 4,000byte)
CLOB - ���� ���� ����(�ִ�(4GB -1) * db_block_size)
NUMBER(p, s) - ����(�ڸ���, �Ҽ��� �ڸ���)
DATE - ��¥ �� �ð� (YYYY/MM/DD HH:MI:SS)
*/

-- 1.1.1 char Ÿ�� ������
-- char�� ������ ���� ��� ���� ���ڸ� �ٿ� ���� ���� �� �� �ʰ� �����ϰ� �Ѵ�.
create table chr_typ(c1 char(5), c2 varchar2(5));
insert into chr_typ values('ABC', 'ABC');
select c1, dump(c2), c2, dump(c2) from chr_typ;

select * from chr_typ
where c1 = 'ABC';

select * from chr_typ
where c1 = 'ABC  '; --���� 2��: ��� ����

select * from chr_typ
where c1 = 'ABC     '; -- ���� 5��: ��� ����

select * from chr_typ
where c2 = 'ABC';

select * from chr_typ
where c2 = 'ABC  '; --���� 2��: ��� �ȳ���

select * from chr_typ
where c2 = 'ABC     '; -- ���� 5��: ��� �ȳ���

create table num_typ(
c1 number,
c2 number(4, 2),
c3 number(4),
c4 number(2, 4),
c5 number(4, -1) -- ��ü 4�ڸ� �ε� -1 = 10�� �ڸ� -> �ǹ̴� 10���ڸ������� ���� �� �ְ�
);

insert into num_typ(c2, c3, c4, c5) values(0,0,0,0);
select * from num_typ;

insert into num_typ(c2) values(12.34567);
insert into num_typ(c2) values(99.999); --�ݿø� �ϸ� �Ѿ�� �ȉ�

insert into num_typ(c3) values(12.34566);
insert into num_typ(c3) values(12);
insert into num_typ(c3) values(9999.34567);
insert into num_typ(c3) values(99999); -- �̰� �ȵ�

insert into num_typ(c4) values(12.34566);
insert into num_typ(c4) values(12);
insert into num_typ(c4) values(9999.34567);
insert into num_typ(c4) values(0.1111);
insert into num_typ(c4) values(0.0099); -- �̰Ÿ� ��
insert into num_typ(c4) values(0.0123); -- ���ڰ� 3���� �ȵ�
insert into num_typ(c4) values(0.004);
insert into num_typ(c4) values(0.1);


insert into num_typ(c5) values(12.34566);
insert into num_typ(c5) values(12);
insert into num_typ(c5) values(9999.34567);
insert into num_typ(c5) values(0.1111);
insert into num_typ(c5) values(0.0099); 
insert into num_typ(c5) values(99999); --�̰� �ȵ�
insert into num_typ(c5) values(0.004);
insert into num_typ(c5) values(0.1);

rollback;

SELECT c5 FROM num_typ ;
rollback;

/* date type */
-- date type : ����, ����, ��, ��, ��, ��, �� 7���� ��
-- timestamp type : dateȮ����, �Ҽ������� ���� ������ �ð�����

CREATE TABLE dt_typ
(c1 DATE) ;

INSERT INTO dt_typ VALUES ( SYSDATE ) ;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD HH24:MI:SS' ;
SELECT * FROM dt_typ ; -- 'YYYY/MM/DD HH24:MI:SS' �������� ���
-- 2024/07/03 16:18:38
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD' ;
SELECT * FROM dt_typ ; -- 'YYYY/MM/DD' �������� ���

SELECT DUMP(c1)
FROM dt_typ ;

-- ��������� ��¥Ÿ���� �ú��ʱ���
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD';

-- sysdate ���糯¥������ ��, �ú��ʴ� 00:00:00���� �񱳵ǹǷ� no data
SELECT * FROM dt_typ
WHERE c1 = TO_DATE('2024/07/03','YYYY/MM/DD') ;

-- sysdate ���糯¥�� �ú��ʱ��� �����ؾ���
SELECT * FROM dt_typ
WHERE c1 = TO_DATE('2024/07/03 16:18:38','YYYY/MM/DD HH24:MI:SS');

-- ����� �ú��ʰ� �𸦰�� to_char�̿��ϰų� between���� �˻�����
select * from dt_typ
where to_char(c1, 'YYYY/MM/DD') = '2024/07/03';

SELECT * FROM dt_typ
WHERE c1 BETWEEN TO_DATE('2024/07/03 00:00:00','YYYY/MM/DD HH24:MI:SS')
AND TO_DATE('2024/07/03 23:59:59','YYYY/MM/DD HH24:MI:SS') ;


