create table pointSetter(
	part			tinyint 		not null primary key,
	name			varchar(15)	not null,
	point			int					not null,
	cdate			datetime,
	c_reason	varchar(300)
)

desc pointSetter
insert into pointSetter values (1,'loginPoint',10,null,null);
insert into pointSetter values (3,'게시글작성',10,null,null);
insert into pointSetter values (2,'attendanceWrite',40,null,null);
insert into pointSetter values (4,'댓글 작성',5,null,null);

select point from pointSetter where part = 1; 

create table

select count(*) from board2 B, member2 M where ${searchOption} like concat('%',#{searchStr},'%') and B.${searchOption} = #{searchStr} and category = #{category}



create table ruleSetter(
	rule_idx				tinyint			not null primary key auto_increment,
	ruleName				varchar(60) not null,
	actionLimit			int					not	null,
	limitTime				datetime		not	null,
	penaltyTime			datetime		not	null,
	cdate						datetime,
	c_reason				varchar(500)
)

drop table ruleCntTimer

insert ruleSetter values(default,'게시판 도배 방지',10,'0000-00-00 00:05:00','0000-00-00 01:00:00',null,null);
insert ruleSetter values(default,'댓글 도배 방지',20,'0000-00-00 00:05:00','0000-00-00 00:10:00',null,null);

create table offenderList(
	off_idx 				int					not null primary key auto_increment,
	m_idx						int					not null,
	odate						datetime		not null,
	cdate						datetime		not null,
	rule_idx				tinyint		  not null,
	foreign key(m_idx) references member2(m_idx)
	on update cascade
	on delete restrict,
	foreign key(rule_idx) references ruleSetter(rule_idx)
	on update cascade
	on delete restrict
)

drop table offenderList


create table banList(
	ban_idx					int 				not null primary key auto_increment,
	m_idx						int					not null,
	banType					varchar(15) not null,
	cdate						datetime,
	wdate						datetime		default now(),
	reason					text				not	null,
	foreign key(m_idx) references member2(m_idx)
	on update cascade
	on delete restrict
)



