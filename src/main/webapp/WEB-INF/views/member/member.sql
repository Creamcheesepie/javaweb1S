show tables

create table member2(
	m_idx 			int 					not null primary key auto_increment,
	
	mid					varchar(20)		not null,
	pwd					varchar(100) 	not	null,
	nickName		varchar(15)		not null,
	name				varchar(30)		not	null,
	email				varchar(50)		not null,
	
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

drop table member2;
desc member2;

update member2 set point=point+1*10 where m_idx=1;
