create table student (
student_id int,
name varchar(100),
age smallint,
);

select * from student;
insert into student(name,age)
values ('Tanishk',21);


             Alter -:

			 
alter table student
add column email varchar(100);

alter table student
drop column email;

alter table student
add column email varchar(100) default 'not provided';

alter table student 
rename column name to full_name;

alter table student
alter column age type smallint;

alter table student
alter column age set default 18;

alter table student
alter column age drop default; 

alter table student
add constraint age_check check (age >= 0);

alter table student
drop constraint age_check;

alter table student
rename to school_students;


alter table student
rename to school;

select * from school;