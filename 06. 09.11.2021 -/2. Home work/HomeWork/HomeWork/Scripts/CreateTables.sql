-- создание таблицы TypesOfEdition			(Виды изданий)
create table dbo.TypesOfEdition (
	Id					int				primary key not null	identity,		-- Первичный ключ
	[Type]				nvarchar(100)				not null		-- Вид издания 
);

-- cоздание таблицы Editions				(Издания)
create table dbo.Editions (
	Id					int				primary key not null	identity,		-- Первичный ключ
	IndexEdition		nvarchar(10)				not null,
	IdTypesOfEdition	int							not null,		-- Вид издания
	Title				nvarchar(120)				not null,		-- Название публикации
	Price				int							not null,		-- Цена публикации
	constraint	[CK_Editions_Price]	check (Price >= 0),
	constraint	[FK_Editions_IdTypesOfEdition] foreign key (IdTypesOfEdition) references dbo.TypesOfEdition(Id)	-- Внешний ключ
);

-- создание таблицы Streets					(Улицы)
create table dbo.Streets (
	Id					int				primary key	not null	identity,
	Street				nvarchar(120)				not null,	-- Название улицы
);

-- создание таблциы Subscribers				(Подписчики)
create table dbo.Subscribers (
	Id					int				primary key	not null	identity,		-- Первичный ключ
	LastName			nvarchar(40)				not null,		-- Фамилия
	FirstName			nvarchar(40)				not null,		-- Имя
	Patronymic			nvarchar(40)				not null,		-- Отчество
	NumberPassport		nvarchar(20)				not null,		-- Номер паспорта
	IdStreets			int							not null,		-- Улица
	NumberHome			nvarchar(10)				not null,		-- Номер дома
	NumberApartment		nvarchar(10)				null,			-- Номер квартиры
	constraint	[FK_Subscribers_IdStreets] foreign key (IdStreets) references dbo.Streets(Id)	-- Внешний ключ
);

-- создание таблциы Delivery				(Доставка)
create table dbo.Delivery (
	Id						int				primary key not null	identity,		-- Первичный ключ
	IdSubscribers			int				not null,					-- Подписчик
	IdEditions				int				not null,					-- Публикация
	DateStartSubscribe		date			not null,					-- Дата начала подписки
	SubsctibePeriodMonths	int				not null,					-- Количество месяцев подписки
	constraint	[FK_Delivery_IdSubscribers] foreign key (IdSubscribers) references dbo.Subscribers(Id),	-- Внешний ключ
	constraint	[FK_Delivery_IdEditions]	foreign key	(IdEditions) references	dbo.Editions(Id)		-- Внешний ключ
);

-- удаление таблиц
-- drop table if exists Delivery;
-- drop table if exists Editions;
-- drop table if exists Subscribers;
-- drop table if exists TypesOfEdition;
-- drop table if exists Streets;