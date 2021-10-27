-- 1. Запрос на выборку
-- Выбирает из таблицы ИЗДАНИЯ информацию о 
-- доступных для подписки газетах, название 
-- которых начинается с буквы «П»
select distinct
	Editions.[Index]
	, Editions.[TypeEdition]
	, Editions.[NameEdition]
	, [Price]
from
	Editions
where
	Editions.TypeEdition like N'Газета' and Editions.NameEdition like N'П%';

-- 2. Запрос на выборку
-- Выбирает из таблицы ИЗДАНИЯ информацию об 
-- издании с заданным индексом. 
select
	*
from
	Editions
where
	Editions.[Index] = 98547;

-- 3. Запрос на выборку
-- Выбирает из таблицы ИЗДАНИЯ информацию обо 
-- всех изданиях, для которых цена 1 экземпляра 
-- есть значение из некоторого диапазона. 
select distinct
	*
from
	Editions
where
	Editions.[Price] between 100 and 500;

-- 4. Запрос на выборку
-- Выбирает из таблицы ИЗДАНИЯ информацию об 
-- изданиях, имеющих вид издания «газета», 
-- наименование которых начинается со слова 
-- «Земля».
select 
	*
from 
	Editions
where
	Editions.[TypeEdition] like N'Газета' and Editions.[NameEdition] like N'Земля%';

-- 5. Запрос на выборку
-- Выбирает из таблицы ИЗДАНИЯ информацию обо 
-- всех изданиях, для которых Длительность 
-- подписки равна 3 месяцам
select
	*
from
	Editions
where
	Editions.[CountMonthSub] = 3;

-- 6. Запрос на выборку
-- Выбирает из таблиц ИЗДАНИЯ информацию об
-- изданиях с заданным значением в поле Вид 
-- издания. 
select
	*
from
	Editions
where
	Editions.[TypeEdition] like N'Журнал';

-- 7. Запрос на выборку
-- Выбирает из таблицы ИЗДАНИЯ информацию об 
-- изданиях, для которых Длительность подписки
-- есть значение из диапазона от 1 до 6 месяцев. 
select
	*
from
	Editions
where
	Editions.[CountMonthSub] between 1 and 6

-- 8. Итоговый запрос – агрегатные функции
-- Выполняет группировку по полю Вид издания. 
-- Для каждого вида вычисляет среднюю цену 
-- 1 экземпляра
select
	Editions.[TypeEdition]
	, AVG(Editions.[Price]) as [AvgPrice]
from
	Editions
group by
	Editions.[TypeEdition];
	

-- 9. Итоговый запрос – агрегатные функции
-- Выполняет группировку по полю Вид издания.
-- Для каждого вида вычисляет максимальную и 
-- минимальную цену 1 экземпляра
select
	Editions.[TypeEdition]
	, MIN(Editions.[Price]) as [MinPrice]
from
	Editions
group by
	Editions.[TypeEdition];

-- 10. Итоговый запрос – агрегатные функции
-- Выполняет группировку по полю Длительность 
-- подписки. Для каждого срока вычисляет 
-- среднюю цену 1 экземпляра
select
	Editions.[CountMonthSub]
	, AVG(Editions.[Price]) as [AvgPrice]
from
	Editions
group by
	Editions.[CountMonthSub];