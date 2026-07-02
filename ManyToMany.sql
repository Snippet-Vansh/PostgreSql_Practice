create table students (
student_id int primary key,
student_name varchar(100)
);


insert into students(student_id,student_name)values
(1,'Vansh'),
(2,'Ashok'),
(3,'Lucky');

create table courses (
course_id int primary key,
course_name varchar(100)
);

insert into courses(course_id,course_name)
values
(101,'Python'),
(102,'Java'),
(103,'SQL');

select *  from courses;

create table student_courses (
student_id int,
course_id int,
primary key (student_id,course_id),
foreign key (student_id) references students(student_id),
foreign key(course_id) references courses(course_id)
);

insert into student_courses (student_id,course_id)
values
(1,101), -- Vansh -> Python
(1,102), -- Vansh -> SQL
(2,101), -- Ashok -> Java
(2,103), -- Ashok -> SQL
(3,102); -- Lucky -> Python


select
s.student_name,
c.course_name
from
student_courses sc join students s on sc.student_id = s.student_id
join courses c on sc.course_id = c.course_id;