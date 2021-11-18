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


-- 1	Запрос с параметром	
-- Выбирает из таблицы АВТОМОБИЛИ информацию об автомобилях 
-- заданной модели (например, ВАЗ-2110)
-- BMW X6
-- BMW E81
-- BMW E90
-- Mercedes-Benz W124AMG
-- Mercedes-Benz W906
-- Mercedes-Benz W221
-- Mercedes-Benz W414
-- Infiniti FX37
-- Infiniti G37	
-- Infiniti JX35

-- параметры для отбора
declare @model nvarchar(30) = N'Mercedes-Benz W124AMG';

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
	Brand = @model;
go


-- 2	Запрос с параметром	
-- Выбирает из таблицы АВТОМОБИЛИ информацию об автомобилях, 
-- изготовленных до заданного года (например, до 2016)
-- параметры для отбора
declare @year int = 2007;

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
	YearManuf = @year;
go


-- 3	Запрос с параметром	
-- Выбирает из таблицы АВТОМОБИЛИ информацию об автомобилях, 
-- имеющих заданные модель и цвет, изготовленных после 
-- заданного года
declare @year int = 2007;

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
	YearManuf = @year;
go


-- 4	Запрос с параметром	
-- Выбирает из таблицы АВТОМОБИЛИ информацию об автомобиле с 
-- заданным госномером.
-- АН4841ТС
-- НО7985ВТ
-- АС2194СН
-- СН9155ТС
-- АС9549ВТ
-- НО2315СН
-- АН9517ВТ
-- АС3214ТС
-- СН5187ВТ
-- АС3215ТС

declare @plate nvarchar(9) = N'АС3214ТС';

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


-- 5	Запрос с параметром	
-- Выбирает из таблиц КЛИЕНТЫ, АВТОМОБИЛИ и ФАКТЫ_ПРОКАТА 
-- информацию обо всех зафиксированных фактах проката 
-- автомобилей (ФИО клиента, Модель автомобиля, Госномер 
-- автомобиля, дата проката) в некоторый заданный интервал 
-- времени. Нижняя и верхняя границы интервала задаются при 
-- выполнении запроса
declare @dateLo date = '2021/11/3', @dateHi date = '2021/11/10';

select 
	Rentals.Id
	, Clients.Surname
	, Clients.[Name]
	, Clients.Patronymic
	, Clients.Passport
	, Brands.Brand
	, Cars.Plate
	, Rentals.DateStart
	, Rentals.Duration
from
	Rentals inner join Clients on Rentals.IdClient = Clients.Id
			inner join (Cars inner join Brands on Cars.IdBrand = Brands.Id)
			on Rentals.IdCar = Cars.Id
where
	Rentals.DateStart between @dateLo and @dateHi;
go


-- 6	Запрос с вычисляемыми полями	
-- Вычисляет для каждого факта проката стоимость проката. 
-- Включает поля Дата проката, Госномер автомобиля, Модель 
-- автомобиля, Стоимость проката. Сортировка по полю Дата проката
select 
	Rentals.Id
	, Brands.Brand
	, Cars.Plate
	, Cars.Rental as RentalOneDay
	, Rentals.DateStart
	, Rentals.Duration
	, Cars.Rental * Rentals.Duration as PriceRental
from
	Rentals inner join Clients on Rentals.IdClient = Clients.Id
			inner join (Cars inner join Brands on Cars.IdBrand = Brands.Id)
			on Rentals.IdCar = Cars.Id
order by 
	Rentals.DateStart desc;
go
 	 	 

-- 7	Запрос с левым соединением
-- Для всех автомобилей прокатной фирмы вычисляет количество 
-- фактов проката, сумму вырученную за прокаты
select
	Brands.Brand
	, Colors.Color
	, Cars.Plate
	-- , Cars.Rental * Rentals.Duration
	, COUNT(Rentals.Id) as CountRentals						-- количество файтов проката
	, SUM(Cars.Rental * Rentals.Duration) as SumRentals		-- сумма за прокаты
