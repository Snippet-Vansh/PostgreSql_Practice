

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


 alter table student_profile
 add constraint fk_student_id
 foreign key (student_id)
 r