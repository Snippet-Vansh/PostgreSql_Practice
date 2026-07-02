


create table student (
student_id serial primary  key,
name varchar(100)  not null
);

select * from student;

insert into student (name)
values ('Vansh'),
('Tanishk'),
('aman');


select * from student_profile;

create table student_profile (
student_id int primary key,
address text,
age int,
phone varchar(10)
);

insert into student_profile(student_id,address,age,phone)
values
(1,'Delhi,India',22,'1234567890')
(2,'Pune,India',21,'1234567890')
(3,'Chennai,India',23,'1234567')


alter table student_profile
add constraint fk_student_id
foreign key (student_id)
references student(student_id);

select
s.student_id,
s.name,
sp.address,
sp.age,
sp.phone
from student s
join student_profile sp
on s.student_id = sp.student_id;


create table marks(
marks_id serial primary key,
student_id int,
subject varchar(50),
marks int,
foreign key (student_id) references student(student_id)
);

insert into marks(student_id,subject,marks)
values
(1,'English',45),
(1,'Hindi',54),
(1,'Maths',99),

(2,'English',15),
(2,'Hindi',24),
(2,'Maths',39),

(3,'English',5),
(3,'Hindi',4),
(3,'Maths',0);

select * from marks;

select * from student s
join marks m
on s.student_id = m.student_id;

select s.name,m.subject,m.marks from student s
left join marks m
on s.student_id = m.student_id;
-- where name = 'Vansh'

select s.name,m.subject,m.marks from student s
full join marks m
on s.student_id = m.student_id;

insert into student(name)
values ('sintu');

insert into marks(student_id,subject,marks)
values (4,'English',89),
(4,'Hindi',89),
(4,'Maths',89);


