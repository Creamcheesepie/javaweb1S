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

create table gether2_review


	

