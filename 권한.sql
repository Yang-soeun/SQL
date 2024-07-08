select * from session_roles;

create user ryu  --> user 생성
identified by oracle;

grant create session to ryu;

select * from dba_users;

--> 이렇게 필요한 하나하나 , 로 구분해서 줘야하면 힘들다
grant create session, create table, select any table 
to ryu;

create role manager; --> 그래서 role을 주고
grant create session, create table, create view
to manager; --> manager에게 권한을 부여한 다음

-- 권한들의 묶음을 가진 manager role을 user에게 부여하는 방식으로 한다!!
grant manager to ryu;

-- 시스템 권한
select * from dba_sys_privs; --> 권한이 누구에게 어떻게 넘어갔는지 확인(중복이 있을 수 있음)
select distinct privilege from dba_sys_privs; --> 중복 제거

-- 객체 권한
select * from dba_tab_privs;
select distinct privilege from dba_tab_privs;

select * from dba_roles;

-- user 설정 정보 변경
-- db 관리가자 수행, 다른 user의 password는 불가능  
alter user ryu
identified by oracle;

grant create session to ryu with admin option;

select * from dba_profiles;

select * from dba_users
where username = 'RYU';

alter user ryu
quota 10M on system;

create table ryu.employees as select * from hr.employees;

select * from v$session; --> 현재 db에 접속된 사용자들

select * from v$session where username = 'RYU';

alter system kill session '110, 877'; --> SID, SERIAL

drop user ryu cascade; --> 테이블이 만들어져 있다면 오류남 cascade 붙여야함
