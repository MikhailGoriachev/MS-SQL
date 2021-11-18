-- вывод всех записей таблицы Streets (Улицы)
select
	*
from
	Streets;


-- вывод всех записей таблицы Persons
select
	*
from
	Persons;


-- вывод всех записей таблицы Immovables
select
	Immovables.Id
	, Streets.Street
	, Immovables.HomeNumber
	, Immovables.ApartmentNumber
	, Immovables.AmountRooms
	, Immovables.Area
	, Immovables.Price
from
	Immovables inner join Streets on Immovables.IdStreets = Streets.Id;


-- вывод всех записей таблицы Realtors
select
	Realtors.Id
	, Persons.LastName
	, Persons.FirstName
	, Persons.Patronymic
	, Realtors.RemunPercent
from
	Realtors inner join Persons on Realtors.IdPersons = Persons.Id;


-- вывод всех записей таблицы Owners
select 
	Owners.Id
	, Persons.LastName
	, Persons.FirstName
	, Persons.Patronymic
	, Owners.Passport
from
	Owners inner join Persons on Owners.IdPersons = Persons.Id;


-- вывод всех записей таблицы Transactions
select
	Transactions.Id
	, Streets.Street
	, Immovables.HomeNumber
	, Immovables.ApartmentNumber
	, Immovables.AmountRooms
	, Immovables.Area
	, Immovables.Price
	, PerRealtor.LastName as LastNameRealtor
	, PerRealtor.FirstName as FirstNameRealtor
	, PerRealtor.Patronymic as PatrinyminRealtor
	, Realtors.RemunPercent
	, PerOwner.LastName as LastNameOwner
	, PerOwner.FirstName as FirstNameOwner
	, PerOwner.Patronymic as PatronymicOwner
	, Owners.Passport as PassportOwner
	, Transactions.DateTrans
from
	Transactions inner join (Immovables inner join Streets on Immovables.IdStreets = Streets.Id)	
					on Transactions.IdImmovables = Immovables.Id
				 inner join (Realtors   inner join Persons PerRealtor on Realtors.IdPersons = PerRealtor.Id)		
					on Transactions.IdRealtors	= Realtors.Id
				 inner join (Owners	    inner join Persons PerOwner on Owners.IdPersons = PerOwner.Id)		
					on Transactions.IdOwners = Owners.Id;


-- 1	Запрос с параметрами	
-- Выбирает из таблицы КВАРТИРЫ информацию о 3-комнатных квартирах, расположенных
-- на улице «Садовая». Значения задавать параметрами запроса
declare @countRooms int = 3, @street nvarchar(120) = N'Садовая';

select
	Immovables.Id
	, Streets.Street
	, Immovables.HomeNumber
	, Immovables.ApartmentNumber
	, Immovables.AmountRooms
	, Immovables.Area
	, Immovables.Price
from
	Immovables inner join Streets on Immovables.IdStreets = Streets.Id
where
	Streets.Street = @street and Immovables.AmountRooms = @countRoom;


-- 2	Запрос с параметрами	
-- Выбирает из таблицы РИЭЛТОРЫ информацию о риэлторах, фамилия которых начинается 
-- с буквы «И» и процент вознаграждения больше 10%. Значения задавать параметрами 
-- запроса
declare @lastName nvarchar(60) = N'И', @percent float = 10;

select
	Realtors.Id
	, Persons.LastName
	, Persons.FirstName
	, Persons.Patronymic
	, Realtors.RemunPercent
from
	Realtors inner join Persons on Realtors.IdPersons = Persons.Id
where
	Persons.LastName in (select Persons.LastName from Persons where Persons.LastName like (@lastName + N'%'))
		and Realtors.RemunPercent > @percent;
go


-- 3	Запрос с параметрами	
-- Выбирает из таблицы КВАРТИРЫ информацию об 1-комнатных квартирах, цена на которые 
-- находится в диапазоне от 900 000 руб. до 1000 000 руб. Значения задавать 
-- параметрами запроса
declare @countRooms int = 1, @priceLo int = 900000, @priceHi int = 1000000;

select
	Immovables.Id
	, Streets.Street
	, Immovables.HomeNumber
	, Immovables.ApartmentNumber
	, Immovables.AmountRooms
	, Immovables.Area
	, Immovables.Price
from
	Immovables inner join Streets on Immovables.IdStreets = Streets.Id
where
	Immovables.AmountRooms = @countRooms and Immovables.Price between @priceLo and @priceHi;
go


-- 4	Запрос с параметрами	
-- Выбирает из таблицы КВАРТИРЫ информацию о квартирах с заданным числом комнат. 
-- Значения задавать параметрами запроса
declare @countRooms int = 2;

select
	Immovables.Id
	, Streets.Street
	, Immovables.HomeNumber
	, Immovables.ApartmentNumber
	, Immovables.AmountRooms
	, Immovables.Area
	, Immovables.Price
from	
	Immovables inner join Streets on Immovables.IdStreets = Streets.Id
where
	Immovables.AmountRooms = @countRooms;
