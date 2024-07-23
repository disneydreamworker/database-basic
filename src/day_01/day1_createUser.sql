-- user : ssg 생성 스크립트
create user ssg@localhost identified by '0000';
create user hr@localhost identified by 'hr'; 
create user hr@'%' identified by 'hr';

-- 권한 부여하기
grant all privileges on ssg.* to ssg@localhost with grant option;
grant all privileges on hr.* to hr@localhost with grant option;
grant all privileges on hr.* to hr@'%' with grant option;

flush privileges;
show grants for hr@localhost;
 