from
	(Cars inner join Colors on Cars.IdColor = Colors.Id
		  inner join Brands on Cars.IdBrand = Brands.Id)
	left join Rentals on Rentals.IdCar = Cars.Id
group by
	Brands.Brand, Colors.Color, Cars.Plate
order by
	SumRentals desc;		-- сортировка по убыванию суммы за прокаты


-- 8	Итоговый запрос	
-- Выполняет группировку по полю Год выпуска автомобиля. Для 
-- каждого года вычисляет минимальное и максимальное значения
-- по полю Стоимость одного дня проката
select
	Cars.YearManuf
	, COUNT(*) as CountCars
	, MIN(Cars.Rental) as MinRental
	, AVG(Cars.Rental) as AvgRental
	, MAX(Cars.Rental) as MaxRental
from
	Cars inner join Colors on Cars.IdColor = Colors.Id
		 inner join Brands on Cars.IdBrand = Brands.Id
group by
	Cars.YearManuf
order by
	Cars.YearManuf desc;	-- сортировка по убыванию года выпуска автомобиля
		

-- 9	Запрос на добавление	
-- Добавляет в таблицу ФАКТЫ_ПРОКАТА данные о факте проката. 
-- Данные передавайте параметрами, используйте подзапросы
declare @clientPassport nvarchar(15)	=	N'ВО12312',			-- паспорт клиента
		@carPlate		nvarchar(9)		=	N'АС2194СН',		-- госномер машины
		@dateStart		date			=	'2021/11/18',		-- дата начала проката
		@duration		int				=	3;					-- количество дней проката

-- вывод таблицы ФАКТЫ_ПРОКАТА до добавления элемента
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

-- добавление факта проката в таблицу ФАКТЫ_ПРОКАТА
insert into Rentals
	(IdClient, IdCar, DateStart, Duration)
values
	(
		(select Clients.Id from Clients where Clients.Passport = @clientPassport),	-- получение Id клиента
		(select Cars.Id	   from Cars	where Cars.Plate = @carPlate),				-- получение Id машины
		@dateStart,																	-- дата начала проката
		@duration																	-- количество дней проката
	);

-- вывод таблицы ФАКТЫ_ПРОКАТА после добавления элемента
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
go


-- 10	Запрос на добавление	
-- Добавляет в таблицу АВТОМОБИЛИ данные о новом автомобиле в 
-- прокатной фирме. Данные автомобиля задавайте параметрами, 
-- используйте подзапросы.
declare @brand			nvarchar(30) = N'BMW X6',			-- модель 
		@color			nvarchar(40) = N'Голубой',			-- цвет 
		@plate			nvarchar(9)	 = N'АС6547ВН',			-- госномер 
		@yearManuf		int			 = 2010,				-- год выпуска
		@inshurancePay	int			 = 95000,				-- страховая стоимость 
		@rental			int			 = 9000;				-- стоимость одного дня проката

-- вывод таблицы АВТОМОБИЛИ до добавления авто
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

-- добавление автомобиля
insert into Cars
	(IdBrand, IdColor, Plate, YearManuf, InshurancePay, Rental)
values
	(
		(select Brands.Id from Brands where Brands.Brand = @brand),		-- получение Id модели
		(select Colors.Id from Colors where Colors.Color = @color),		-- получание Id цвета
		@plate,
		@yearManuf,
		@inshurancePay,
		@rental
	);	

-- вывод таблицы АВТОМОБИЛИ после добавления авто
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
go

		
-- 11	Запрос на удаление	
-- Удаляет из таблицы ФАКТЫ_ПРОКАТА запись по идентификатору, 
-- заданному параметром запроса
declare @clientPassport nvarchar(15)	=	N'ВО12312',			-- паспорт клиента
		@carPlate		nvarchar(9)		=	N'АС2194СН',		-- госномер машины
		@dateStart		date			=	'2021/11/18',		-- дата начала проката
		@duration		int				=	3;					-- количество дней проката

-- вывод таблицы ФАКТЫ_ПРОКАТА до добавления элемента
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

