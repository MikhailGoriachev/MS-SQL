/* 
Представления - view - виртуальные таблицы
☼ часть таблиц БД, с которой можно работать как с единым целым
☼ можно изменять представление, при этом меняются связанные с ним таблицы

Синтаксис создания представления
create view имяПредставления as
	select списокПолей
	from   списокТаблиц	
	where  условия
	with check option  -- не обязателен, для изменения данных через представления

Синтаксис изменения представления
alter view имяПредставления as
	select списокПолей
	from   списокТаблиц	
	where  условия
	with check option  -- не обязателен, для изменения данных чеерз представления

Синтаксис удаления представления
drop view имяПредставления

Ограничния представлений
ограничения на использование выражения ORDER BY - использовать только вместе с top

Несмотря на удобство использования представлений, кроме ограничения на использование 
выражения ORDER BY существует еще ряд существенных ограничений:
    ■ нельзя использовать в качестве источника данных
      набор, полученный в результате выполнения хранимых процедур;
    ■ при создании представления оператор SELECT не должен содержать 
	  операторы COMPUTE или COMPUTE BY;
    ■ представление не может ссылатся на временные таблицы, поэтому в операторе создания 
	  ЗАПРЕЩЕНО использовать оператор SELECT INTO;
    ■ данные, которые используются представлением, не сохраняются отдельно, поэтому при 
	  изменении данных представления меняются данные базовых таблиц;
    ■ представление не может ссылаться больше, чем на 1024 поля;
    ■ UNION и UNION ALL недопустимы при формировании представлений.
	
Условия создания модифицированных (insert, delete, update) представлений:
    ■ все модификации должны касаться только одной таблицы, то есть модифицированные 
	  представления строятся только на однотабличних запросах;
    ■ все изменения должны касаться только полей таблицы, а не производных полей. 
	  То есть, нельзя модифицировать поля, полученые:
          • с помощью агрегатной функции: AVG, COUNT, SUM, MIN, MAX, 
		    GROUPING, STDEV, STDEVP, VAR и VARP;
          • на основе расчетов с участием других полей или операций над полем, 
		    например substring. Поля, сформированные с помощью операторов UNION,
            UNION ALL, CROSSJOIN, EXCEPT и INTERSECT также считаются расчетными 
			и также не могут обновляться.
    ■ при определении представления нельзя использовать инструкции GROUP BY, 
	  HAVING и DISTINCT;
    ■ нельзя использовать опцию TOP вместе с инструкцией WITH CHECK OPTION, 
	  даже в подзапросах	
*/

-- вывод таблицы Brands (Модели_автомобилей)
select
	Brands.Id
	, Brands.Brand
from
	Brands;


-- вывод таблицы Colors (цвета)
select
	Colors.Id
	, Colors.Color
from
	Colors;


-- вывод таблицы Clients (Клиенты)
select
	Clients.Id
	, Clients.Surname
	, Clients.[Name]
	, Clients.Patronymic
	, Clients.Passport
from
	Clients;


-- вывод таблицы Cars (Машины)
select
	Cars.Id
	, Brands.Brand
	, Colors.Color
	, Cars.Plate
	, Cars.YearManuf
	, Cars.InshurancePay
	, Cars.Rental
from
	Cars inner join Brands on Cars.IdBrand = Brands.Id
		 inner join Colors on Cars.IdColor = Colors.Id;


-- вывод таблицы Rentals (Факты_проката)
select 
	Rentals.Id
	, Clients.Surname
	, Clients.[Name]
	, Clients.Patronymic
	, Clients.Passport
	, Brands.Brand
	, Colors.Color
	, Cars.Plate
	, Cars.YearManuf
	, Cars.InshurancePay
	, Cars.Rental
	, Rentals.DateStart
	, Rentals.Duration
from
	Rentals inner join Clients on Rentals.IdClient = Clients.Id
			inner join (Cars inner join Brands on Cars.IdBrand = Brands.Id
							 inner join Colors on Cars.IdColor = Colors.Id)
			on Rentals.IdCar = Cars.Id;

----------------------------------------------------------------------------------------------------

-- вывод предсталения таблицы Brands (Модели_автомобилей)
select
	*
from
	ViewBrands;


-- вывод предсталения таблицы Colors (цвета)
select
	*
from
	ViewColors;


-- вывод предсталения таблицы Clients (Клиенты)
select
	*
from
	ViewClients;


-- вывод предсталения таблицы Cars (Машины)
select
	*
from
	ViewCars;


-- вывод предсталения таблицы Rentals (Факты_проката)
select
	*
from
	ViewRentals;

