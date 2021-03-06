create database tnp_database;
use tnp_database;
Create table students_general
(
	admno varchar(15) PRIMARY KEY,
	fullname varchar(50) NOT NULL,
	degree varchar(40) NOT NULL,
	branch varchar(40) NOT NULL,
	branchcode varchar(3) NOT NULL,
	admissionyear year NOT NULL,
	branchrollno int NOT NULL,
	category varchar(10) NOT NULL,
	dob date NOT NULL,
	gender varchar(10) NOT NULL,
	age numeric(2) NOT NULL,
	height numeric(3),
	weight numeric(3),
	ecact varchar(500),
	adinfo varchar(500)
);

Create table students_contact
(
	admno varchar(15) PRIMARY KEY,
	present_address varchar(200),
	present_mobileno varchar(20),
	present_phoneno varchar(20),
	present_email varchar(30),
	perm_address varchar(200) NOT NULL,
	perm_mobileno varchar(20) NOT NULL,
	perm_phoneno varchar(20) NOT NULL,
	perm_email varchar(30) NOT NULL,
	constraint fkey_studentscontact foreign key(admno) references students_general(admno) on delete cascade on update cascade


);
create table students_academic
(
	admno varchar(15) primary key,
	year10 year NOT NULL,
	perc10 float NOT NULL,
	board10 varchar(30) NOT NULL,
	year12 year NOT NULL,
	perc12 float NOT NULL,
	board12 varchar(30) NOT NULL,
	sgpa1 float NOT NULL,
	cgpa1 float NOT NULL,
	mysem1 date NOT NULL,
	sgpa2 float NOT NULL,
	cgpa2 float NOT NULL,
	mysem2 date NOT NULL,
	sgpa3 float NOT NULL,
	cgpa3 float NOT NULL,
	mysem3 date NOT NULL,
	sgpa4 float NOT NULL,
	cgpa4 float NOT NULL,
	
	mysem4 date NOT NULL,
	sgpa5 float,
	cgpa5 float,
	mysem5 date,
	sgpa6 float,
	cgpa6 float,
	mysem6 date,
	sgpa7 float,
	cgpa7 float,
	mysem7 date,
	sgpa8 float,
	cgpa8 float,
	mysem8 date,
	passfirstattempt varchar(5),
	passfirstattemptdetails varchar(200),
	topicseminar varchar(100),
	topicproject varchar(100),
	listelectives varchar(200) ,
	constraint fkey_studentsacademic foreign key(admno) references students_general(admno) on delete cascade on update cascade

);
create table students_training
(	
	admno varchar(15) NOT NULL,
	nameofcompany varchar(50) NOT NULL,
	durationoftraining int NOT NULL,
	fieldoftraining varchar(100) NOT NULL,
	constraint fkey_studentstraining foreign key(admno) references students_general(admno) on delete cascade on update cascade

);


create table students_placement
(
	admno varchar(15),
	nameoforganisation varchar(100),
	recruiter_username varchar(50),
	dateofplacement date,
	primary key(admno,nameoforganisation,recruiter_username)
	
); 

create table students_resume
(
	admno varchar(15) primary key,
	filesize int NOT NULL,
	fileextension varchar(15) NOT NULL,
	filepath varchar(1000) NOT NULL
);

create table login_students
(
	username varchar(20) PRIMARY  KEY,
	password varchar(40) NOT NULL,
	createdon timestamp DEFAULT 0 ,
	lastlogin timestamp DEFAULT 0,
lastpasswordchange timestamp DEFAULT 0 NOT NULL

	

);
create table recruiters_data
(
	username varchar(50) PRIMARY KEY,
	
	nameoforganisation varchar(100) NOT NULL,
	address varchar(200) NOT NULL,
	contactno varchar(20)  NOT NULL,
	emailaddress varchar(50) NOT NULL
	
);
create table login_recruiters
(
	username varchar(50) PRIMARY KEY,
	password varchar(40) NOT NULL,
	createdon timestamp DEFAULT 0,
	lastlogin timestamp DEFAULT 0,
	lastpasswordchange timestamp DEFAULT 0 NOT NULL


);
create table login_admin
( 	
	username varchar(20) PRIMARY KEY,
	password varchar(40) NOT NULL,
	createdon timestamp  DEFAULT 0 NOT NULL,
	lastlogin timestamp DEFAULT  0,
	lastpasswordchange timestamp DEFAULT 0 NOT NULL
);

create view view_findstudents as select * from (( (students_general natural left outer join students_academic) natural left join students_contact )natural left outer join students_training);

create view view_placements as select admno,fullname,branch,degree,nameoforganisation,recruiter_username from students_general natural join students_placement;

grant all on tnp_database.* to 'admin_main'@'localhost' identified by 'password';
grant select on tnp_database.* to 'user_readonly'@'localhost' identified by 'password';
grant select on tnp_database.login_students to 'user_login'@'localhost' identified by 'password';
grant select on tnp_database.login_recruiters to 'user_login'@'localhost' identified by 'password';
grant update (lastlogin,password,lastpasswordchange) on tnp_database.login_students to 'user_login'@'localhost';
grant update (lastlogin,password,lastpasswordchange) on tnp_database.login_recruiters to 'user_login'@'localhost';


insert into login_admin values("admin",SHA1("password"),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP());

