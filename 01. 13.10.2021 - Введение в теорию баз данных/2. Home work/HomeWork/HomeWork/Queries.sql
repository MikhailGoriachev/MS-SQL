-- 1. Запрос на выборку. Выбирает из таблицы Clients все столбцы всех записей
select 
	*
from
	Clients;

-- 2. Запрос на выборку. Выбирает из таблицы Clients информацию о клиентах, 
-- процент скидки для которых находится в диапазоне от 0,3% до 0,5 %
-- (between 0.3 and 0.5)
select
	*
from
	Clients
where
	Discount between 0.3 and 0.5;

-- 3. Запрос на выборку. Выбирает из таблицы Clients информацию о клиентах 
-- с процентом скидки, меньшим 0,3%. Выводить идентификатор, фамилию, имя, 
-- отчество и процент скидки
select 
	Id
	, Surname
	, Name
	, Patronymic
	, Discount
from
	Clients
where
	Discount < 0.3;

-- 4. Запрос на выборку. Выбирает из таблицы Clients информацию о клиентах 
-- с процентом скидки, большим 0,6%. Выводить все поля 
select 
	*
from
	Clients
where
	Discount > 0.6;

-- 5. Запрос на выборку. Выбирает из таблицы Clients информацию о клиентах, 
-- с годом рождения, большим 2000. Выводить фамилию, имя, отчество и год 
-- рождения 
select
	Surname
	, Name
	, Patronymic
	, Year
from
	Clients
where
	Year > 2000;

-- 6. Запрос на выборку. Выбирает из таблицы Clients информацию о клиентах 
-- с годом рождения в диапазоне от 1960 до 1996. Выводить все поля таблицы 
select
	*
from
	Clients
where
	Year between 1960 and 1996;

-- 7. Запрос на выборку. Выбирает из таблицы Clients информацию о клиентах, 
-- с годом рождения, меньшим 1996. Выводить идентификатор, фамилию, имя, 
-- отчество и год рождения
select
	Id
	, Surname
	, Name
	, Patronymic
	, Year
from
	Clients
where
	Year < 1996;