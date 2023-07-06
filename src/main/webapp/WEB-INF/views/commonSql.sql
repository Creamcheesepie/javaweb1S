create table pointSetter(
	part			tinyint 		not null primary key,
	name			varchar(15)	not null,
	point			int					not null,
	cdate			datetime,
	c_reason	varchar(300)
)

desc pointSetter
insert into pointSetter values (1,'loginPoint',10,null,null);
insert into pointSetter values (2,'attendanceWrite',40,null,null);
select point from pointSetter where part = 1; 

create table

select count(*) from board2 B, member2 M where ${searchOption} like concat('%',#{searchStr},'%') and B.${searchOption} = #{searchStr} and category = #{category}