----------------------------------------------------------------------------------------------------

-- 1	Запрос к представлению
-- Выбирает информацию обо всех фактах проката автомобиля с заданным госномером
-- АН4841ТС
-- НО7985ВТ
-- АС2194СН
-- СН9155ТС
-- АС9549ВТ
-- НО2315СН

declare @plate nvarchar(9) = N'НО7985ВТ';

select
	*
from
	ViewRentals
where
	Plate = @plate;
go

-- 2	Запрос к представлению
-- Выбирает информацию обо всех фактах проката автомобиля с заданной моделью/брендом
-- BMW X6
-- BMW E81
-- BMW E90
-- Mercedes-Benz W124AMG
-- Mercedes-Benz W906
-- Mercedes-Benz W221
-- Mercedes-Benz W414
-- Infiniti FX37
-- Infiniti G37
-- Infiniti JX3

declare @brand nvarchar(30) = N'BMW E81';

select
	*
from
	ViewRentals
where	
	Brand = @brand;
go


-- 3	Запрос к представлению
-- Выбирает информацию об автомобиле с заданным госномером
-- АН4841ТС
-- НО7985ВТ
-- АС2194СН
-- СН9155ТС
-- АС9549ВТ
-- НО2315СН

declare @plate nvarchar(9) = N'СН9155ТС';

select
	*
from
	ViewCars
where
	Plate = @plate;
go


-- 4	Запрос с параметром	
-- Выбирает информацию о клиентах по серии и номеру паспорта
-- ЕС45718
-- АВ34524
-- АТ65423
-- ВО12312
-- СК67443

declare @passport nvarchar(15) = N'ЕС45718';

select
	*
from
	ViewClients
where
	Passport = @passport;
go


-- 5	Запрос к представлению
-- Выбирает информацию обо всех зафиксированных фактах проката 
-- автомобилей в некоторый заданный интервал времени.
declare @dateLo date = '2021/11/03', @dateHi date = '2021/11/05';

select
	*
from
	ViewRentals
where
	DateStart between @dateLo and @dateHi;
go


-- 6	Запрос к представлению
-- Вычисляет для каждого факта проката стоимость проката.
-- Включает поля Дата проката, Госномер автомобиля, Модель 
-- автомобиля, Стоимость проката. Сортировка по полю Дата проката
select
	ViewRentals.DateStart
	, ViewRentals.Plate
	, ViewRentals.Brand
	, ViewRentals.Duration
	, ViewRentals.InshurancePay
	, ViewRentals.InshurancePay * ViewRentals.Duration as Price
from
	ViewRentals
order by
	ViewRentals.DateStart desc;
go
 	 	 
-- 7	Запрос с левым соединением
-- Для всех клиентов прокатной фирмы вычисляет количество фактов 
-- проката, суммарное количество дней проката, упорядочивание по 
-- убыванию суммарного количества дней проката

-- удаление представления
drop view if exists ViewClientsAmountRentals;
go

-- представление с клиентами и количеством фактов проката и количеством дней проката
-- alter view ViewClientsAmountRentals as
create view ViewClientsAmountRentals as
	select top (select count(*) from Clients)
		Clients.Surname
		, Clients.[Name]
		, Clients.Patronymic
		, Clients.Passport
		, IsNull(Count(Rentals.Id), 0) as AmountRentals
		, IsNull(Sum(Rentals.Duration), 0) as AmountDuration
	from
		Clients left join Rentals on Clients.Id = Rentals.IdClient
	group by 
		Clients.Id, Clients.Surname, Clients.[Name], Clients.Patronymic, Clients.Passport
	order by 
		AmountDuration desc;
go

-- запрос 
select
	*
from
	ViewClientsAmountRentals;
go


-- 8	Итоговый запрос
-- Выполняет группировку по полю Модель автомобиля. Для каждой 
-- модели вычисляет количество фактов проката, сумму за прокат

-- удаление представления
drop view if exists ViewCarsAmountRentalsAndSumPrice;
go

-- представление 
create view ViewCarsAmountRentalsAndSumPrice as 
	select
		Brands.Id
		, Brands.Brand
		, Count(Rentals.Id) as AmountRentals
		, IsNull(Sum(Cars.InshurancePay * Rentals.Duration), 0) as Price
	from
		Brands left join (Rentals inner join Cars on Rentals.IdCar = Cars.Id) 
			on Cars.IdBrand = Brands.Id
	group by
		Brands.Id, Brands.Brand;
go	

-- запрос
select
	*
from
	ViewCarsAmountRentalsAndSumPrice
order by
	ViewCarsAmountRentalsAndSumPrice.Price desc;
