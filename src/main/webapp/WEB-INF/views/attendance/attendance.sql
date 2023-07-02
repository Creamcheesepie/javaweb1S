

create table attendance(
	att_idx				int						not null primary key auto_increment,
	m_idx					int						not null,
	content				varchar(300)  not null,
	wdate					datetime			not null default now(),
	cdate					datetime			default now(),
	ddate					datetime			default now(),
	hostIp				varchar(40)		not null,
	foreign key(m_idx) references member2(m_idx)
	on update cascade
	on delete restrict
)

insert into attendance values(default, 1,"출석기능 테스트입니다.",default,null, null, '192.168.50.88');

select A.att_idx,M.nickName,A.content,A.wdate from member2 M , attendance A where M.m_idx = A.m_idx;
