/*
스토어드 프로시저
*/
use bookstore;

delimiter $$ -- 스토어드 프로시저의 끝을 구분하기 위해서 end $$가 나올 때까지 프로시저가 끝나지 않았다는 것을 의미하는 묶음 단위
create procedure userProc()
begin
	select * from usertbl;
end $$
delimiter ; -- delimiter를 ; 으로 변경해서 쿼리문의 끝을 알림

call userProc();

-- 파라미터 값을 주어서 입력 매개 변수를 지정하기
delimiter $$
create procedure userProc1(in userName varchar(10))
begin
	select * from usertbl where name = userName;
end $$
delimiter ; -- delimiter를 ; 으로 변경해서 쿼리문의 끝을 알림
call userProc1('조용필');

delimiter ^
create procedure userProc2(in userBirth int, in userHeight smallint)
begin
	select * from usertbl where birthYear >= userBirth and height >= userHeight;
end ^
delimiter ;
call userProc2(1970, 170);


-- 출력 매개 변수 지정하기 
create table testtbl (
	id int auto_increment primary key,
    txt char(10)
);

delimiter ^^
create procedure userProc3(in txt char(10), out outvalue int) -- 출력 매개변수 이름과 데이터 형식을 지정
begin 
	insert into testtbl values (null, txt);
    select max(id) into outvalue from testtbl; -- 주로 select into 문을 사용해서 출력 매개 변수에 값을 대입한다
end ^^
delimiter ;

call userProc3('테스트1', @myValue); -- 프로시저를 호출한다. 이때 out 변수명 앞에 @를 붙인다
select @myValue; -- 출력 매개 변수명으로 select 해서 출력한다


drop procedure whileEx;
-- while 문
delimiter $$
create procedure whileEx()
begin
	declare str varchar(100);
    declare k int;
    declare i int;
	while (i < 10) do
		set str = '';
        set k = 1;
		while (k < 10) do
			set str = concat(str, i, 'x', k, '=', (k*i));
			set k = k + 1;
		end while;
        set i= i+1;
        end while;
end $$
delimiter ;
call whileEx();

-- 존재하는 프로시저 확인하기
select * from information_schema.routines where routine_schema = 'bookstore' and routine_type = 'procedure';
select * from information_schema.parameters where specific_name = 'userProc3';
show create procedure bookstore.userProc3;


drop procedure if exists tblProc;
delimiter ^^
create procedure tblProc(in tblName varchar(30)) 
begin
	set @sqlquery = concat('select * from ', tblName); -- 동적 쿼리 생성하기
    prepare myQuery from @sqlquery;
    execute myQuery;
    deallocate prepare myquery;
end ^^
delimiter ;
call tblProc('buytbl');
call tblProc('orders');
call tblProc('customer');

delimiter ^^
create procedure gradeProc(in score int) 
begin
	declare point int;
    declare credit char(1);
    set point = score;
    
	case 
		when point >= 90 then set credit = 'A';
		when point >= 80 then set credit = 'B';
		when point >= 70 then set credit = 'C';
		when point >= 60 then set credit = 'D';
		else set credit = 'F';
	end case;
	
	select concat('당신의 학점은 ===> ', credit, '입니다');
end ^^
delimiter ;
call gradeProc(90);
call gradeProc(40);
call gradeProc(70);
call gradeProc(80);

delimiter ^^
create procedure gradeProc2(in score int, out print varchar(30)) 
begin
	declare point int;
    declare credit char(1);
    set point = score;
    
	case 
		when point >= 90 then set credit = 'A';
		when point >= 80 then set credit = 'B';
		when point >= 70 then set credit = 'C';
		when point >= 60 then set credit = 'D';
		else set credit = 'F';
	end case;
	
	select concat('당신의 학점은 ===> ', credit, '입니다') into print;
end ^^
delimiter ;
call gradeProc2(90, @print);
select @print;
call gradeProc2(40, @print);
select @print;

