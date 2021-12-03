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

-- создание представления для продавцов
create view ViewSellers as
    select
       Sellers.Id
       , Persons.Surname
       , Persons.[Name]
       , Persons.Patronymic
       , Persons.Passport
       , Sellers.Interest
    from
        Sellers join Persons on Sellers.IdPerson = Persons.Id;
go

-- использование представления для продавцов
select
    *
from
    ViewSellers;
go   

-- создание представления для закупок товаров
create view ViewPurchases as
    select
        Purchases.Id
        , Goods.Item
        , Units.Short
        , Units.Long
        , Purchases.PurchaseDate
        , Purchases.Price
        , Purchases.Amount
    from
        Purchases join Goods on Purchases.IdItem = Goods.Id
                  join Units on Purchases.IdUnit = Units.Id;
go

-- использование представления
select
    *
from 
    ViewPurchases;
go
    

-- создание представления для фактов продаж
create view ViewSales as
    select top (select count(*) from Sales)
        Sales.Id
        , Goods.Item
        , Units.Short
        , Units.Long
        , Persons.Surname
        , Persons.[Name]
        , Persons.Patronymic
        , Persons.Surname + N' ' + Substring(Persons.[Name], 1, 1) + N'.' + Substring(Persons.Patronymic, 1, 1) + N'.' as Seller
        , Sales.SaleDate
        , Purchases.Price   as PurchasePrice
        , Sales.Price       as SalePrice
        , Sales.Amount      as SaleAmount
        , (Sales.Price - Purchases.Price) * Sales.Amount as Profit
    from
        Sales join (Sellers join Persons on Sellers.IdPerson = Persons.Id) on Sales.IdSeller = Sellers.IdPerson
              join (Purchases join Goods on Purchases.IdItem = Goods.Id) on Sales.IdPurchase = Purchases.Id
              join Units on Sales.IdUnit = Units.Id
    order by Sales.SaleDate;
go


-- использование представления фактов продаж
select
    *
from
    ViewSales;
go

-- Запрос к представлению с параметрами	
-- Выбирает информацию о товарах, единицей измерения которых 
-- является «шт» (штуки) и цена закупки составляет меньше 200 руб.
declare @unit nvarchar(6) = N'шт', @price int = 200;

select
    Id
    , Item
    , Short
    , PurchaseDate
    , Price
    , Amount
from
    ViewPurchases
where
    Short = @unit and Price < @price;
go


-- Запрос к предстьавлению с параметрами	
-- Выбирает информацию о товарах, цена закупки которых больше 
-- 500 руб. за единицу товара
declare @price int = 500;

select
    Id
    , Item
    , Short
    , PurchaseDate
    , Price
    , Amount
from
    ViewPurchases
where
    Price > @price;
go


-- Запрос к представлению  с параметрами	
-- Выбирает информацию о продавцах с заданным значением
-- процента комиссионных.
declare @interest float = 3.5;

select
   Id
   , Surname
   , [Name]
   , Patronymic
   , Interest
from
    ViewSellers
where 
    Interest = @interest;
go

-- Запрос к представлению с параметрами	
-- Выбирает информацию обо всех 
-- зафиксированных фактах продажи товаров (Наименование товара, Цена закупки, 
-- Цена продажи, дата продажи), для которых Цена продажи оказалась в некоторых 
-- заданных границах. 
declare @fromPrice int = 15000, @toPrice int = 150000;

select
    Id
    , Item
    , Short
    , Seller
    , SaleDate
    , PurchasePrice
    , SalePrice
    , SaleAmount
from
    ViewSales
where
    SalePrice between @fromPrice and @toPrice;
go

-- Запрос к представлению с вычисляемыми полями	
-- Вычисляет прибыль от продажи за каждый проданный товар. Включает поля 
-- Дата продажи, Наименование товара, Цена закупки, Цена продажи, Количество 
-- проданных единиц, Прибыль. Сортировка по полю Наименование товара
select
    Id
    , Item
    , Short
    , Seller
    , SaleDate
    , SaleAmount
    , PurchasePrice
    , SalePrice
    , Profit 
from
    ViewSales
order by
    Item;
go

-- пример изменения представления
-- Запрос на обновление представления	
-- Устанавливает значение в поле Процент комиссионных таблицы ПРОДАВЦЫ 
-- равным 10% для тех продавцов, процент комиссионных которых составляет 8%
declare @boundInterest float = 10, @newInterest float = 11.5;

update
    ViewSellers
set
    Interest = @newInterest
where
    Interest = @boundInterest;
go

select * from Sellers;
select * from ViewSellers;
go

update
    ViewSellers
set
    Passport += ' AB', 
    Patronymic += '*';
go

-- это не работает, т.к. поля принадлежат разным таблицам
update
    ViewSellers
set
    Interest = 2.5,
    Passport += ' AB', 
    Patronymic += '*';
go


-- это не работает, т.к. затрагивает несколько таблиц
delete from  
     ViewPurchases
where
     PurchaseDate between '11-01-2021' and '11-30-2021';
go