-- получение Id записи из таблицы ФАКТЫ_ПРОКАТА, чтоб удалялся только одна запись,
-- иначе будут удалятся все записи соотвутсвующие условиям
declare @idRental int;

select 
	@idRental = results.Id 
from
	(select Rentals.Id from Rentals where
	Rentals.IdClient = (select Clients.Id from Clients where Clients.Passport = @clientPassport) and
	Rentals.IdCar = (select Cars.Id	   from Cars	where Cars.Plate = @carPlate) and 
	Rentals.DateStart = @dateStart and
	Rentals.Duration = @duration) as results;

-- удаление факта проката из таблицы ФАКТЫ_ПРОКАТА
delete from Rentals
where
	Rentals.Id = @idRental;

-- вывод таблицы ФАКТЫ_ПРОКАТА после добавления элемента
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
go


-- 12	Запрос на удаление	
-- Удаляет из таблицы ФАКТЫ_ПРОКАТА записи за указанный период 
-- для заданного клиента.
declare @clientPassport nvarchar(15) = N'ВО12312',			-- серия-номер пасспорта клиента
		@dateLo date = '2021/11/3', 						-- минимальная дата 
		@dateHi date = '2021/11/10';						-- максимальная дата

-- вывод таблицы ФАКТЫ_ПРОКАТА до добавления элемента
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

-- получение Id клиента
declare @clientId int = (select Clients.Id from Clients where Clients.Passport = @clientPassport);


-- удаление факта проката из таблицы ФАКТЫ_ПРОКАТА
delete from Rentals
where
	Rentals.Id = any (select results.Id from (select * from Rentals where Rentals.IdClient = @clientId) as results
	where
		results.DateStart between @dateLo and @dateHi
		);

-- вывод таблицы ФАКТЫ_ПРОКАТА после добавления элемента
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
go


-- 13	Запрос на обновление	
-- Увеличивает значение в поле Стоимость одного дня проката на 
-- заданное количество процентов для автомобилей, изготовленных
-- после заданного года
declare @percent		int = 12,		-- проценты для увеличения
		@yearManuf		int	= 2010;		-- год выпуска машины

-- вывод таблицы Машины до увеличения цены
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
	Cars.YearManuf > @yearManuf;

-- увеличение цены
update 
	Cars
set
	Rental *= (@percent / 100.) + 1
where
	Cars.YearManuf > @yearManuf;

-- вывод таблицы Машины после увеличения цены
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
	Cars.YearManuf > @yearManuf;
go


-- 14	Запрос на обновление	
-- Изменяет данные клиента по его идентификатору на указанные 
-- в параметрах запроса значение
declare @currentClientPassport	nvarchar(15) = N'АВ34524',			-- исходная серия-номер пасспорта клиента
		@newClientSurname		nvarchar(60) = N'Гурченко',			-- новая фамилия
		@newClientName			nvarchar(60) = N'Иван',				-- новое имя
		@newClientPatronymic	nvarchar(60) = N'Александрович',	-- новое отчество
		@newClientPassport		nvarchar(15) = N'АС72154'			-- новые данные паспорта

-- получение Id клиента
declare @idClient int = (select Clients.Id from Clients where Clients.Passport = @currentClientPassport);

-- вывод клиента которого будет редактировать
select
	Clients.Id
	, Clients.Surname
	, Clients.[Name]
	, Clients.Patronymic
	, Clients.Passport
from
	Clients
where
	Clients.Id = @idClient;

-- вывод таблицы Клиенты до изменения данных
select
	Clients.Id
	, Clients.Surname
	, Clients.[Name]
	, Clients.Patronymic
	, Clients.Passport
from
	Clients;

-- обноваление данных клиента
update 
	Clients
set
	Surname		= @newClientSurname,
	[Name]		= @newClientName,
	Patronymic	= @newClientPatronymic,
	Passport	= @newClientPassport
where
	Clients.Id	= @idClient;

-- вывод таблицы Клиенты до изменения данных
select
	Clients.Id
	, Clients.Surname
	, Clients.[Name]
	, Clients.Patronymic
	, Clients.Passport
from
	Clients;
go