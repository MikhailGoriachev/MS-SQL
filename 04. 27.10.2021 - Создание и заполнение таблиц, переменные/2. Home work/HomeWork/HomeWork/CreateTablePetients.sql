-- создание таблицы ПАЦИЕНТЫ
CREATE TABLE [dbo].[Patients] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [LastNamePatient]   NVARCHAR (40)  NOT NULL,
    [FirstNamePatient]  NVARCHAR (40)  NOT NULL,
    [PatronymicPatient] NVARCHAR (40)  NOT NULL,
    [DateBirthPatient]  DATE           NOT NULL,
    [Address]           NVARCHAR (120) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

-- заполнение таблицы ПАЦИЕНТЫ данными
insert into [Patients]
    ([LastNamePatient], [FirstNamePatient], [PatronymicPatient], [DateBirthPatient], [Address])
values
    (N'Орлов',      N'Марат',       N'Романович',       '1970-01-12', N'Петровского, 256/4'),
    (N'Яровой',     N'Александр',   N'Александрович',   '1980-01-01', N'Петровского, 240/52'),
    (N'Петровский', N'Илларион',    N'Львович',         '1980-01-01', N'Артёма, 40'),
    (N'Щукин',      N'Клаус',       N'Леонидович',      '1983-12-09', N'Горького, 38/18'),
    (N'Воробьёв',   N'Савва',       N'Михайлович',      '1986-10-02', N'Петровского, 4'),
    (N'Алчевский',  N'Жигер',       N'Андреевич',       '1995-08-18', N'Артёма, 68'),
    (N'Яковенко',   N'Добрыня',     N'Романович',       '1956-03-15', N'Петровского, 184/12'),
    (N'Щербаков',   N'Юлий',        N'Леонидович',      '1986-10-02', N'Горького, 18'),
    (N'Самойлов',   N'Ярослав',     N'Петрович',        '1997-03-15', N'Артёма, 13/28'),
    (N'Романов',    N'Чарльз',      N'Сергеевич',       '1956-10-02', N'Горького, 23/7'),
    (N'Бородай',    N'Спартак',     N'Анатолиевич',     '1986-10-02', N'Садовая, 19/78'),
    (N'Туров',      N'Болеслав',    N'Вадимович',       '1986-10-02', N'Содовая, 5'),
    (N'Капустин',   N'Павел',       N'Викторович',      '1986-10-02', N'Садовая, 7');

-- удаление записей в таблице ПАЦИЕНТЫ
delete 
    [Patients];

-- удаление таблицы ПАЦИЕНТЫ
drop table 
    [Patients];

-- удаление таблицы ПАЦИЕНТЫ
drop table 
    [Patients];
    

-- код для создания тестовой таблицы 
CREATE TABLE [dbo].[TestPatients] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [LastNamePatient]   NVARCHAR (40)  NOT NULL,
    [FirstNamePatient]  NVARCHAR (40)  NOT NULL,
    [PatronymicPatient] NVARCHAR (40)  NOT NULL,
    [DateBirthPatient]  DATE           NOT NULL,
    [Address]           NVARCHAR (120) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

-- код для удаления тестовой таблицы
drop table 
    [TestPatients];