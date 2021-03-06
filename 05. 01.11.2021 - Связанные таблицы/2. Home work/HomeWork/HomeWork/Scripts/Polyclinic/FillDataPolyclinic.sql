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
-- delete [Doctors];

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
-- delete [Patients];

-- заполнение таблицы ПРИЕМЫ данными
insert into [Receptions]
    ([IdDoctor], [IdPatient], [Date])
values
    (1,      1,     '2021/08/12'),
    (6,      2,     '2021/07/15'),
    (2,      3,     '2021/02/09'),
    (7,      4,     '2021/09/02'),
    (3,      5,     '2021/08/12'),
    (8,      6,     '2021/02/08'),
    (4,      7,     '2021/06/04'),
    (9,      8,     '2021/08/12'),
    (5,      9,     '2021/02/08'),
    (10,     10,    '2021/02/08')

-- удаление записей в таблице ПАЦИЕНТЫ
-- delete [Receptions];

-----------------------------------------------------------------------------------------------------------
-- удаление данных в таблицах

-- удаление записей в таблице ПАЦИЕНТЫ
-- delete [Receptions];

-- удаление записей в таблице ПАЦИЕНТЫ
-- delete [Patients];

-- удаление записей в таблице
-- delete [Doctors];