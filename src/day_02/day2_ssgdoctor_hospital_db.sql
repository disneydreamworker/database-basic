create table doctors (
	doctor_id int unsigned not null,
    medical_subject varchar(20) not null,
    doctor_name varchar(30) not null,
    doctor_gender char(2) not null,
    phone_number varchar(20),
    email varchar(30),
    title varchar(20),
    primary key (doctor_id)    
);


create table nurses (
	nurse_id int unsigned not null,
    position varchar(20) not null,
    nurse_name varchar(30) not null,
    nurse_gender char(2) not null,
    phone_number varchar(20),
    email varchar(30),
    title varchar(20),
    primary key (nurse_id)    
);

alter table nurses modify column position varchar(20) not null;

-- 환자 테이블
create table patients (
	patient_id int unsigned not null,				-- 환자 번호
    nurse_id int unsigned not null,
    doctor_id int unsigned not null, 
    patient_name varchar(30) not null,	
    patient_gender char(2) not null,
    registration_number varchar(20) not null,
    address varchar(40),
    phone_number varchar(20),
    email varchar(30),
    occupation varchar(20),
    primary key (patient_id),
    FOREIGN KEY (nurse_id) REFERENCES nurses(nurse_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);


-- 진료 테이블
create table examination (
	examination_id int unsigned not null,	
    patient_id int unsigned not null,
    doctor_id int unsigned not null,
    examination_details varchar(100),
    examination_date date,
	constraint examination_pk primary key (examination_id, patient_id, doctor_id),
	FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);	


-- chart table
create table chart (
	chart_id int unsigned not null,
    examination_id int unsigned not null,
    patient_id int unsigned not null,
    doctor_id int unsigned not null,
    nurse_id int unsigned not null,
    charts_details varchar(100),
	constraint chart_pk primary key (chart_id, examination_id, patient_id, doctor_id),
	FOREIGN KEY (examination_id) REFERENCES examination(examination_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (nurse_id) REFERENCES nurses(nurse_id)
);