go


-- 5	Запрос с параметрами	
-- Выбирает из таблицы КВАРТИРЫ информацию обо всех 2-комнатных квартирах, площадь
-- которых есть значение из некоторого диапазона. Значения задавать параметрами запроса
declare @countRooms int = 2, @areaLo float = 40, @areaHi float = 55;

select
	Immovables.Id
	, Streets.Street
	, Immovables.HomeNumber
	, Immovables.ApartmentNumber
	, Immovables.AmountRooms
	, Immovables.Area
	, Immovables.Price
from
	Immovables inner join Streets on Immovables.IdStreets = Streets.Id
where	
	Immovables.AmountRooms = @countRooms and Immovables.Area between @areaLo and @areaHi;
go


-- 6	Запрос с вычисляемыми полями	
-- Вычисляет для каждой оформленной сделки размер комиссионного вознаграждения риэлтора.
-- Включает поля Фамилия риэлтора, Имя риэлтора, Отчество риэлтора, Дата сделки, Цена 
-- квартиры, Комиссионные. Сортировка по полю Дата сделки
select
	Transactions.Id
	, Persons.LastName
	, Persons.FirstName
	, Persons.Patronymic
	, Transactions.DateTrans
	, Immovables.Price
	, Realtors.RemunPercent
	, Immovables.Price * (Realtors.RemunPercent / 100) as Commission
from 
	Transactions inner join (Realtors inner join Persons on Realtors.IdPersons = Persons.Id) 
					on Transactions.IdRealtors = Realtors.Id
				 inner join (Immovables inner join Streets on Immovables.IdStreets = Streets.Id)
					on Transactions.IdImmovables = Immovables.Id;


-- 7	Запрос на левое соединение	
-- Выбрать всех риэлторов, количество клиентов, оформивших с ним сделки и сумму сделок 
-- риэлтора. Упорядочить выборку по убыванию суммы сделок.

-- решение с помощью левого соединения
select
	Realtors.Id
	, Persons.LastName
	, Persons.FirstName
	, Persons.Patronymic
	, COUNT (Transactions.Id) as CountTransactions			-- количество сделок риэлтора (!!! СЧИТАЕТ КОЛИЧЕСТВО СДЕЛОК, А НЕ КОЛИЧЕСТВО КЛИЕНТОВ !!!)
	, SUM (Immovables.Price) as SumTransactions				-- сумма сделок				
from
	(Realtors inner join Persons on Realtors.IdPersons = Persons.Id) left join
		(Transactions inner join Immovables on Transactions.IdImmovables = Immovables.Id) 
		on Transactions.IdRealtors = Realtors.Id 
group by
	Realtors.Id, Persons.LastName, Persons.FirstName, Persons.Patronymic
order by
	SumTransactions desc;		-- упорядочивание по убыванию суммы сделок


-- решение с помощью подзапросов
select
	Realtors.Id
	, Persons.LastName
	, Persons.FirstName
	, Persons.Patronymic
	, (select COUNT(*) from Transactions where Transactions.IdRealtors = Realtors.Id) as CountTransactions	-- количество сделок риэлтора
	, (select COUNT(*) from (select distinct Transactions.IdOwners											-- количество клиентов риэлтора
			from Transactions where Transactions.IdRealtors = Realtors.Id) as Clients) as CountClients
	, (select SUM(Immovables.Price) from (Transactions inner join Immovables								-- сумма сделок риэлтора
		on Transactions.IdImmovables = Immovables.Id)
		where Transactions.IdRealtors = Realtors.Id) as SumTransaсtions
	, (select SUM(Immovables.Price) from (Transactions inner join Immovables								-- сумма коммисионных риэлтора
		on Transactions.IdImmovables = Immovables.Id)
		where Transactions.IdRealtors = Realtors.Id) * (Realtors.RemunPercent / 100) as Commisions											
from
	Realtors inner join Persons on Realtors.IdPersons = Persons.Id
order by
	SumTransaсtions desc;		-- упорядочивание по убыванию суммы сделок


-- 8	Запрос на левое соединение	
-- Для всех улиц вывести сумму сделок, упорядочить выборку по убыванию суммы сделки

-- решение с помощью левого соединения
select
	Streets.Id
	, Streets.Street
	, COUNT(Immovables.Id) as CountTransactions		-- количество сделок
	, SUM(Immovables.Price) as SumTransactions		-- сумма сделок
from
	Streets left join (Immovables inner join Transactions on Immovables.Id = Transactions.IdImmovables)
		on Immovables.IdStreets = Streets.Id
group by
	Streets.Street, Streets.Id
order by
	SumTransactions desc;

-- решение с помощью подзапросов
select 
	Streets.Id
	, Streets.Street
	, (select COUNT(*) from Transactions inner join Immovables on Transactions.IdImmovables = Immovables.Id						-- количество сделок
			where Immovables.IdStreets = Streets.Id) as CountTransactions
	, (select SUM(Immovables.Price) from Transactions inner join Immovables on Transactions.IdImmovables = Immovables.Id		-- сумма сделок
			where Immovables.IdStreets = Streets.Id) as SumTransactions