go


-- 9	Запрос на добавление	
-- Добавляет данные о новом клиенте. Данные передавайте параметрами
declare @newClientSurname		nvarchar(60) = N'Гурченко',			-- фамилия
		@newClientName			nvarchar(60) = N'Иван',				-- имя
		@newClientPatronymic	nvarchar(60) = N'Александрович',	-- отчество
		@newClientPassport		nvarchar(15) = N'АС72154'			-- данные паспорта

-- вставка нового клиента в представление таблицы клиентов
insert into	ViewClients
	(Surname, [Name], Patronymic, Passport)
values
	(@newClientSurname, @newClientName, @newClientPatronymic, @newClientPassport);

-- демонстрация представления таблицы клиентов
select
	*
from
	ViewClients;

-- демонстрация таблицы клиентов
select
	*
from
	Clients;
go


-- 10	Запрос на обновление	
-- Изменяет данные клиента (все поля, кроме идентификатора). Данные 
-- передавайте параметрами
declare @currentClientPassport	nvarchar(15) = N'ЕС45718',			-- данные паспорта изменяемого пользователя
		@newClientSurname		nvarchar(60) = N'Гурченко',			-- фамилия
		@newClientName			nvarchar(60) = N'Иван',				-- имя
		@newClientPatronymic	nvarchar(60) = N'Александрович',	-- отчество
		@newClientPassport		nvarchar(15) = N'АС72154'			-- данные паспорта

--  демонстрация изменяемого клиента в представлении таблицы клиентов
select
	*
from
	ViewClients
where
	Passport = @currentClientPassport;

-- демонстрация изменяемого клиента в таблице клиентов
select
	*
from
	Clients
where
	Passport = @currentClientPassport;

-- запрос на обновление
update
	ViewClients
set
	Surname		= @newClientSurname,
	[Name]		= @newClientName,
	Patronymic	= @newClientPatronymic,
	Passport	= @newClientPassport
where
	Passport = @currentClientPassport;

--  демонстрация измененного клиента в представлении таблицы клиентов
select
	*
from
	ViewClients
where
	Passport = @newClientPassport;

-- демонстрация измененного клиента в таблице клиентов
select
	*
from
	Clients
where
	Passport = @newClientPassport;
go


-- 11	Запрос на обновление	
-- Изменяет данные автомобиля (все поля, кроме идентификатора).
-- Данные передавайте параметрами

declare @currentPlate	nvarchar(9)	 = N'АС9549ВТ',			-- номер выбранной для изменения машины
		@brand			nvarchar(30) = N'BMW X6',			-- модель 
		@color			nvarchar(40) = N'Голубой',			-- цвет 
		@plate			nvarchar(9)	 = N'АС6547ВН',			-- госномер 
		@yearManuf		int			 = 2010,				-- год выпуска
		@inshurancePay	int			 = 95000,				-- страховая стоимость 
		@rental			int			 = 9000;				-- стоимость одного дня проката

--  демонстрация изменяемого автомобиля в представлении таблицы Машины
select
	*
from
	ViewCars
where
	Plate = @currentPlate;

-- демонстрация изменяемого автомобиля в таблице Машины
select
	Cars.Id
	, Brands.Brand
	, Colors.Color
	, Cars.Plate
	, Cars.YearManuf
	, Cars.InshurancePay
	, Cars.Rental
from
	Cars inner join Brands on Cars.IdBrand = Brands.Id
		 inner join Colors on Cars.IdColor = Colors.Id
where
	Cars.Plate = @currentPlate;

-- запрос на обновление данных об автомобиле из таблицы Машины
update
	ViewCars
set
	Rental			= @rental,
	InshurancePay	= @inshurancePay,
	Plate			= @plate,
	YearManuf		= @yearManuf
where
	Plate = @currentPlate;

-- обновление цвета 
update
	ViewCars
set
	Color = @color
where
	Plate = @currentPlate;

-- обновления модели
update
	ViewCars
set
	Brand = @brand
where
	Plate = @plate;

--  демонстрация измененного автомобиля в представлении таблицы Машины
select
	*
from
	ViewCars
where
	Plate = @plate;

-- демонстрация измененного автомобиля в таблице Машины
select
	Cars.Id
	, Brands.Brand
	, Colors.Color
	, Cars.Plate
	, Cars.YearManuf
	, Cars.InshurancePay
	, Cars.Rental
from
	Cars inner join Brands on Cars.IdBrand = Brands.Id
		 inner join Colors on Cars.IdColor = Colors.Id
where
	Cars.Plate = @plate;
go
