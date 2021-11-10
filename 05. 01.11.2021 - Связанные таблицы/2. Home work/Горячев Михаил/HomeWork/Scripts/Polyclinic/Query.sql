-- 1	Запрос с параметром	Выбирает из таблицы ПАЦИЕНТЫ информацию о 
-- пациентах, фамилия которых начинается с заданной буквы (например, «И»)
declare @selectLetter nvarchar(2) = N'И%';

select 
	*
from
	Patients
where
	Patients.[LastNamePatient] like @selectLetter;
go

-- 2	Запрос на выборку	Выбирает из таблицы ВРАЧИ информацию о врачах,
-- имеющих заданную специальность. Например, «хирург»
-- Хирург
-- Окулист
-- Терапевт
declare @selectSpeciality nvarchar(20) = N'Хирург';

select 
	*
from
	Doctors
where 
	Doctors.Speciality = @selectSpeciality;
go

-- 3	Запрос на выборку	Выбирает из таблиц ВРАЧИ, ПАЦИЕНТЫ и ПРИЕМЫ 
-- информацию о приемах: фамилия и инициалы пациента, дата приема, дата 
-- рождения пациента, специальность врача, стоимость прима
select
	Receptions.[Id]
	, Patients.[LastNamePatient] + ' ' + SUBSTRING(Patients.[FirstNamePatient], 1, 1) + '. ' + SUBSTRING(Patients.[PatronymicPatient], 1, 1) + '.' as Patient
	, Patients.[DateBirthPatient]
	, Doctors.[Speciality]
	, Receptions.[Date] as DateReception
	, Doctors.[Price]
from
	Receptions inner join Patients on Receptions.[IdPatient] = Patients.[Id]
			   inner join Doctors on Receptions.[IdDoctor] = Doctors.[Id];

-- 4	Запрос с параметром	Выбирает из таблицы ВРАЧИ информацию о врачах 
-- с заданным значением в поле Стоимость приема. Конкретное значение стоимости 
-- приема вводится при выполнении запроса
declare @price int = 1000;

select 
	*
from
	Doctors
where 
	Doctors.[Price] = @price;

-- 5	Запрос с параметром	Выбирает из таблицы ВРАЧИ информацию о врачах, 
-- Процент отчисления на зарплату которых находится в некотором заданном 
-- диапазоне. Нижняя и верхняя границы диапазона задаются при выполнении 
-- запроса
declare @lo int = 500, @hi int = 1500;

select
	*
from 
	Doctors
where
	Doctors.[Price] between @lo and @hi;

-- 6	Запрос с вычисляемыми полями	Вычисляет размер заработной платы 
-- врача за каждый прием. Включает поля Фамилия врача, Имя врача, Отчество 
-- врача, Специальность врача, Стоимость приема, Зарплата. Сортировка по полю 
-- Фамилия врача 
select
	Receptions.[Id]
	, Doctors.[LastNameDoctor]
	, Doctors.[FirstNameDoctor]
	, Doctors.[PatronymicDoctor]
	, Doctors.[Speciality]
	, Doctors.[Price]
	, Doctors.[PercentSalary]
	, Doctors.[Price] * (Doctors.[PercentSalary] / 100) * 0.87 as Salary
from
	Receptions inner join Doctors on Receptions.[IdDoctor] = Doctors.[Id]
order by
	Doctors.[LastNameDoctor];

-- 7	Итоговый запрос	Выполняет группировку по полю Дата приема. Для каждой
-- даты вычисляет минимальную стоимость приема
select
	Receptions.[Date]
	, COUNT(*) as [Count]
	, MIN(Doctors.[Price]) as [MinPrice]
	, AVG(Doctors.[Price]) as [AvgPrice]
	, MAX(Doctors.[Price]) as [MaxPrice]
from
	Receptions inner join Doctors on Receptions.[IdDoctor] = Doctors.[Id]
group by
	Receptions.[Date];

-- 8	Итоговый запрос	Выполняет группировку по полю Специальность. Для каждой 
-- специальности вычисляет максимальный Процент отчисления на зарплату от 
-- стоимости приема
select
	Doctors.Speciality
	, COUNT(*) as [Count]
	, MIN(Doctors.[PercentSalary]) as [MinPercent]
	, AVG(Doctors.[PercentSalary]) as [MinPercent]
	, MAX(Doctors.[PercentSalary]) as [MinPercent]
from
	Receptions inner join Doctors on Receptions.[IdDoctor] = Doctors.[Id]
group by 
	Doctors.Speciality;