from
	Streets
order by
	SumTransactions desc;
go


-- 9	Запрос на левое соединение	
-- Для всех улиц вывести сумму сделок за заданный период, упорядочить выборку по убыванию 
-- суммы сделки. Диапазон задавать параметрами запроса

declare @minDate date = '2021/01/01', @maxDate date = '2021/05/01' 

-- решение с помощью левого соединения
select
	Streets.Id
	, Streets.Street
	, COUNT(results.IdStreets) as CountTransactions		-- количество сделок
	, SUM(results.Price) as SumTransactions				-- сумма сделок
from
	Streets left join (select Immovables.Price, Immovables.IdStreets, Transactions.Id, Transactions.DateTrans 
		from Immovables inner join Transactions on Immovables.Id = Transactions.IdImmovables
		where Transactions.DateTrans between @minDate and @maxDate) results
		on results.IdStreets = Streets.Id
group by
	Streets.Id, Streets.Street
order by
	SumTransactions desc;

-- решение с помощью подзапросов
select
	Streets.Id
	, Streets.Street
	, (select COUNT(Transactions.Id) from Transactions inner join Immovables on Transactions.IdImmovables = Immovables.Id						-- количество сделок
			where Immovables.IdStreets = Streets.Id and Transactions.DateTrans between @minDate and @maxDate) as CountTransactions
	, (select SUM(Immovables.Price) from Transactions inner join Immovables on Transactions.IdImmovables = Immovables.Id						-- сумма сделок
			where Immovables.IdStreets = Streets.Id and Transactions.DateTrans between @minDate and @maxDate) as SumTransactions
from
	Streets	
order by
	SumTransactions desc;
go


-- 10	Итоговый запрос	
-- Выполняет группировку по полю Количество комнат. Для каждой группы вычисляет среднее 
-- значение по полю Цена квартиры
select
	Immovables.AmountRooms
	, COUNT(*) as [CountImmovables]
	, MIN (Immovables.Price) as MinPrice	
	, AVG (Immovables.Price) as AvgPrice
	, MAX (Immovables.Price) as MaxPrice
from 
	Immovables
group by
	Immovables.AmountRooms;


-- 11	Итоговый запрос	
-- Выполняет группировку по полю Площадь квартиры. Для каждой группы вычисляет наибольшее 
-- и наименьшее значение по полю Цена квартиры
select
	Immovables.Area
	, COUNT(*) as [Count]
	, MIN (Immovables.Price) as MinPrice	
	, AVG (Immovables.Price) as AvgPrice
	, MAX (Immovables.Price) as MaxPrice
from
	Immovables
group by
	Immovables.Area;
		

-- 12	Запрос на создание базовой таблицы	
-- Создает таблицу КВАРТИРЫ_3_КОМН, содержащую информацию о 3-комнатных квартирах

-- удаление таблицы ApartmentsThreeRooms
drop table if exists ApartmentsThreeRooms;

declare @amountRooms int = 3;
select
	*
	into ApartmentsThreeRooms
from
	Immovables
where
	Immovables.AmountRooms = @amountRooms;
go


-- 13	Запрос на создание базовой таблицы	
-- Создает копию таблицы КВАРТИРЫ с именем КОПИЯ_КВАРТИРЫ

-- удаление таблицы CopyImmovables
drop table if exists CopyImmovables;

select
	*
	into CopyImmovables
from
	Immovables;


-- 14	Запрос на удаление	
-- Удаляет из таблицы КОПИЯ_КВАРТИРЫ записи, в которых значение в поле Цена квартиры больше 
-- 3 000 000 руб.
declare @price int = 3000000;

delete from CopyImmovables
where
	CopyImmovables.Price > @price;
go


-- 15	Запрос на обновление	
-- Увеличивает значение в поле Цена квартиры таблицы КОПИЯ_КВАРТИРЫ на 10 процентов для 
-- 1-комнатных квартир

-- вывод квартир до увеличения цены
select
	CopyImmovables.Id
	, Streets.Street
	, CopyImmovables.HomeNumber
	, CopyImmovables.ApartmentNumber
	, CopyImmovables.AmountRooms
	, CopyImmovables.Area
	, CopyImmovables.Price
from
	CopyImmovables inner join Streets on CopyImmovables.IdStreets = Streets.Id

declare @percent float = 10, @amountRooms int = 1;
update
	CopyImmovables
set
	Price *= (@percent / 100) + 1
from
	CopyImmovables
where
	CopyImmovables.AmountRooms = @amountRooms

-- вывод квартир после увеличения цены
select
	CopyImmovables.Id
	, Streets.Street
	, CopyImmovables.HomeNumber
	, CopyImmovables.ApartmentNumber
	, CopyImmovables.AmountRooms
	, CopyImmovables.Area
	, CopyImmovables.Price
from
	CopyImmovables inner join Streets on CopyImmovables.IdStreets = Streets.Id
