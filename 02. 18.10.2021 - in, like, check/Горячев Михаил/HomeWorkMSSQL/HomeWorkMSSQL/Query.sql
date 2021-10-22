﻿-- 1. Запрос на выборку. Выбирает из таблицы Types все столбцы 
-- всех записей, упорядочить по названию вида страхования
select 
	*
from
	[Types]
order by
	[Name]
;

-- 2. Запрос на выборку. Выбирает из таблицы Clients информацию 
-- о клиентах, процент скидки для которых находится в диапазоне 
-- от 0,3% до 0,5% и фамилия начинается на «Рос»
select
	*
from 
	[Clients]
where
	([Discount] between 0.3 and 0.5) and [Surname] like N'Рос%'
;

-- 3. Запрос на выборку. Выбирает из таблицы Clients информацию 
-- о клиентах с процентом скидки 0,1% или 0,23% или 0,12%
-- Выводить идентификатор, фамилию, имя, отчество и процент 
-- скидки, упорядочить по фамилии клиентов
select
	[id]
	, [Surname]
	, [Name]
	, [Patronymic]
	, [Discount]
from
	[Clients]
where
	[Discount] in (0.1, 0.23, 0.12)
order by
	[Surname]
;

-- 4. Запрос на выборку. Выбирает из таблицы Types информацию о 
-- типах страхования имущества (должна присутствовать строка 
-- «имуществ»), упорядочить по убыванию цены  
select 
	*
from
	[Types]
where
	[Name] like N'%имуществ%'
order by
	[Price] desc
;

-- 5. Запрос на выборку. Выбирает из таблицы Clients информацию 
-- о клиентах, с годом рождения, большим 2000 и именами Павел 
-- или Полина. Выводить фамилию, имя, отчество и год рождения 
select 
	[Surname]
	, [Name]
	, [Patronymic]
	, [Year]
from
	Clients
where
	[Year] > 2000 and [Name] in (N'Павел', N'Полина')
;

-- 6. Запрос на выборку. Выбирает из таблицы Types информацию о 
-- видах страхования со стоимостью от 500 рублей до 1200 рублей, 
-- упорядочить по возрастанию цены 
select
	*
from
	[Types]
where
	[Price] between 500 and 1200
;

-- 7. Запрос на выборку. Выбирает из таблицы Clients информацию 
-- о клиентах, с годом рождения, меньшим 1996. Выводить 
-- идентификатор, фамилию, имя, отчество и год рождения.
-- Упорядочить по году рождения и фамилии
select
	[id]
	, [Surname]
	, [Name]
	, [Patronymic]
	, [Year]
from
	Clients
where
	[Year] < 1996
order by
	[Year], [Surname]