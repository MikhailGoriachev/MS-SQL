-- создание таблицы ВРАЧИ
CREATE TABLE [dbo].[Doctors] (
    [Id]				INT            PRIMARY KEY IDENTITY (1, 1) NOT NULL,
    [LastNameDoctor]	NVARCHAR (40)  NOT NULL,
    [FirstNameDoctor]	NVARCHAR (40)  NOT NULL,
    [PatronymicDoctor]	NVARCHAR (40)  NOT NULL,
    [Speciality]		NVARCHAR (100) NOT NULL,
    [Price]				INT            NOT NULL,
	[PercentSalary]		FLOAT		   NOT NULL,
    CONSTRAINT [CK_Doctors_Price]			CHECK ([Price] >= 0),
    CONSTRAINT [CK_Doctors_PercentSalary]	CHECK ([PercentSalary] >= 0.)
);

-- заполнение таблицы ВРАЧИ
insert into [Doctors]
    ([LastNameDoctor], [FirstNameDoctor], [PatronymicDoctor], [Speciality], [Price], [PercentSalary])
values
    (N'Потапов',    N'Устин',   N'Ярославович',     N'Хирург',      1000,   45),
    (N'Щукин',      N'Нестор',  N'Александрович',   N'Окулист',     2000,   30),
    (N'Романенко',  N'Ян',      N'Григорьевич',     N'Хирург',      1500,   2),
    (N'Петрив',     N'Борис',   N'Львович',         N'Терапевт',    900,    50),
    (N'Токар',      N'Эрик',    N'Вадимович',       N'Хирург',      1000,   4),
    (N'Горбунов',   N'Феликс',  N'Эдуардович',      N'Окулист',     1300,   15),    
    (N'Попов',      N'Ждан',    N'Васильевич',      N'Терапевт',    500,    38),
    (N'Мазайло',    N'Оскар',   N'Брониславович',   N'Терапевт',    150,    44),
    (N'Сергеев',    N'Остап',   N'Романович',       N'Хирург',      800,    20),
    (N'Кулишенко',  N'Жигер',   N'Валериевич',      N'Терапевт',    100,    15);
    
-- удаление записей в таблице
delete 
    [Doctors];

-- удаление таблицы ВРАЧИ
drop table 
    [Doctors];


-- код для создания тестовой таблицы 
CREATE TABLE [dbo].[TestDoctors] (
    [Id]				INT            PRIMARY KEY IDENTITY (1, 1) NOT NULL,
    [LastNameDoctor]	NVARCHAR (40)  NOT NULL,
    [FirstNameDoctor]	NVARCHAR (40)  NOT NULL,
    [PatronymicDoctor]	NVARCHAR (40)  NOT NULL,
    [Speciality]		NVARCHAR (100) NOT NULL,
    [Price]				INT            NOT NULL,
	[PercentSalary]		FLOAT		   NOT NULL,
    CONSTRAINT [CK_TestDoctors_Price]			CHECK ([Price] >= 0),
    CONSTRAINT [CK_TestDoctors_PercentSalary]	CHECK ([PercentSalary] >= 0.)
);

-- код для удаления тестовой таблицы
drop table 
    [TestDoctors];