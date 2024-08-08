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


-- 문제 1
drop procedure CustomerGradeProc;
delimiter ^o^
create procedure CustomerGradeProc()
begin
select A.userId, sum(구매액) as 총구매액, 
	case
		when sum(구매액) >= 1500 then '최우수고객'
		when sum(구매액) >= 1000 then '우수고객'
		when sum(구매액) >= 1 then '일반고객'
        else '유령고객'
	end '고객등급'
from (
	select userID, sum(price*amount) as 구매액
	from buytbl
	group by userId, price
) as A right join usertbl B on A.userID = B.userID
group by A.userId
order by 구매액 desc;
end ^o^
delimiter ;

call CustomerGradeProc;


-- 문제 1-1
drop procedure CustomerGradeProc2;
delimiter ^o^
create procedure CustomerGradeProc2(in name varchar(10))
begin
	declare userName varchar(10);
    set userName = name;

	select A.userId, sum(price*amount) as 총구매액, 
		case
			when sum(price*amount) >= 1500 then '최우수고객'
			when sum(price*amount) >= 1000 then '우수고객'
			when sum(price*amount) >= 1 then '일반고객'
			else '유령고객'
		end '고객등급'
	from buytbl A right join usertbl B on A.userID = B.userID
    where B.name = userName
	group by A.userId;
end ^o^
delimiter ;

call CustomerGradeProc2('바비킴');


-- 1~100 의 합을 출력
drop procedure WhileProc1;
delimiter $$
create procedure WhileProc1()
begin
	declare i int;
    declare total int;
    
    set i = 1;
    set total = 0;
    
    while (i<=100) do
		set total = total+i;
        set i= i+1;
    end while;
    select total;
end $$
delimiter ;

call WhileProc1;


-- 1~100 의 합에서 7의 배수는 제외하고 누적값이 1000이 넘어가면 종료
drop procedure WhileProc2;
delimiter $$
create procedure WhileProc2()
begin
	declare i int;
    declare total int;
    
    set i = 1;
    set total = 0;
    
    myWhile: while (i<=100) do
		if (i%7=0) 
			then set i=i+1;
			iterate myWhile; -- 내가 지정한 그 위치로 다시 돌아가서 계속 진행한다. continue와 동일
        end if;
        
		set total = total+i;
        
        if (total > 1000)
			then leave myWhile; -- 내가 지정한 와일문을 종료한다. break와 동일
		end if;
        
        set i = i+1;
    end while;
    select total;
end $$
delimiter ;

call WhileProc2;


-- Exception 처리하기
drop procedure errProc;
delimiter $
create procedure errProc()
begin 
	declare continue handler for 1146 select '테이블이 존재하지 않습니다' as '메세지';
    select * from noTable;
end $
delimiter ;
call errProc();

