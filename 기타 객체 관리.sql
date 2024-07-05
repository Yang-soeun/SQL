-- Data dictionary
select * from user_tables; --> hr user가 소유한 테이블 정보

select * from dictionary; --> 테이블 이름과 테이블 설명
select * from dict; 

select * from dictionary
where table_name like '%TABLE%';

select count(*) from user_tables;

select count(*) from all_tables;

select count(*) from dba_tables; --> system user로 접속해야함

--
