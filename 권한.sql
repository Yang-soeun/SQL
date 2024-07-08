select * from session_roles;

create user ryu  --> user ����
identified by oracle;

grant create session to ryu;

select * from dba_users;

--> �̷��� �ʿ��� �ϳ��ϳ� , �� �����ؼ� ����ϸ� �����
grant create session, create table, select any table 
to ryu;

create role manager; --> �׷��� role�� �ְ�
grant create session, create table, create view
to manager; --> manager���� ������ �ο��� ����

-- ���ѵ��� ������ ���� manager role�� user���� �ο��ϴ� ������� �Ѵ�!!
grant manager to ryu;

-- �ý��� ����
select * from dba_sys_privs; --> ������ �������� ��� �Ѿ���� Ȯ��(�ߺ��� ���� �� ����)
select distinct privilege from dba_sys_privs; --> �ߺ� ����

-- ��ü ����
select * from dba_tab_privs;
select distinct privilege from dba_tab_privs;

select * from dba_roles;

-- user ���� ���� ����
-- db �������� ����, �ٸ� user�� password�� �Ұ���  
alter user ryu
identified by oracle;

grant create session to ryu with admin option;

select * from dba_profiles;

select * from dba_users
where username = 'RYU';

alter user ryu
quota 10M on system;

create table ryu.employees as select * from hr.employees;

select * from v$session; --> ���� db�� ���ӵ� ����ڵ�

select * from v$session where username = 'RYU';

alter system kill session '110, 877'; --> SID, SERIAL

drop user ryu cascade; --> ���̺��� ������� �ִٸ� ������ cascade �ٿ�����
