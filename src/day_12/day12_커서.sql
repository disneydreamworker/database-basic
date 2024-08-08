-- 커서
delimiter $$
create procedure a()
begin 
end $$
delimiter ;


delimiter $$
create procedure cursorProc()
begin 
	declare cheight int; -- 고객키 
    declare cnt int default 0; -- 인원
    declare totalheight int default 0; -- 키 합계
    
    declare endofrow boolean default false; -- 테이블 행의 끝 여부이고 기본은 f
    declare ucursor cursor for      
		select height from usertbl; -- 커서가 오픈할 대상을 선언
	declare continue handler for not found set endofrow = true; -- 행의 끝에 도달하면 true로 대입
    
    open ucursor;
		c_loop : loop
				fetch ucursor into cheight;
					if endofrow then 
						leave c_loop;
					end if;
				set cnt = cnt + 1;
                set totalheight = totalheight+cheight;
				end loop c_loop;
		select concat('키 평균 = ' , totalheight/cnt);
        
	close ucursor;    
end $$
delimiter ;

call cursorProc;