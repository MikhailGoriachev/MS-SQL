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

--------------------------------------------------------------------------------------------------------------------

-- 1	Запрос к представлению. Однотабличная функция
-- Выбирает информацию обо всех фактах проката автомобиля с заданным госномером

-- удаление функции
drop function if exists RentalsByPlate;
go

-- создание функции 
create function RentalsByPlate(@plate nvarchar(9))
	returns table
	as 
	return
		select
			*
		from
			ViewRentals
		where
			Plate = @plate;
		go
	go

-- демонстрация работы функции
-- АН4841ТС
-- НО7985ВТ
-- АС2194СН
-- СН9155ТС
-- АС9549ВТ
-- НО2315СН
select * from RentalsByPlate(N'АН4841ТС');		-- 1
select * from RentalsByPlate(N'НО7985ВТ');		-- 2
select * from RentalsByPlate(N'АС2194СН');		-- 3
go


-- 2	Запрос к представлению Хранимая процедура	
-- Выбирает информацию обо всех фактах проката автомобиля с заданной моделью/брендом

-- удаление процедуры
drop proc RentalsByBrand;
go

-- создание процедуры
create proc RentalsByBrand
	@brand nvarchar(30)
as
	begin
		select
			*
		from
			ViewRentals
		where	
			Brand = @brand;
	end;
go


-- демонстрация работы процедуры
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
exec dbo.RentalsByBrand N'BMW E81';					-- 1
exec dbo.RentalsByBrand N'Mercedes-Benz W124AMG';	-- 2
exec dbo.RentalsByBrand N'BMW X6';					-- 3
go


-- 3	Запрос к представлению. Однотабличная функция	
-- Выбирает информацию об автомобиле с заданным госномером

-- удаление функции
drop function if exists CarsByPlate;
go

-- создание функции 
create function CarsByPlate(@plate nvarchar(9))
	returns table
	as 
	return
		select
			*
		from
			ViewCars
		where
			Plate = @plate;
		go
	go

-- демонстрация работы функции
-- АН4841ТС
-- НО7985ВТ
-- АС2194СН
-- СН9155ТС
-- АС9549ВТ
-- НО2315СН
select * from CarsByPlate(N'АН4841ТС');		-- 1
select * from CarsByPlate(N'НО7985ВТ');		-- 2
select * from CarsByPlate(N'АС2194СН');		-- 3
go


-- 4	Запрос с параметром Хранимая процедура	
-- Выбирает информацию о клиентах по серии и номеру паспорта

-- удаление процедуры
drop proc if exists ClientsByPassport;
go

-- создание процедуры
create proc ClientsByPassport
	@passport nvarchar(15)
as
	begin
		select
			*
		from
			ViewClients
		where
			Passport = @passport;
	end;
go

-- демонстрация работы процедуры
-- Выбирает информацию о клиентах по серии и номеру паспорта
-- ЕС45718
-- АВ34524
-- АТ65423
-- ВО12312
-- СК67443
exec dbo.ClientsByPassport N'ЕС45718';	-- 1
exec dbo.ClientsByPassport N'АВ34524';	-- 2
exec dbo.ClientsByPassport N'АТ65423';	-- 3
go


-- 5	Запрос к представлению. Хранимая процедура	
-- Выбирает информацию обо всех зафиксированных фактах проката автомобилей в некоторый 
-- заданный интервал времени.

-- удаление процедуры
drop proc RentalsPeriod;
go

-- создание процедуры
create proc RentalsPeriod
	@dateLo date,
	@dateHi date
as
	begin
		select
			*
		from
			ViewRentals
		where
			DateStart between @dateLo and @dateHi;
	end;
go

-- демонстрация работы процедуры
exec dbo.RentalsPeriod '2021/11/03', '2021/11/05';	-- 1
exec dbo.RentalsPeriod '2021/11/06', '2021/11/10';	-- 2
exec dbo.RentalsPeriod '2021/11/11', '2021/11/25';	-- 3
go


-- 6	Запрос к представлению. Однотабличная функция	
-- Вычисляет для каждого факта проката стоимость проката. Включает поля Дата проката,
-- Госномер автомобиля, Модель автомобиля, Стоимость проката. 
-- Сортировка по полю Дата проката

-- удаление функции
drop function if exists RentalsPrice;
go

-- создание функции 
create function RentalsPrice()
	returns table
	as
	return 
		select TOP(select count(*) from ViewRentals)
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
	go

-- демонстрация работы функции
select * from RentalsPrice();
go


-- 7	Запрос с левым соединением. Хранимая процедура 	
-- Для всех клиентов прокатной фирмы вычисляет количество фактов проката, суммарное
-- количество дней проката, упорядочивание по убыванию суммарного количества дней
-- проката

-- удаление процедуры
drop proc if exists CountRentalsAndDuration;
go

-- создание процедуры
create proc CountRentalsAndDuration
as
	begin
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
	end;
go

-- демонстрация работы процедуры
exec dbo.CountRentalsAndDuration;


-- 8	Итоговый запрос. Однотабличная функция	
-- Выбирает информацию о фактах проката автомобилей по госномеру: количество фактов 
-- проката, сумма за прокаты, суммарная длительность прокатов

-- удаление функции
drop function if exists RentalsByPlateSum;
go

-- создание функции 
create function RentalsByPlateSum(@plate nvarchar(9))
	returns table
	as
	return 
		select
			ViewCars.Brand
			, ViewCars.Color
			, ViewCars.Plate
			, ViewCars.YearManuf
			, ViewCars.InshurancePay
			, ViewCars.Rental
			, Count(Rentals.Id) as AmountRentals
			, IsNull(Sum(ViewCars.InshurancePay * Rentals.Duration), 0) as SumPrice
			, IsNull(Sum(Rentals.Duration), 0)						as SumDuration
		from
			ViewCars left join Rentals on Rentals.IdCar = ViewCars.Id
		where 
			ViewCars.Plate = @plate
		group by 
			ViewCars.Brand, ViewCars.Color, ViewCars.Plate, ViewCars.YearManuf, ViewCars.InshurancePay, ViewCars.Rental;
		go
	go

-- демонстрация работы функции
-- АН4841ТС
-- НО7985ВТ
-- АС2194СН
-- СН9155ТС
-- АС9549ВТ
-- НО2315СН
select * from RentalsByPlateSum(N'АН4841ТС');	-- 1
select * from RentalsByPlateSum(N'НО7985ВТ');	-- 2
select * from RentalsByPlateSum(N'АС2194СН');	-- 3
