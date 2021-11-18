-- создание таблицы Persons (Персоны)
create table dbo.Persons (
	Id				int				not null	primary key identity,
	LastName		nvarchar(60)	not null,				-- Фамилия
	FirstName		nvarchar(60)	not null,				-- Имя
	Patronymic		nvarchar(80)	not null,				-- Отчество
);

-- создание таблицы Streets (Улицы)
create table Streets (
	Id				int				not null	primary key identity,
	Street			nvarchar(120)	not null,			-- Название улицы
);

-- создание таблицы Realtors (Риэлторы)
create table dbo.Realtors (
	Id				int			not null	primary key identity,
	IdPersons		int			not null,				-- Персона
	RemunPercent	float		not null,				-- Процент вознаграждения
	constraint	CK_Realtors_RemunPercent	check (RemunPercent >= 0),
	constraint	FK_Realtors_IdPersons	foreign key	(IdPersons) references dbo.Persons(Id)
);

-- создание таблицы Owners (Владельцы)
create table dbo.Owners (
	Id				int				not null		primary key identity,
	IdPersons		int				not null,				-- Персона
	Passport		nvarchar(20)	not null,				-- Серия-номер паспорта
	constraint FK_Owners_IdPersons foreign key (IdPersons) references Persons(Id)
);

-- создание таблицы Immovables (Недвижимость)
create table dbo.Immovables (
	Id					int				not null		primary key identity,
	IdStreets			int				not null,			-- Улица
	HomeNumber			nvarchar(10)	not null,			-- Номер дома
	ApartmentNumber		nvarchar(10)	not null,			-- Номер квартиры (если информация отсутсвует - 0)
	AmountRooms			int				not null,			-- Количество комнат
	Area				float			not null,			-- Площадь (м2)
	Price				int				not null,			-- Цена
	constraint CK_Immovables_AmountRooms	check (AmountRooms >= 1),
	constraint CK_Immovables_Area			check (Area > 5),
	constraint CK_Immovables_Price			check (Price > 0),
	constraint FK_Immovables_IdStreets		foreign key (IdStreets)	references Streets(Id)
);

-- создание таблицы Transactions (Сделки)
create table dbo.Transactions (
	Id				int				not null		primary key identity,
	IdImmovables	int				not null,				-- Недвижимость
	IdRealtors		int				not null,				-- Риэлтор
	IdOwners		int				not null,				-- Владелец
	DateTrans		date			not null,				-- Дата сделки
	constraint CK_Transactions_DateTrans	check (DateTrans >= '2010/01/01'),
	constraint FK_Transactions_IdImmovables	foreign key (IdImmovables)	references Immovables(Id),
	constraint FK_Transactions_IdRealtors	foreign key (IdRealtors)	references Realtors(Id),
	constraint FK_Transactions_IdOwners		foreign key (IdOwners)		references Owners(Id)
);


-- удаление таблиц
-- drop table if exists Transactions;		-- удаленеие таблицы Transactions	(Сделки)
-- drop table if exists Immovables; 		-- удаленеие таблицы Immovables		(Недвижимость)
-- drop table if exists Realtors; 			-- удаленеие таблицы Realtors		(Риэлторы)
-- drop table if exists Owners; 			-- удаленеие таблицы Owners			(Владельцы)
-- drop table if exists Streets; 			-- удаленеие таблицы Streets		(Улицы)
-- drop table if exists Persons; 			-- удаленеие таблицы Persons		(Персоны)