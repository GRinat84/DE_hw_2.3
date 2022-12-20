-- 6.1 Уникальный номер сотрудника, его ФИО и стаж работы – для всех сотрудников компании

select
	e.id
	,concat(e.last_name, ' ', e.first_name, ' ', e.middle_name)
	,age(CURRENT_DATE, e.date_from) as work_days
from employees e

-- 6.2 Уникальный номер сотрудника, его ФИО и стаж работы – только первых 3-х сотрудников

select
	e.id
	,concat(e.last_name, ' ', e.first_name, ' ', e.middle_name)
	,age(CURRENT_DATE, e.date_from) as work_days
from employees e
limit 3

-- 6.3 Уникальный номер сотрудников - водителей

select
	e.id
from positions p
inner join employees e
	on e.position_id = p.id
where p.name = 'Разработчик'

-- 6.4 Выведите номера сотрудников, которые хотя бы за 1 квартал получили оценку D или E
select distinct
	employee_id
from employee_grades eg
inner join grades g
	on g.id = eg.grade_id
		and g.name in ('D', 'E')

-- 6.5 Выведите самую высокую зарплату в компании.

select
	max(e.salary)
from employees e

-- 6.6 * Выведите название самого крупного отдела

select
	d.name
from 
(
	select
		e.department_id
		,count(*) as empl_count
	from employees e
	group by
		e.department_id
) t
left join departments d
	on d.id = t.department_id
order by t.empl_count desc
limit 1

-- 6.7 * Выведите номера сотрудников от самых опытных до вновь прибывших

select
	e.id
from employees e
order by age(CURRENT_DATE, e.date_from) desc

-- 6.8 * Рассчитайте среднюю зарплату для каждого уровня сотрудников

select
	l.name
	,t.salary
from
(
	select
		e.level_id
		,avg(e.salary) as salary
	from employees e
	group by
		level_id
	order by level_id asc
) t
left join levels l
	on l.id = t.level_id

/* 6.9 * Добавьте столбец с информацией о коэффициенте годовой премии к основной таблице. Коэффициент рассчитывается по такой схеме: базовое значение коэффициента – 1, каждая оценка действует на коэффициент так:
·         Е – минус 20%
·         D – минус 10%
·         С – без изменений
·         B – плюс 10%
·         A – плюс 20%
Соответственно, сотрудник с оценками А, В, С, D – должен получить коэффициент 1.2.
*/

select
	t.employee_id
	,concat(e.last_name, ' ', e.first_name, ' ', e.middle_name)
	,p.name
	,t.grade_shift
from
(
	select
		e.id as employee_id
		,sum(g.grade_shift) as grade_shift
	from employees e
	left join employee_grades eg
		on eg.employee_id = e.id
			and eg.year = 2022
	left join grades g
		on g.id = eg.grade_id
	group by
		e.id
) t
left join employees e
	on e.id = t.employee_id
left join positions p
	on p.id = e.position_id

	