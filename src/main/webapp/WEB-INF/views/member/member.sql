fshow tables

create table member2(
	m_idx 			int 					not null primary key auto_increment,
	
	mid					varchar(20)		not null,
	pwd					varchar(100) 	not	null,
	nickName		varchar(15)		not null,
	name				varchar(30)		not	null,
	tel					varchar(16)		not null,
	
	address			varchar(100),
	age					int						not	null,
	gender			varchar(5),
	birthday		datetime,
	
	inst				varchar(300),
	photo				varchar(40),
	level				int 					not null default 4,
	point				int						not	null default 100,
	speed				int						not null,
	
	duration		int						not null,
	getheight		int						not null,
	totalCnt		int						not null default 0,
	todayCnt		int						not null default	0,
	signInDate	datetime			not	null default now(),
	lastVisit		datetime			not null default now(),
	memberDel		tinyint				not null default 0,
	infoSw			tinyint				not null default 0,
	QRcode			varchar(100)
)

create table email(
	m_idx 			int 					not null unique key,
	emailName		varchar(50)		not null,
	dom_idx			int						not null,
	cdate				datetime,
	foreign key(m_idx) references member2(m_idx)
	on update cascade
	on delete restrict,
	foreign key(dom_idx) references domain(dom_idx)
	on update cascade
	on delete restrict
)

insert int 

create table domain(
	dom_idx			int						not null primary key auto_increment,
	domain			varchar(50)				not null,
	add_date		datetime			not null default now(),
	cdate				datetime,
	ddate				datetime
)

select dom_idx, domain from domain;

insert into domain values(default, '@naver.com',default,null,null);
insert into domain values(default, '@google.com',default,null,null);
insert into domain values(default, '@hanmail.net',default,null,null);
insert into domain values(default, '@daum.net',default,null,null);
insert into domain values(default, '@Outlook.com',default,null,null);

drop table member2;
desc member2;

update member2 set point=point+1*10 where m_idx=1;

		insert into member2 A,email B values(default, #{vo.mid},#{vo.pwd},#{vo.nickName},#{vo.name},#{vo.tel},#{vo.address},#{vo.age},#{vo.gender},#{vo.birthday},#{vo.inst},#{vo.photo},default,default,#{vo.speed},#{vo.duration},#{vo.getHeight},default,default,default,default,default,default,#{vo.QRcode})
		

insert into email values ((select m_idx from member2 where mid='admin'),'gnldbs1004','1',null);

create table friendBanList(
	m_idx 			int							not null,
	t_idx				int							not null,
	status			tinyint					not null,
	extra				varchar(300) 		not null,
	setDate			datetime				not null default now(),
	foreign key(m_idx) references member2(m_idx)
	on update cascade
	on delete restrict
)
