create table pointSetter(
	part			tinyint 		not null primary key,
	name			varchar(15)	not null,
	point			int					not null,
	cdate			datetime,
	c_reason	varchar(300)
)

desc pointSetter
insert into pointSetter values (1,'loginPoint',10,null,null);
select point from pointSetter where part = 1; 