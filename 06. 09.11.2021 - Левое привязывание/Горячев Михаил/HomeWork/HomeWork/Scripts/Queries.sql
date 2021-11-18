-- ЗАПРОСЫ

-- 1	Запрос с параметром	
-- Выбирает из таблицы ИЗДАНИЯ информацию о доступных для 
-- подписки изданиях заданного типа, стоимость 1 экземпляра 
-- для которых меньше заданной.
-- виды изданий:
-- газета
-- каталог
-- альманах
-- журнал

declare @selectType nvarchar(100) = N'газета';

select
	Editions.Id
	, Editions.IndexEdition
	, Editions.Title
	, TypesOfEdition.[Type]
	, Editions.Price
from
	Editions inner join TypesOfEdition on Editions.IdTypesOfEdition = TypesOfEdition.Id
where
	TypesOfEdition.[Type] = @selectType;
go

-- 2	Запрос с параметром	
-- Выбирает из таблиц информацию о подписчиках, проживающих
-- на заданной параметром улице и номере дома, которые 
-- оформили подписку на издание с заданным параметром
-- наименованием
declare @selectStreet nvarchar(120) = N'Петровского', @selectNumberHome nvarchar(10) = N'256',
		@selectTitle nvarchar(100) = N'Вечерняя Москва';

select
	Delivery.Id
	, Editions.IndexEdition
	, Editions.Title
	, TypesOfEdition.[Type]
	, Subscribers.LastName
	, Subscribers.FirstName
	, Subscribers.Patronymic
	, Streets.Street
	, Subscribers.NumberHome
	, Subscribers.NumberApartment
from
	Delivery inner join (Subscribers inner join Streets on Subscribers.IdStreets = Streets.Id) on Delivery.IdSubscribers = Subscribers.Id
			 inner join (Editions inner join TypesOfEdition on Editions.IdTypesOfEdition = TypesOfEdition.Id) on Delivery.IdEditions = Editions.Id
where
	Streets.Street = @selectStreet and Subscribers.NumberHome = @selectNumberHome and Editions.Title = @selectTitle;
go

-- 3	Запрос с параметром	
-- Выбирает из таблицы ИЗДАНИЯ информацию об изданиях, для
-- которых значение в поле Цена 1 экземпляра находится в 
-- заданном диапазоне значений
declare @loPrice int = 250, @hiPrice int = 2000;

select
	Editions.Id
	, Editions.IndexEdition
	, TypesOfEdition.[Type]
	, Editions.Title
	, Editions.Price
from
	Editions inner join TypesOfEdition on Editions.IdTypesOfEdition = TypesOfEdition.Id
where
	Editions.Price between @loPrice and @hiPrice;
go

-- 4	Запрос с параметром	
-- Выбирает из таблиц информацию о подписчиках, подписавшихся
-- на заданный параметром тип издания
-- виды изданий:
-- газета
-- каталог
-- альманах
-- журнал

declare @selectType nvarchar(100) = N'газета';

select
	Subscribers.Id
	, Subscribers.LastName
	, Subscribers.FirstName
	, Subscribers.Patronymic
	, Subscribers.NumberPassport
	, Streets.Street
	, Subscribers.NumberHome
	, Subscribers.NumberApartment
	, TypesOfEdition.[Type]
	, Editions.Title
from 
	Delivery inner join (Subscribers inner join Streets on Subscribers.IdStreets = Streets.Id) on Delivery.IdSubscribers = Subscribers.Id
			 inner join (Editions inner join TypesOfEdition on Editions.IdTypesOfEdition = TypesOfEdition.Id) on Delivery.IdEditions = Editions.Id
where
	TypesOfEdition.[Type] = @selectType;
go

-- 5	Запрос с параметром	
-- Выбирает из таблиц ИЗДАНИЯ и ПОДПИСКА информацию обо всех 
-- оформленных подписках, для которых срок подписки есть 
-- значение из некоторого диапазона. Нижняя и верхняя границы
-- диапазона задаются при выполнении запроса

declare @loMonths int = 2, @hiMonth int = 10;

select
	Delivery.Id
	, Editions.Title
	, TypesOfEdition.[Type]
	, Editions.Price
	, Delivery.DateStartSubscribe
	, Delivery.SubsctibePeriodMonths
from
	Delivery inner join (Editions inner join TypesOfEdition on Editions.IdTypesOfEdition = TypesOfEdition.Id) on Delivery.IdEditions = Editions.Id
