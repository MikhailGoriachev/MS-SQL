-- удаление таблиц
drop table if exists Sales;			-- удаление таблицы Sales		(Продажи)
drop table if exists Purchases;		-- удаление таблицы Purchases	(Закупки)
drop table if exists Sellers;		-- удаление таблицы Sellers		(Продавцы)
drop table if exists Units;			-- удаление таблицы Units		(Единицы_измерения)
drop table if exists Goods;			-- удаление таблицы Goods		(Товары)

-- создание таблицы Units		(Единицы_измерения)
create table dbo.Units (
	Id				int				not null		primary key identity,
	Short			nvarchar(15)	not null,		-- Сокращённое название
	Long			nvarchar(30)	not null,		-- Полное название
);


-- создание таблицы Goods		(Товары)
create table dbo.Goods (
	Id				int				not null		primary key identity,
	[Name]			nvarchar(50)    not null,		-- Название товара
);


-- создание таблицы Sellers		(Продавцы)
create table dbo.Sellers (
	Id			int				not null		primary key identity,
	Surname		nvarchar(60)	not null,		-- Фамилия    
	[Name]		nvarchar(60)	not null,		-- Имя 
	Patronymic	nvarchar(80)	not null,		-- Отчество 
	Interest	float			not null, 		-- Процент от продажи
	constraint CK_Sellers_Interest	check	(Interest > 0)
);


-- создание таблицы Purchases	(Закупки)
create table dbo.Purchases (
	Id				int				not null		primary key identity,
	IdGoods			int				not null,		-- Название товара 
	IdUnit			int				not null,		-- Единица измерения
	Price			int				not null,		-- Цена закупки
	Amount			int				not null,		-- Количество единиц товара 
	DatePurchase	date			not null,		-- Дата закупки
	constraint CK_Purchases_Price			check (Price > 0),			-- ограничение по цене закупки
	constraint CK_Purchases_Amount			check (Amount > 0),			-- ограничение по количеству
	constraint CK_Purchases_DatePutchase	check (DatePurchase < getDate()),	-- Ограничение по дате закупки
	constraint FK_Purchases_IdGoods			foreign key (IdGoods)	references Goods(Id),		-- внешний ключ товара
	constraint FK_Purchases_IdUnit			foreign key (IdUnit)	references Units(Id)		-- единицы ихмерения
);


-- создание таблицы Sales		(Продажи)
create table dbo.Sales (
	Id				int				not null		primary key identity,
	DateSell		date			not null,		-- Дата продажи
	IdSeller		int				not null,		-- Продавец
	IdPurchase		int				not null,		-- Закупленный товар
	Amount			int				not null,		-- Количество товара
	Price			int				not null,		-- Цена продажи единицы товара
	IdUnit			int				not null,		-- Единица измерения
	constraint CK_Sales_DateSell	check (DateSell < getdate()),		-- ограничение по дате продажи
	constraint CK_Sales_Amount		check (Amount > 0),					-- ограничение по количеству товара
	constraint CK_Sales_Price		check (Price > 0),					-- ограничение по цене продажи единицы товара
	constraint FK_Sales_IdSeller	foreign key (IdSeller)		references Sellers(Id),			-- внешний ключ продавца
	constraint FK_Sales_IdPurchase	foreign key (IdPurchase)    references Purchases(Id),		-- внешний ключ закупленного товара
	constraint FK_Sales_IdUnit		foreign key (IdUnit)		references Units(Id)			-- внешний ключ единицы измерения
);