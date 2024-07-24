drop database carrent;
create database carrent;
use carrent;


-- 캠핑카 대여 회사 릴레이션 생성
drop table camper_rental_company;
CREATE TABLE camper_rental_company (
    c_rental_company_id INT UNSIGNED AUTO_INCREMENT COMMENT '캠핑카대여회사ID',
    c_rental_company_name VARCHAR(30) NOT NULL COMMENT '회사명',
    c_rental_company_address VARCHAR(40) NOT NULL COMMENT '주소',
    c_rental_company_contact VARCHAR(12) NOT NULL COMMENT '전화번호',
    c_rental_company_manager VARCHAR(20) NOT NULL COMMENT '담당자이름',
    c_rental_company_email VARCHAR(20) NOT NULL COMMENT '담당자이메일',
    PRIMARY KEY (c_rental_company_id) -- auto_increment 속성을 가지고 있는 칼럼이 있으면 반드시 primary key를 생성과 함께 지정해줘야 에러 안남
);


-- 고객 릴레이션 생성
DROP TABLE CLIENT;
CREATE TABLE client (
	client_driver_license VARCHAR(20) NOT NULL COMMENT '운전면허증',
	client_name	VARCHAR(20) NOT NULL COMMENT '고객명',
	client_address	VARCHAR(40) NOT NULL COMMENT '고객주소',
	client_contact	VARCHAR(12) NOT NULL COMMENT '고객전화번호',
	client_email VARCHAR(20) NOT NULL COMMENT '고객이메일', 
	client_previous_rent_date DATE COMMENT '이전캠핑카사용날짜',
	client_previous_rent_camper_type VARCHAR(40) COMMENT '이전사용캠핑카종류'
);

ALTER TABLE client ADD CONSTRAINT client_pk PRIMARY KEY(client_driver_license); -- 운전면허증 애트리뷰트를 식별키로 설정


-- 캠핑카 정비소 릴레이션 생성
DROP TABLE camper_maintenace_company;
CREATE TABLE camper_maintenace_company (
	c_maintenance_company_id INT UNSIGNED AUTO_INCREMENT COMMENT '캠핑카정비소ID',
	c_maintenance_company_name	VARCHAR(30) NOT NULL COMMENT '정비소명',
	c_maintenance_company_address	VARCHAR(40) NOT NULL COMMENT '정비소주소',
	c_maintenance_company_contact	VARCHAR(12) NOT NULL COMMENT '정비소전화번호',
	c_maintenance_company_manager	VARCHAR(20) NOT NULL COMMENT '담당자이름',
	c_maintenance_company_email	VARCHAR(20) NOT NULL COMMENT '담당자이메일',
    PRIMARY KEY (c_maintenance_company_id)
);


-- 캠핑카 릴레이션 생성
DROP TABLE camper;
CREATE TABLE camper (
	camper_regi_id	INT UNSIGNED AUTO_INCREMENT COMMENT '캠핑카등록ID',
	c_rental_company_id	INT UNSIGNED NOT NULL COMMENT '캠핑카대여회사ID',
	camper_name	VARCHAR(20) NOT NULL COMMENT '캠핑카이름',
	camper_regi_number	VARCHAR(20) NOT NULL COMMENT '캠핑카차량번호',
	camper_capacity INT UNSIGNED NOT NULL COMMENT '캠핑카승차인원',
	camper_image VARCHAR(40) COMMENT '캠핑카이미지',
	camper_details	VARCHAR(40) COMMENT '캠핑카상세정보',
	camper_rent_fee	INT UNSIGNED NOT NULL COMMENT '캠핑카대여비용',
	camper_regi_date DATE NOT NULL COMMENT '캠핑카등록일자',
	PRIMARY KEY (camper_regi_id, c_rental_company_id) -- 복합키 설정
);

ALTER TABLE camper ADD CONSTRAINT c_id FOREIGN KEY (c_rental_company_id) REFERENCES camper_rental_company(c_rental_company_id); -- 캠핑카대여회사ID 속성을 캠핑카대여회사 릴레이션의 PK와 연결하여 FK로 지정


drop table camper_rent;
-- 캠핑카대여 릴레이션 생성
CREATE TABLE camper_rent (
	rental_id INT UNSIGNED AUTO_INCREMENT COMMENT '대여번호',
	camper_regi_id	INT UNSIGNED NOT NULL COMMENT '캠핑카등록ID',
	client_driver_license VARCHAR(20) NOT NULL COMMENT '운전면허증번호',
	c_rental_company_id	INT UNSIGNED NOT NULL COMMENT '캠핑카대여회사ID',
	rental_start_date DATE NOT NULL COMMENT '대여시작일',
	rental_period DATE NOT NULL COMMENT '대여기간',
	rental_bill_charges	INT UNSIGNED NOT NULL COMMENT '청구요금',
	rental_payment_due DATE NOT NULL COMMENT '납입기한',
	extra_bill_breakdown VARCHAR(40) COMMENT '기타청구내역', 
	extra_bill_charges INT UNSIGNED COMMENT '기타청구요금',
    PRIMARY KEY (rental_id)
);


drop table camper_maintenance_info;
-- 캠핑카정비정보 릴레이션 생성
CREATE TABLE camper_maintenance_info (
	maintenance_id	INT UNSIGNED AUTO_INCREMENT COMMENT '정비번호',
	camper_regi_id	INT UNSIGNED NOT NULL COMMENT '캠핑카등록ID',
	c_maintenance_company_id	INT UNSIGNED NOT NULL COMMENT '캠핑카정비소ID',
	c_rental_company_id	INT UNSIGNED NOT NULL COMMENT '캠핑카대여회사ID',
	client_driver_license VARCHAR(20) NOT NULL COMMENT '고객운전면허증번호',
	maintenance_details	VARCHAR(40) NOT NULL COMMENT '정비내역',
	maintenance_date	DATE NOT NULL COMMENT '수리날짜',
	maintenance_fee	INT UNSIGNED NOT NULL COMMENT '수리비용',
	maintenance_payment_due	DATE NOT NULL COMMENT '납입기한',
	extra_maintenance_details	VARCHAR(40) COMMENT	'기타정비내역',
    PRIMARY KEY (maintenance_id)
);

ALTER TABLE camper_maintenance_info ADD CONSTRAINT c_regi_id_fk FOREIGN KEY (camper_regi_id) REFERENCES camper(camper_regi_id);
ALTER TABLE camper_maintenance_info ADD CONSTRAINT  c_m_id_fk FOREIGN KEY (c_maintenance_company_id) REFERENCES camper_maintenace_company(c_maintenance_company_id);
ALTER TABLE camper_maintenance_info ADD CONSTRAINT c_r_id_fk FOREIGN KEY (c_rental_company_id) REFERENCES camper_rental_company(c_rental_company_id);
ALTER TABLE camper_maintenance_info ADD CONSTRAINT client_id_fk FOREIGN KEY (client_driver_license) REFERENCES client(client_driver_license);






