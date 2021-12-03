-- вывод всех записей таблицы Units			(Единицы_измерения)
select
	Units.Id
	, Units.Long
	, Units.Short
from
	Units;


-- вывод всех записей таблицы Goods			(Товары)
select
	Goods.Id
	, Goods.[Name]
from
	Goods;


-- вывод всех записей таблицы Sellers		(Продавцы)
select
	Sellers.Id
	, Sellers.Surname
	, Sellers.[Name]
	, Sellers.Patronymic
	, Sellers.Interest
from
	Sellers;


-- вывод всех записей таблицы Purchases		(Закупки)
select
	Purchases.Id
	, Goods.[Name]
	, Units.Long
	, Units.Short
	, Purchases.Price
	, Purchases.Amount
	, Purchases.DatePurchase
from
	Purchases inner join Goods on Purchases.IdGoods = Goods.Id
			  inner join Units on Purchases.IdUnit = Units.Id;


-- вывод всех записей таблицы Sales			(Продажи)
select
	Sales.Id
	, Sales.DateSell
	, Sellers.Surname
	, Sellers.[Name]
	, Sellers.Patronymic
	, Sellers.Interest
	, Goods.[Name]
	, PurUnit.Long	as UnitPurchase
	, Purchases.Price
	, Purchases.Amount
	, Purchases.DatePurchase
	, Sales.Amount
	, Sales.Price
	, SaleUnit.Long	as UnitSale
from
	Sales inner join Sellers on Sales.IdSeller = Sellers.Id
		  inner join (Purchases inner join Goods on Purchases.IdGoods = Goods.Id
								inner join Units PurUnit on Purchases.IdUnit = PurUnit.Id)
					on Sales.IdPurchase = Purchases.Id
		  inner join Units SaleUnit on Sales.IdUnit = SaleUnit.Id;
 

-- 1	Запрос с параметрами
-- Выбирает из таблицы ТОВАРЫ информацию о товарах, единицей измерения
-- которых является «шт» (штуки) и цена закупки составляет меньше 200 руб.

declare @unitShort nvarchar(15) = N'шт', @price int = 200;

select
	Purchases.Id
	, Goods.[Name]
	, Units.Short
	, Purchases.Price
	, Purchases.Amount
	, Purchases.DatePurchase
from
	Purchases inner join Units on Purchases.IdUnit = Units.Id
			  inner join Goods on Purchases.IdGoods = Goods.Id
where
	Purchases.Price < @price and Units.Short = @unitShort;
go 


-- 2	Запрос с параметрами
-- Выбирает из таблицы ТОВАРЫ информацию о товарах, цена закупки которых 
-- больше 500 руб. за единицу товара
declare @price int = 500;

select
	Purchases.Id
	, Goods.[Name]
	, Units.Short
	, Purchases.Price
	, Purchases.Amount
	, Purchases.DatePurchase
from
	Purchases inner join Units on Purchases.IdUnit = Units.Id
			  inner join Goods on Purchases.IdGoods = Goods.Id
where
	Purchases.Price > @price;
go 


-- 3	Запрос с параметрами
-- Выбирает из таблицы ТОВАРЫ информацию о товарах с заданным наименованием 
-- (например, «чехол защитный»), для которых цена закупки меньше 1800 руб.
declare @price int = 1800, @goods nvarchar(50) = N'Тетардь Interdruk';

select
	Purchases.Id
	, Goods.[Name]
	, Units.Short
	, Purchases.Price
	, Purchases.Amount
	, Purchases.DatePurchase
from
	Purchases inner join Units on Purchases.IdUnit = Units.Id
			  inner join Goods on Purchases.IdGoods = Goods.Id
where
	Goods.[Name] = @goods and Purchases.Price < @price;
go 



-- 4	Запрос с параметрами
-- Выбирает из таблицы ПРОДАВЦЫ информацию о продавцах с заданным значением 
-- процента комиссионных. 
declare @interest int = 8;

select
	Sellers.Id
	, Sellers.Surname
	, Sellers.[Name]
	, Sellers.Patronymic
	, Sellers.Interest
from
	Sellers
where
	Sellers.Interest = @interest;
