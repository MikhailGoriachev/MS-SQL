-- создание таблицы ВРАЧИ
CREATE TABLE [dbo].[Doctors] (
    [Id]				INT            PRIMARY KEY IDENTITY (1, 1) NOT NULL,        -- Id
    [LastNameDoctor]	NVARCHAR (40)  NOT NULL,                                    -- фамилия доктора
    [FirstNameDoctor]	NVARCHAR (40)  NOT NULL,                                    -- имя доктора
    [PatronymicDoctor]	NVARCHAR (40)  NOT NULL,                                    -- отчество доктора
    [Speciality]		NVARCHAR (100) NOT NULL,                                    -- специальность (хирург, терапевт и т.д)
    [Price]				INT            NOT NULL,                                    -- цена приёма
	[PercentSalary]		FLOAT		   NOT NULL,                                    -- процент отчисления от стоимости приема на зарплату врача
    CONSTRAINT [CK_Doctors_Price]			CHECK ([Price] >= 0),
    CONSTRAINT [CK_Doctors_PercentSalary]	CHECK ([PercentSalary] >= 0.)
);

-- удаление таблицы ВРАЧИ
-- drop table [Doctors];

-- создание таблицы ПАЦИЕНТЫ
CREATE TABLE [dbo].[Patients] (
    [Id]                INT            PRIMARY KEY IDENTITY (1, 1) NOT NULL,        -- Id
    [LastNamePatient]   NVARCHAR (40)  NOT NULL,                                    -- фамилия пациента
    [FirstNamePatient]  NVARCHAR (40)  NOT NULL,                                    -- имя пациента
    [PatronymicPatient] NVARCHAR (40)  NOT NULL,                                    -- отчество пациента
    [DateBirthPatient]  DATE           NOT NULL,                                    -- дата рождения
    [Address]           NVARCHAR (120) NOT NULL,                                    -- адрес проживания 
);

-- удаление таблицы ПАЦИЕНТЫ
-- drop table [Patients];

-- создание таблицы ПРИЕМЫ
CREATE TABLE [dbo].[Receptions](
    [Id]            INT     PRIMARY KEY IDENTITY (1, 1) NOT NULL,
    [IdPatient]     INT     NOT NULL,
    [IdDoctor]      INT     NOT NULL,
    [Date]          DATE    NOT NULL,
    CONSTRAINT [CK_Receptions_Date] CHECK ([Date] >= '01.01.1990'),    
    CONSTRAINT [FK_Receptions_Doctors] FOREIGN KEY ([IdDoctor]) REFERENCES [Doctors]([Id]),
	CONSTRAINT [FK_Receprions_Patients] FOREIGN KEY ([IdPatient]) REFERENCES [Patients]([Id])
)

-- удаление таблицы ПРИЕМЫ
-- drop table [Receptions];

-----------------------------------------------------------------------------------
-- Удаление таблиц

-- удаление таблицы ПРИЕМЫ
-- drop table [Receptions];

-- удаление таблицы ПАЦИЕНТЫ
-- drop table [Patients];

-- удаление таблицы ВРАЧИ
-- drop table [Doctors];