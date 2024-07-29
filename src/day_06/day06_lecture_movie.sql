use moviedb;
create table movietbl (
	movie_id int, 
    movie_title varchar(30), 
    movie_director varchar(20),
    movie_star varchar(20),
    movie_script longtext,
    movie_film longblob
) default charset = utf8mb4;


-- 저장 가능한 최대 파일 크기 확인 / 파일 저장 경로 확인
SHOW variables like 'max_allowed_packet';   
SHOW variables like 'secure_file_priv'; 

/*
- 최대 저장할 수 있는 패킷 크기 (최대 파일 크기) 보다 파일의 크기가 크면 저장이 안됨
	1) my.ini 파일의 max_allowed_packet 값을 알맞게 지정 (1MB -> 1GB)
	2) 파일을 업로드/다운로드 할 폴더 경로를 별도로 설정
	   가장 밑에 있는 경로에 있는 파일을 업로드할 수 있고 해당 경로에 다운로드 한다
		
        # Secure File Priv.
			secure-file-priv="C:/ProgramData/MySQL/MySQL Server 8.0/Uploads"
			secure-file-priv="C:/study/database/blob/movies"
*/

-- movietbl에 파일 업로드하기
insert into movietbl values(1, '쉰들러리스트', '스티븐 스필버그', '리암 니슨', load_file('C:/study/database/blob/movies/schindler_txt.txt'), load_file('C:/study/database/blob/movies/schindler_clip.mp4'));
insert into movietbl values(2, '쇼생크탈출', '프랭크 다라본트', '팀 로빈스', load_file('C:/study/database/blob/movies/shawshank_txt.txt'), load_file('C:/study/database/blob/movies/shawshank_clip.mp4'));
insert into movietbl values(3, '라스트모히칸', '마이클 만', '다니엘 데이 루이스', load_file('C:/study/database/blob/movies/lastmohican_txt.txt'), load_file('C:/study/database/blob/movies/lastmohican_clip.mp4'));

-- DB의 파일을 다운로드하기
select movie_script from movietbl where movie_id = 1 
into outfile 'C:/study/database/blob/movies/schindler_out_text.txt'
lines terminated by '\\n'; -- 줄바꿈 문자도 그대로 다운받아서 저장한다. 옵션 

select movie_film from movietbl where movie_id = 1
into dumpfile 'C:/study/database/blob/movies/schindler_out_downloaded.mp4';

drop table movietbl;
drop database moviedb;
