create table board2_category(
	category				tinyint					not null primary key,
	name						varchar(20)			not null,
	wdate						datetime				not null default now(),
	cdate						datetime				default now(),
	stat						tinyint					not null default 0
)

desc board2_category;
select * from board2_category;

insert into board2_category values (1, '공지사항',default,null,default);
insert into board2_category values (2, '새 소식',default,null,default);
insert into board2_category values (126, '삭제글 보관함',default,null,default);
insert into board2_category values (127, '신고글 보관함',default, null, default);



create table board2(
	boa_idx				int						not null primary key auto_increment,
	m_idx					int						not null,
	title					varchar(40)		not	null,
	content				text					not	null,
	viewCnt				int						not	null default 0,
	recommendCnt	int						not null default 0,
	wdate					datetime			not null default now(),
	cdate					datetime			default now(),
	ddate					datetime			default now(),
	category			tinyint				noy null,
	
	
)