go

-- 5	Запрос с параметрами
-- Выбирает из таблиц ТОВАРЫ, ПРОДАВЦЫ и ПРОДАЖИ информацию обо всех 
-- зафиксированных фактах продажи товаров (Наименование товара, Цена закупки, 
-- Цена продажи, дата продажи), для которых Цена продажи оказалась в некоторых 
-- заданных границах. 
declare @lo int = 700, @hi int = 800;

select
	Sales.Id
	, Goods.[Name]
	, PurUnit.Long		as UnitPurchase
	, Purchases.Price	as PricePurchase
	, Sales.Price		as PriceSell
	, SaleUnit.Long		as UnitSale
	, Sales.Amount		as AmountSell
	, Sales.DateSell
from
	Sales inner join (Purchases inner join Goods on Purchases.IdGoods = Goods.Id
								inner join Units PurUnit on Purchases.IdUnit = PurUnit.Id)
					on Sales.IdPurchase = Purchases.Id
		  inner join Units SaleUnit on Sales.IdUnit = SaleUnit.Id
where
	Sales.Price between @lo and @hi;
go

-- 6	Запрос с вычисляемыми полями	
-- Вычисляет прибыль от продажи за каждый проданный товар. Включает поля: Дата
-- продажи, Наименование товара, Цена закупки, Цена продажи, Количество проданных 
-- единиц, Прибыль. Сортировка по полю Наименование товара
select
	Sales.Id
	, Goods.[Name]
	, PurUnit.Long		as UnitPurchase
	, Purchases.Price	as PricePurchase
	, Sales.Price		as PriceSell
	, (Sales.Price - Purchases.Price) * Sales.Amount as Profit
	, SaleUnit.Long		as UnitSale
	, Sales.Amount		as AmountSell
	, Sales.DateSell
from
	Sales inner join (Purchases inner join Goods on Purchases.IdGoods = Goods.Id
								inner join Units PurUnit on Purchases.IdUnit = PurUnit.Id)
					on Sales.IdPurchase = Purchases.Id
		  inner join Units SaleUnit on Sales.IdUnit = SaleUnit.Id
order by
	Goods.[Name];

 
-- 7	Запрос на левое соединение	
-- Выбирает всех продавцов (выводить Код продавца, фамилию и инициалы продавца), 
-- количество и суммы их продаж за заданный период, упорядочивать по фамилиям и 
-- инициалам 
declare @dateLo date = N'2021/09/01', @dateHi date = N'2021/10/31';

select
	Sellers.Id
	, Sellers.Surname + ' ' 
		+ Substring(Sellers.[Name], 1, 1) + '. ' 
		+ Substring(Sellers.Patronymic, 1, 1) + '.' as Seller
	, Count(Sales.Id) as Amount
	, Sum(Sales.Price * Sales.Amount) as SumPrice
from
	Sellers left join Sales on Sellers.Id = Sales.IdSeller
where
	Sales.DateSell between @dateLo and @dateHi
group by
	Sellers.Id, Sellers.Surname, Sellers.[Name], Sellers.Patronymic
order by
	Seller;
	

-- 8	Запрос на левое соединение	
-- Выбирает все товары, количество и сумму продаж по этим товарам. Упорядочивать 
-- по убыванию суммы продаж
select
	Goods.Id
	, Goods.[Name]
	, Count(Sales.Id) as Amount
	, Sum(Sales.Price * Sales.Amount) as SumPrice
from
	Goods left join (Sales inner join Purchases on Sales.IdPurchase = Purchases.Id) 
			on Goods.Id = Purchases.IdGoods
group by
	Goods.Id, Goods.[Name]
order by
	SumPrice desc;

		
-- 9	Итоговый запрос	
-- Выполняет группировку по полю Наименование товара. Для каждого наименования
-- вычисляет среднюю цену закупки товара, количество закупок
select
	Goods.Id
	, Goods.[Name]
	, Count(Purchases.Id) as Amount
	, Sum(Purchases.Price) as SumPrice
from
	Goods left join Purchases on Goods.Id = Purchases.IdGoods
group by
	Goods.Id, Goods.[Name]
order by
	SumPrice desc;


