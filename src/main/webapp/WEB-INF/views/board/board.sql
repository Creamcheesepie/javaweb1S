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
insert into board2_category values (3, '잡담',default,null,default);
insert into board2_category values (4, '일상',default,null,default);
insert into board2_category values (126, '삭제글 보관함',default,null,default);
insert into board2_category values (127, '신고글 보관함',default, null, default);
select category,name,stat from board2_category where category>2 and category<100 ;


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
	category			tinyint				not null,
	foreign key(m_idx) references member2(m_idx)
	on update cascade
	on delete restrict,
	foreign key(category) references board2_category(category)
	on update cascade
	on delete restrict
)
	insert into board2 values(default,1,'공지 게시판 테스트 중입니다2.','테스트 테스트합니다22',default,default,default,null,null,1);

create table board2_reply(
	rep_idx				int						not null primary key auto_increment,
	boa_idx				int						not null,
	m_idx					int						not null,
	content				varchar(400)	not null,
	rep_group			int						not null,
	rep_level			int						not null,
	wdate					datetime			not null default now(),
	cdate					datetime			default now(),
	ddate					datetime			default now(),
	foreign key(boa_idx) references board2(boa_idx)
	on update cascade
	on delete restrict,
	foreign key(m_idx) references member2(m_idx)
	on update cascade
	on delete restrict
)


		select 
				B.boa_idx,
				B.m_idx,
				M.nickName,
				M.name,
				M.mid,
				B.content,
				B.viewCnt,
				B.recommendCnt,
				B.wdate,
				B.cdate,
				B.ddate,
				B.category,
				C.name as categoryName
			from 
			 board2 B, member2 M, board2_category C 
			 		where M.m_idx = B.m_idx 
			 		and B.category = C.category 
			 	order by B.boa_idx 
			 	limit 0, 10;
