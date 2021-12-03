/* 
 * База данных «Оптовый магазин. Учет продаж» 
 */

-- создание таблиц базы данных

-- при повторном запуске скрипта удаляем старые варианты таблиц, не разбирая 
-- пустые они или нет. Таблицы удаляем в порядке, обратном порядку создания. 
-- Точнее - сначала удаляем таблицы с внешними ключами, затем остальные 
drop table if exists Sales;        -- факты продаж товаров продавцами
drop table if exists Sellers;      -- продавцы 
drop table if exists Persons;      -- персональные данные продавцов
drop table if exists Purchases;    -- факты закупок товаров
drop table if exists Goods;        -- номенклатура товаров
drop table if exists Units;        -- единицы измерения товаров

-- таблица справочник единиц измерения товара - Units
create table dbo.Units(
	Id     int          not null primary key identity (1, 1),
	Short  nvarchar(6)  not null,   -- краткое наименование единицы измерения
	Long   nvarchar(26) not null    -- полное наименование единицы измерения
); 
go

-- таблица справочник номенклатуры товаров - Goods
create table dbo.Goods(
	Id    int          not null primary key identity (1, 1),
	Item  nvarchar(60) not null   -- наименование товара
); 
go

-- таблица фактов закупки товаров Purchases
create table dbo.Purchases(
	Id            int  not null primary key identity (1, 1),
	IdItem        int  not null, -- внешний ключ, ссылка на номенклатуру товара
	IdUnit        int  not null, -- внешний ключ, ссылка на единицу измерения товара
	PurchaseDate  date not null, -- дата закупки
	Price         int  not null, -- цена закупки единицы товара
	Amount        int  not null, -- количество закупаемого товара

	-- ограничения по значением полей/столбцов
	constraint    CK_Purchases_PurchaseDate check(PurchaseDate > '01-01-2021'),
	constraint    CK_Purchases_Price        check(Price > 0),
	constraint    CK_Purchases_Amount       check(Amount > 0),

	-- внешние ключи
	constraint    FK_Purchases_Goods  foreign key (IdItem) references dbo.Goods(Id), 
	constraint    FK_Purchases_Units  foreign key (IdUnit) references dbo.Units(Id) 
); 
go

-- таблица персональных данных продавцов магазина - Persons
create table dbo.Persons (
	Id          int          not null primary key identity (1, 1),
	Surname     nvarchar(60) not null,    -- Фамилия продавца
	[Name]      nvarchar(50) not null,    -- Имя продавца
	Patronymic  nvarchar(60) not null,    -- Отчество продавца
	Passport    nvarchar(15) not null,    -- Серия и номер паспорта продавца

	-- ограничение уникальности значения столбца
	-- https://docs.microsoft.com/ru-ru/sql/relational-databases/tables/create-unique-constraints?view=sql-server-ver15
	constraint  CK_Persons_Passport unique(Passport)
);
go

-- таблица продавцов - Sellers
create table dbo.Sellers (
	Id        int   not null primary key identity (1, 1),
	IdPerson  int   not null,   -- внешнией ключ, ссылка на Persons, персональные данные
	Interest  float not null,   -- процент комиссионного вознаграждения за продажу

	-- процент комисионных в диапазоне 1%, ..., 15%
	constraint CK_Sellers_Interest check(Interest between 1.0 and 15.0),  
	
	-- внешний ключ для связи с таблицей персональных данных  
	constraint FK_Sellers_Persons foreign key (IdPerson) references dbo.Persons(Id) 
);
go

-- таблица регистрации фактов продаж - Sales
-- продавать можем только те товары, которые есть в таблице закупок
create table Sales(
	Id          int   not null primary key identity (1, 1),
	IdPurchase  int   not null,  -- внешний ключ, ссылка на Purchases, что продаем 
	IdUnit      int   not null,  -- внешний ключ, ссылка на Units, единицы измерения товара
	IdSeller    int   not null,  -- внешний ключ, ссылка на Sellers, кто продает
	SaleDate    date  not null,  -- дата продажи
	Price       int   not null,  -- цена продажи единицы товара
	Amount      int   not null,  -- количество продаваемого торвара

	-- проверочные ограничения
	constraint  CK_Sales_SaleDate  check(SaleDate > '01-01-2021'),
	constraint  CK_Sales_Price     check(Price > 0),
	constraint  CK_Sales_Amount    check(Amount > 0),

	-- внешние ключи
	constraint  FK_Sales_Purchases foreign key (IdPurchase) references dbo.Purchases(Id),
	constraint  FK_Sales_Units     foreign key (IdUnit)     references dbo.Units(Id),
	constraint  FK_Sales_Sellers   foreign key (IdSeller)   references dbo.Sellers(Id)
);
go