where
	Delivery.SubsctibePeriodMonths between @loMonths and @hiMonth;
go

-- 6	Запрос с вычисляемыми полями
-- Вычисляет для каждой оформленной подписки ее стоимость с 
-- доставкой и без НДС. Включает поля Индекс издания, 
-- Наименование издания, Цена 1 экземпляра, Дата начала 
-- подписки, Срок подписки, Стоимость подписки без НДС. 
-- Сортировка по полю Индекс издания
select
	Delivery.Id
	, Editions.IndexEdition
	, Editions.Title
	, Editions.Price
	, Delivery.DateStartSubscribe
	, Delivery.SubsctibePeriodMonths
	, Editions.Price * Delivery.SubsctibePeriodMonths as SubscriptionCost
from 
	Delivery inner join (Editions inner join TypesOfEdition on Editions.IdTypesOfEdition = TypesOfEdition.Id) on Delivery.IdEditions = Editions.Id

-- 7	Итоговый запрос	
-- Выполняет группировку по полю Вид издания. Для каждого 
-- вида вычисляет максимальную и минимальную цену 1 экземпляра
select
	TypesOfEdition.[Type]
	, COUNT(*) as [Count]
	, MIN(Editions.Price) as MinPrice
	, AVG(Editions.Price) as AvgPrice	-- необязательное поле, вывод для удобства
	, MAX(Editions.Price) as MaxPrice
from
	Editions inner join TypesOfEdition on Editions.IdTypesOfEdition = TypesOfEdition.Id
group by
	TypesOfEdition.[Type]

-- 8	Итоговый запрос с левым соединением	
-- Выполняет группировку по полю Улица. Для всех улиц вычисляет 
-- количество подписчиков, проживающих на данной улице (итоги 
-- по полю Код получателя)
select
	Streets.Street
	, COUNT(Subscribers.IdStreets) as [Count]
from
	Streets left join Subscribers on Subscribers.IdStreets = Streets.Id
group by
	Streets.Street

-- 9	Итоговый запрос с левым соединением	
-- Для всех изданий выводит количество оформленных подписок
select
	Editions.Title
	, COUNT(Delivery.IdEditions) as [Count]
from
	Editions inner join TypesOfEdition on Editions.IdTypesOfEdition = TypesOfEdition.Id
			 left join Delivery on Delivery.IdEditions = Editions.Id
group by
	Editions.Title
		
-- 10	Запрос на создание базовой таблицы	
-- Создает таблицу ПОДПИСЧИКИ_ЖУРНАЛЫ, содержащую информацию о 
-- подписчиках изданий, имеющих вид «журнал»

-- удаление результирующей базы данных
drop table if exists Subscribers_Journal;

declare @selectType nvarchar(50) = N'журнал';
select
	Delivery.Id as DeliveryId
	, Editions.Title
	, TypesOfEdition.[Type]
	, Editions.Price
	, Subscribers.LastName
	, Subscribers.FirstName
	, Subscribers.Patronymic
	, Subscribers.NumberPassport
	, Streets.Street
	, Subscribers.NumberHome
	, Subscribers.NumberApartment
	, Delivery.DateStartSubscribe
	, Delivery.SubsctibePeriodMonths
	into dbo.Subscribers_Journal
from
	Delivery inner join (Editions inner join TypesOfEdition on Editions.IdTypesOfEdition = TypesOfEdition.Id) on Delivery.IdEditions = Editions.Id
			 inner join (Subscribers inner join Streets on Subscribers.IdStreets = Streets.Id) on Delivery.IdSubscribers = Subscribers.Id
where
	TypesOfEdition.[Type] = @selectType;
go

-- 11	Запрос на создание базовой таблицы	
-- Создает копию таблицы ПОДПИСЧИКИ с именем КОПИЯ_ПОДПИСЧИКИ

-- удаление таблицы КОПИЯ_ПОДПИСЧИКИ
drop table if exists Copy_Subscribers;

-- копирование таблицы ПОДПИСЧИКИ 
select
	*
	into Copy_Subscribers
from 
	Subscribers;

-- 12	Запрос на удаление	
-- Удаляет из таблицы КОПИЯ_ПОДПИСЧИКИ записи, в которых 
-- значение в поле Улица равно «Садовая»
declare @selectStreet nvarchar(120) = N'Садовая';

