create table gether2(
	get_idx					int 					not null primary key auto_increment,
	m_idx						int						not null,
	title						varchar(30) 	not null,
	content					text					not null,
	location				varchar(30)		not null,
	getherType			tinyInt				not null,
	totalMember			int						not null,
	nowMember				int						not null default 1,
	gpxfile					varchar(100)	not null,
	useTime					int						not null,
	distance				int						not null,
	getHeight				int						not null,
	detailCourse		varchar(500)	not null,
	getherTime			datetime			not null,
	wdate						datetime			not null default now(),
	cdate						datetime,
	ddate						datetime,
	foreign key(m_idx) references member2(m_idx)
	on update cascade
	on delete restrict
)

drop table gether2

create table gether2_member(
	get_idx					int						not null,
	m_idx						int						not null,
	join_date				datetime			default now() not null,
	speed						int						not null,
	distance				int						not null,
	getHeight				int						not null,
	clear						tinyint				default '0',
	foreign key(get_idx) references gether2(get_idx)
	on update cascade
	on delete restrict,
	foreign key(m_idx) references member2(m_idx)
	on update cascade
	on delete restrict
)

drop table gether2_member

create table gether2_review(
	ger_idx					int						not null primary key auto_increment,
	get_title				varchar(30)		not null,
	get_idx					int						not null,
	m_idx						int						not null,
	title						varchar(30)		not null,
	content					text					not null,
	mainImage				varchar(100)	not null,
	speed						int						not null,
	getHeight				int						not null,
	distance				int						not	null,
	clear						int						not null,
	foreign key(m_idx) references member2(m_idx)
	on update cascade
	on delete restrict
)

select
	B.nickName,
	sum(A.distance) as distance
from
	gether2_member A,
	member2 B,
	gether2 C
where
		A.m_idx = B.m_idx
	and
		A.get_idx = C.get_idx
	and
		C.getherTime
	between
		last_day(now() - interval 2 month) + interval 1 day
	and
		last_day(now() - interval 1 month)
	order by distance desc
limit 1;

SELECT B.nickname,
       Sum(A.distance) AS distance
FROM   gether2_member A,
       member2 B,
       gether2 C
WHERE  A.m_idx = B.m_idx
       AND A.get_idx = C.get_idx
       AND C.gethertime BETWEEN Last_day(Now() - INTERVAL 2 month) + INTERVAL 1 day 
       											AND Last_day(Now() - INTERVAL 1 month)
ORDER  BY distance DESC
LIMIT  1; 

