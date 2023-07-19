create table message2_category(
	msg_category		tinyint						not null primary key,
	name						varchar(100)						not null,
	wdate						datetime			not null default now(),
	cdate						datetime
)

drop table message2_category
insert into message2_category values(1,'대화',default,null)
insert into message2_category values(2,'질문',default,null)
insert into message2_category values(100,'답장',default,null)
insert into message2_category values(120,'친구신청',default,null)
insert into message2_category values(121,'신청답변',default,null)

create table message2(
	msg_idx					int						not null primary key auto_increment,
	m_idx						int						not null,
	receive_m_idx		int						not null,
	title						varchar(40)		not null,
	content					varchar(500)	not null,
	sdate						datetime			not null default now(),
	rdate						datetime,
	readSw					tinyint,
	msg_category		tinyint				not null,
	ddate						datetime,
	foreign key(msg_category) references message2_category(msg_category)
	on update cascade
	on delete restrict,
	foreign key(m_idx) references member2(m_idx)
	on update cascade
	on delete restrict
)
drop table message2

insert into message2 values(default,1,3,'좋습니다.','앞으로도 활발한 활동 기대하겠습니다.',default,null,null,1,null);
insert into message2 values(default,3,1,'어우 잘하겠습니다','넵넵',default,null,null,1,null);

create table 

create table report2_category(
	rep_category			tinyint			 not null primary key,
	name							varchar(100) not null,
	tableName					varchar(50)	 not null,
	idxName						varchar(10)	 not null,
	wdate							datetime		 not null default now(),
	cdate							datetime
)

drop table report2_category

insert into report2_category values(1,'상업게시글,광고','board2','boa_idx',default,null)
insert into report2_category values(2,'지나친 비방, 욕설','board2','boa_idx',default,null)
insert into report2_category values(3,'음란물, 선정성, 잔인함','board2','boa_idx',default,null)
insert into report2_category values(4,'도배글','board2','boa_idx',default,null)
insert into report2_category values(5,'분쟁유도','member2','m_idx',default,null);
insert into report2_category values(6,'광고글 다수 게시','member2','m_idx',default,null);
insert into report2_category values(7,'불법광고 게시','member2','m_idx',default,null);
insert into report2_category values(8,'댓글 도배','board2_reply','rep_idx',default,null);
insert into report2_category values(9,'분쟁유도','board2_reply','rep_idx',default,null);
insert into report2_category values(10,'불법광고 게시','board2_reply','rep_idx',default,null);
insert into report2_category values(11,'성희롱','board2_reply','rep_idx',default,null);

create table report2(
	rep_idx						int					not null primary key auto_increment,
	m_idx							int					not null,
	rep_category			tinyint 		not null,
	reported_idx			int					not null,
	title							varchar(40)	not null,
	content						varchar(500)not	null,
	wdate							datetime		not null default now(),
	tdate							datetime,	
	takeSw						tinyint,	
	tekecontent				text,
	ddate							datetime		not	null,
	foreign key(m_idx) references member2(m_idx)
	on update cascade
	on delete restrict,
	foreign key(rep_category) references report2_category(rep_category)
	on update cascade
	on delete restrict
)




create table ask2_category(
	ask_category			tinyint			not	null primary key,
	name							varchar(100)not	null,
	wdate							datetime		not	null default now(),
	cdate							datetime
)

insert into ask2_category values(1,'사이트 운영 규정',default,null);
insert into ask2_category values(2,'이용 제재 규칙',default,null);
insert into ask2_category values(3,'승급 조건',default,null);
insert into ask2_category values(99,'기타',default,null);


create table ask2(
	ask_idx						int					not null primary key auto_increment,
	m_idx							int					not	null,
	ask_category			tinyint			not	null,
	title							varchar(50) not	null,
	content						varchar(500)not	null,
	wdate							datetime		not null default now(),
	tdate							datetime,
	takeSw						tinyint,
	takeContent				text,
	ddate							datetime,
	foreign key(m_idx) references member2(m_idx)
	on update cascade
	on delete restrict,
	foreign key(ask_category) references ask2_category(ask_category)
	on update cascade
	on delete restrict
)

