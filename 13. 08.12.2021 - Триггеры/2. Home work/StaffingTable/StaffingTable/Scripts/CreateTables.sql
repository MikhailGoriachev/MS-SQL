drop table if exists StaffingTable;		-- удаление таблицы StaffingTable			(Штатное расписание)	 
drop table if exists DistributionUnits;	-- удаление таблицы DistributionUnits		(Распределение штатных единиц)	 
drop table if exists Devisions;			-- удаление таблицы Devisions				(Подразделения)	 
drop table if exists Units;				-- удаление таблицы Units					(Штатные единицы)	
drop table if exists WorkLevels;		-- удаление таблицы WorkLevels				(Рабочие разряды)
drop table if exists UnitTypes;			-- удаление таблицы UnitTypes				(Тип штатной единицы)	 
drop table if exists Persons;			-- удаление таблицы Persons					(Персоны)	 
drop table if exists DevisionTypes;		-- удаление таблицы DevisionTypes			(Типы подразделения)				
go

-- создание таблицы DevisionTypes			(Типы подразделения)				
create table dbo.DevisionTypes (
	Id			int				not null		primary key identity,
	Title		nvarchar(60)	not null		-- Название типа подразделения
);


-- создание таблицы Persons					(Персоны)	 
create table dbo.Persons (
	Id			int				not null		primary key identity,
	LastName	nvarchar(60)	not null,		-- Фамилия
	FirstName	nvarchar(60)	not null,		-- Имя
	Patronymic	nvarchar(80)	not null		-- Отчество
);


-- создание таблицы UnitTypes				(Тип штатной единицы)				
create table dbo.UnitTypes (
	Id			int				not null		primary key identity,
	Title		nvarchar(60)	not null		-- Название типа штатной единицы
);


-- создание таблицы WorkLevels				(Рабочие разряды)
create table dbo.WorkLevels (
	Id			int				not null		primary key identity,
	Title		nvarchar(30)	not null		-- Название рабочего разряда
);


-- создание таблицы Units					(Штатные единицы)	 
create table dbo.Units (
	Id						int				not null		primary key identity,
	IdUnitType				int				not null,		-- Тип штатной единицы
	Salary					int				not null,		-- Оклад
	IdWorkLevel				int				not null,		-- Рабочий разряд
	InterestAllowancetTwo	int				not null,		-- Процент надбавки 2
	LeaveDays				int				not null,		-- Количество дней отпуска
	constraint CK_Units_Salary check (Salary > 0),			-- ограничение по окладу
	constraint CK_Units_InterestAllowancetTwo check (InterestAllowancetTwo between 0 and 100), -- ограеничение проценту надбавки 2
	constraint CK_Units_LeaveDays check (LeaveDays >= 0), -- ограничение по количеству дней отпуска
	constraint FK_Units_IdUnitType  foreign key (IdUnitType)	references UnitTypes(Id),	-- внешний ключ типа штатной единицы
	constraint FK_Units_IdWorkLevel foreign key (IdWorkLevel)	references WorkLevels(Id)	-- внешний ключ рабочего разряда
);

-- создание таблицы Devisions				(Подразделения)	 
create table dbo.Devisions (
	Id						int				not null		primary key identity,
	IdDevisionType			int				not null,		-- Тип подразделения
	Title					nvarchar(60)	not null,		-- Название подразделения
	InterestAllowancetOne	int				not null,		-- Процент надбавки 1
	constraint CK_Devisions_InterestAllowancetOne check (InterestAllowancetOne between 0 and 100),	-- ограничение по проценту надвабвки 1
	constraint FK_Devisions_IdDevisionType foreign key (IdDevisionType) references DevisionTypes(Id)
);

-- создание таблицы DistributionUnits		(Распределение штатных единиц)	 
create table dbo.DistributionUnits (
	Id			int				not null		primary key identity,
	IdDevision	int				not null,		-- Подразделение
	IdUnit		int				not null,		-- Штатная единица
	Amount		int				not null,		-- Количество единиц
	constraint CK_DistributionUnits_Amount check (Amount >= 0),	-- ограничение по количеству единиц
	constraint FK_DistributionUnits_IdDevision	foreign key (IdDevision) references Devisions(Id),	-- внешний ключ подразделения
	constraint FK_DistributionUnits_IdUnit		foreign key (IdUnit)	 references Units(Id)		-- внешний ключ штатной единицы
);


-- создание таблицы StaffingTable			(Штатное расписание)	 
create table dbo.StaffingTable (
	Id			int				not null		primary key identity,
	IdDevision	int				not null,		-- Штатное подразделение
	IdPerson	int				not null,		-- Персона
	IdUnit		int				not null,		-- Штатная единица
	constraint FK_StaffingTable_IdDevision	foreign key (IdDevision)	references Devisions(Id),	-- внешний ключ штатного подразделения
	constraint FK_StaffingTable_IdPerson	foreign key (IdPerson)		references Persons(Id),		-- внещний ключ персоны
	constraint FK_StaffingTable_IdUnit		foreign key (IdUnit)		references Units(Id)		-- внешний ключ штатной единицы
);