-- вывод всех записей таблицы КОПИЯ_ПОДПИСЧИКИ с заданной улицей до удаления
select
	Copy_Subscribers.Id
	, Copy_Subscribers.LastName
	, Copy_Subscribers.FirstName
	, Copy_Subscribers.Patronymic
from
	Copy_Subscribers inner join Streets on Copy_Subscribers.IdStreets = Streets.Id
where 
	Streets.Street = @selectStreet;

-- удаление записей с заданной улицей
delete from 
	Copy_Subscribers
from
	Copy_Subscribers inner join Streets on Copy_Subscribers.IdStreets = Streets.Id
where 
	Streets.Street = @selectStreet;
	
-- вывод всех записей таблицы КОПИЯ_ПОДПИСЧИКИ с заданной улицей после удаления
select
	Copy_Subscribers.Id
	, Copy_Subscribers.LastName
	, Copy_Subscribers.FirstName
	, Copy_Subscribers.Patronymic
from
	Copy_Subscribers inner join Streets on Copy_Subscribers.IdStreets = Streets.Id
where 
	Streets.Street = @selectStreet;

go

-- 13	Запрос на обновление	
-- Увеличивает значение в поле Цена 1 экземпляра таблицы 
-- ИЗДАНИЯ на заданное параметром количество процентов для 
-- изданий, заданного параметром вида
declare @pricePercent int = 15, @selectType nvarchar(100) = N'газета';

-- вывод всех изданий с заданным типом до увеличения цены
select
	Editions.Id
	, Editions.Title
	, Editions.IndexEdition
	, TypesOfEdition.[Type]
	, Editions.Price
from 
	Editions inner join TypesOfEdition on Editions.IdTypesOfEdition = TypesOfEdition.Id
where
	TypesOfEdition.[Type] = @selectType;

-- увеличение цены для записей с заданным типом на заданное значение процентов
update 
	Editions
set 
	Price *= (@pricePercent / 100.) + 1
from
	Editions inner join TypesOfEdition on Editions.IdTypesOfEdition = TypesOfEdition.Id
where
	TypesOfEdition.[Type] = @selectType;

-- вывод всех изданий с заданным типом после увеличения цены
select
	Editions.Id
	, Editions.Title
	, Editions.IndexEdition
	, TypesOfEdition.[Type]
	, Editions.Price
from 
	Editions inner join TypesOfEdition on Editions.IdTypesOfEdition = TypesOfEdition.Id
where
	TypesOfEdition.[Type] = @selectType;

go

-- 14	Запрос на обновление	
-- В таблице ДОСТАВКА увеличить срок подписки на заданное 
-- параметром количество месяцев
declare @countMonths int = 5;
	
-- вывод записей до увеличения подписок 
select
	Delivery.Id
	, Subscribers.LastName
	, Subscribers.FirstName
	, Subscribers.Patronymic
	, Subscribers.NumberPassport
	, Streets.Street
	, Editions.IndexEdition
	, Editions.Title
	, TypesOfEdition.[Type]
	, Editions.Price
	, Delivery.DateStartSubscribe
	, Delivery.SubsctibePeriodMonths
from 
	Delivery inner join (Subscribers inner join Streets on Subscribers.IdStreets = Streets.Id)
			 on Delivery.IdSubscribers = Subscribers.Id
			 inner join (Editions inner join TypesOfEdition on Editions.IdTypesOfEdition = TypesOfEdition.Id)
			 on Delivery.IdEditions = Editions.Id;

-- увеличение подписки на заданное значение
update 
	Delivery
set
	SubsctibePeriodMonths += @countMonths;

-- вывод записей до увеличения подписок 
select
	Delivery.Id
	, Subscribers.LastName
	, Subscribers.FirstName
	, Subscribers.Patronymic
	, Subscribers.NumberPassport
	, Streets.Street
	, Editions.IndexEdition
	, Editions.Title
	, TypesOfEdition.[Type]
	, Editions.Price
	, Delivery.DateStartSubscribe
	, Delivery.SubsctibePeriodMonths
from 
	Delivery inner join (Subscribers inner join Streets on Subscribers.IdStreets = Streets.Id)
			 on Delivery.IdSubscribers = Subscribers.Id
			 inner join (Editions inner join TypesOfEdition on Editions.IdTypesOfEdition = TypesOfEdition.Id)
			 on Delivery.IdEditions = Editions.Id;

go