-- 10	Итоговый запрос	
-- Выполняет группировку по полю Код продавца из таблицы ПРОДАЖИ. Для каждого 
-- продавца вычисляет среднее значение по полю Цена продажи единицы товара, 
-- количество продаж
select
	Sellers.Id
	, Sellers.Surname
	, Sellers.[Name]
	, Sellers.Patronymic
	, Count(Sales.Id) as Amount
	, Min(Sales.Price) as MinPrice
	, Avg(Sales.Price) as AvgPrice
	, Max(Sales.Price) as MaxPrice
from
	Sales inner join Sellers on Sales.IdSeller = Sellers.Id
group by 
	Sellers.Id, Sellers.Surname, Sellers.[Name], Sellers.Patronymic;


-- 11	Итоговый запрос с объединением	
-- Тремя запросами к таблице ТОВАРЫ с объединением определить минимальную цену 
-- закупки единицы товара, среднюю цену закупки единицы товара, максимальную цену 
-- закупки единицы товара. Выводить текстовые названия значений 

-- максимальная цена единицы товара
select
	N'Максимальная цена ед. товара' as Info
	, Max(Purchases.Price) as [Value]
from
	Purchases

union all

-- средняя цена единицы товара
select
	N'Средняя цена ед. товара'
	, Avg(Purchases.Price)
from
	Purchases

union all

-- минимальная цена единицы товара
select
	N'Минимальная цена ед. товара' 
	, Min(Purchases.Price) 
from
	Purchases

union all

-- количество товаров
select
	N'Количество'
	, Count(*)
from
	Purchases;


-- 12	Итоговый запрос с объединением	
-- Двумя запросами с объединением к таблицам ТОВАРЫ, ПРОДАВЦЫ, ПРОДАЖИ выводить 
-- наименование товара и его количество, фамилии и инициалы продавцов и количество 
-- продаж
select
	Goods.[Name] as Info
	, (select Sum(Purchases.Amount) from Purchases inner join Sales 
		on Purchases.Id = Sales.IdPurchase where Purchases.IdGoods = Goods.Id) as Amount
from
	Sales inner join (Purchases inner join Goods on Purchases.IdGoods = Goods.Id)
			on Sales.IdPurchase = Purchases.Id

union 

select
	Sellers.Surname + ' ' 
		+ Substring(Sellers.[Name], 1, 1) + '. ' 
		+ Substring(Sellers.Patronymic, 1, 1) + '.' as Seller
	, (select Count(*) from Sales where Sellers.Id = Sales.IdSeller group by Sales.IdSeller)
from
	Sales inner join Purchases on Sales.IdPurchase = Purchases.Id
	 	  inner join Sellers on Sales.IdSeller = Sellers.Id;


-- 13	Запрос на создание базовой таблицы	
-- Создает таблицу ТОВАРЫ_ШТ, содержащую информацию о товарах, единицей измерения 
-- которых является «шт» (штуки)
drop table if exists Purchases_Pieces;

declare @unitShort nvarchar(15) = N'шт';

select
	*
	into Purchases_Pieces
from
	Purchases
where
	Purchases.IdUnit = any (select Units.Id from Units where Units.Short = @unitShort);
go


-- 14	Запрос на создание базовой таблицы	
-- Создает копию таблицы ТОВАРЫ с именем КОПИЯ_ТОВАРЫ
drop table if exists Copy_Purchases;

select 
	*
	into Copy_Purchases
from
	Purchases;


-- 15	Запрос на удаление	
-- Удаляет из таблицы КОПИЯ_ТОВАРЫ записи, в которых значение в поле Цена закупки 
-- единицы товара больше 500 руб.
declare @price int = 500;

delete from 
	Copy_Purchases
where
	Copy_Purchases.Price > @price;
go
	

-- 16	Запрос на обновление	
-- Устанавливает значение в поле Процент комиссионных таблицы ПРОДАВЦЫ равным 10 % 
-- для тех продавцов, процент комиссионных которых составляет 8 %
declare @interestCur int = 8, @interestNew int = 10;

update
	Sellers
set
	Interest = @interestNew
where
	Interest = @interestCur;
go