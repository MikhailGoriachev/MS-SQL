-- удаление таблиц
drop table if exists Rentals;			-- удаление таблицы Rentals (Факты_проката)
drop table if exists Cars;				-- удаление таблицы Cars (Машины)
drop table if exists Clients;			-- удаление таблицы Clients (Клиенты)
drop table if exists Colors;			-- удаление таблицы Colors (цвета)
drop table if exists Brands;			-- удаление таблицы Brands (Модели_автомобилей)

-- создание таблицы Brands (Модели_автомобилей)
create table dbo.Brands (
	Id				int				not null		primary key identity,
	Brand			nvarchar(30)	not null,		-- Модель машины
);


-- создание таблицы Colors (цвета)
create table dbo.Colors (
	Id				int				not null		primary key identity,
	Color			nvarchar(40)    not null,		-- Нащвание цвета
);


-- создание таблицы Clients (Клиенты)
create table dbo.Clients (
	Id			int				not null		primary key identity,
	Surname		nvarchar(60)	not null,		-- Фамилия клиента   
	[Name]		nvarchar(60)	not null,		-- Имя клиента
	Patronymic	nvarchar(80)	not null,		-- Отчество клиента
	Passport	nvarchar(15)	not null, 		-- Серия, номер паспорта клиента
	constraint UQ_Clients_Passport unique(Passport) -- Установка проверки на уникальность паспорта
);


-- создание таблицы Cars (Машины)
create table dbo.Cars (
	Id				int				not null		primary key identity,
	IdBrand			int				not null,		-- Модель 
	IdColor			int				not null,		-- Цвет 
	Plate			nvarchar(9)		not null,		-- Госномер 
	YearManuf		int				not null,		-- Год выпуска
	InshurancePay	int				not null,		-- Страховая стоимость 
	Rental			int				not null,		-- Стоимость одного дня проката
	constraint CK_Cars_YearManuf check (YearManuf > 2000),		-- ограничение по году выпуска
	constraint CK_Cars_InshurancePay check (InshurancePay > 1),	-- ограничение по страховой стоимости
	constraint CK_Cars_Rental	check (Rental > 1),				-- ограничение по стоимости одного дня
	constraint UQ_Cars_Plate	unique(Plate),					-- установка проверки на уникальность госномера
	constraint FK_Cars_IdBrand foreign key (IdBrand) references Brands(Id),		-- внешний ключ модели
	constraint FK_Cars_IdColor foreign key (IdColor) references Colors(Id)		-- внешний ключ цвета
);


-- создание таблицы Rentals (Факты_проката)
create table dbo.Rentals (
	Id				int				not null		primary key identity,
	IdClient		int				not null,		-- Клиент 
	IdCar			int				not null,		-- Автомобиль
	DateStart		Date			not null,		-- Дата начала проката
	Duration		int				not null,		-- Количество дней проката
	constraint CK_Rentals_DateStart check (DateStart <= getdate()),		-- ограничение по дате начала проката
	constraint CK_Rentals_Duration  check (Duration between 1 and 15),	-- ограничение по количеству дней проката
	constraint FK_Rentals_IdClient foreign key (IdClient) references Clients(Id),	-- внешний ключ клиента
	constraint FK_Rentals_IdCar	   foreign key (IdCar)    references Cars(Id)		-- внешний ключ автомобиля
);