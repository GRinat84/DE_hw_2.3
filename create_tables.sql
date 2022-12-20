create table employees
(
	id serial primary key,
	first_name character varying(30),
	last_name character varying(30),
	middle_name character varying(30),
	birthday date,
	date_from date,
	position_id int,
	level_id int,
	salary integer,
	department_id int,
	is_has_rights bit
);

create table positions
(
	id serial primary key,
	name character varying(60)
);

create table levels
(
	id serial primary key,
	name character varying(30)
);

create table departments
(
	id serial primary key,
	name character varying(60),
	head_employee_id int not null
);

create table grades
(
	id serial primary key,
	name character varying(60)
);

create table employee_grades
(
	employee_id int not null,
	year int not null,
	quater int not null,
	grade int not null
);

alter table grades
add grade_shift float not null default(0.0)
