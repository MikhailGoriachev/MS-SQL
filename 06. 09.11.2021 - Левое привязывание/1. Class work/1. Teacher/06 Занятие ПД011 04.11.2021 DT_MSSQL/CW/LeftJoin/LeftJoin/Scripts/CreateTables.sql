-- Создание таблиц бвзы данных

/*
drop table Appointments;
drop table Doctors;
drop table Patients;
drop table Persons;
drop table Specialities;
go
*/

-- удаление существующих таблиц, работает в MS SQL Server 2016+
drop table if exists Appointments;
drop table if exists Doctors;
drop table if exists Patients;
drop table if exists Persons;
drop table if exists Specialities;
go


-- Таблица персональных данных, одинаковых для докторов 
-- и пациентов - Persons
create table dbo.Persons (
	Id          int          not null primary key identity (1, 1),
	Surname     nvarchar(60) not null,    -- Фамилия персоны
	[Name]      nvarchar(50) not null,    -- Имя персоны
	Patronymic  nvarchar(60) not null     -- Отчество персоны
);
go


-- таблица -  справочник врачебных специальностей докторов Specialities
create table dbo.Specialities (
	Id          int          not null primary key identity (1, 1),
	Speciality  nvarchar(40) not null    -- название врачебной специальности
);
go


-- Таблица сведений о докторах ВРАЧИ --> Doctors
create table dbo.Doctors (
	Id           int          not null primary key identity (1, 1),
	IdPerson     int          not null,    -- Внешний ключ, связь с персональными данными
	IdSpeciality int          not null,    -- Внешний ключ, связь со справочником врачебных специальностей
	Price        int          not null,    -- Стоимость приема
	[Percent]    float        not null,    -- Процент отчисления от стоимости приема на зарплату врача
	
	-- ограничения полей таблицы
	constraint CK_Doctors_Price   check (Price > 0),
	constraint CK_Doctors_Percent check ([Percent] > 0),

	-- внешний ключ - связь 1:1 к таблице Persons
	constraint FK_Doctors_Persons foreign key (IdPerson) references dbo.Persons(Id),

	-- внешний ключ - связь M:1 к таблице Specialities (e.g.: много докторов одной специальности)  
	constraint FK_Doctors_Specialities foreign key (IdSpeciality) references dbo.Specialities(Id)
);
go


-- Таблица сведений о пациентах ПАЦИЕНТЫ --> Patients
create table dbo.Patients (
	Id          int          not null primary key identity (1, 1),
	IdPerson    int          not null,    -- Внешний ключ, связь с персональными данными
	BornDate    date         not null,    -- Дата рождения пациента
	[Address]   nvarchar(80) not null     -- Адрес проживания пациента
	
	-- внешний ключ - связь 1:1 к таблице Persons
	constraint  FK_Patients_Persons foreign key (IdPerson) references dbo.Persons(Id)
);
go


-- Таблица сведений о приемах пациентов докторами: ПРИЕМЫ --> Appointments  
create table dbo.Appointments (
    Id              int  not null primary key identity (1, 1),
	AppointmentDate date not null,
	IdPatient       int  not null,
	IdDoctor        int  not null,

	-- внешний ключ - связь M:1 к таблице пациентов
	constraint FK_Appointments_Patients foreign key (IdPatient) references dbo.Patients(Id),

	-- внешний ключ - связь M:1 к таблице докторов
	constraint FK_Appointments_Doctors foreign key (IdDoctor) references dbo.Doctors(Id)
);
go