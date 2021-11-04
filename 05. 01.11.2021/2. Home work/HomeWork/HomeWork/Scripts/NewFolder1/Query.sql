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
	, Patients.LastNamePatient + str(Patients.FirstNamePatient, 10) as FIO
	, Patients.FirstNamePatient
	, Patients.PatronymicPatient
from
	Receptions inner join Patients on Receptions.[IdPatient] = Patients.[Id]
			   inner join Doctors on Receptions.[IdDoctor] = Doctors.[Id];

-- 4	Запрос с параметром	Выбирает из таблицы ВРАЧИ информацию о врачах 
-- с заданным значением в поле Стоимость приема. Конкретное значение стоимости 
-- приема вводится при выполнении запроса

-- 5	Запрос с параметром	Выбирает из таблицы ВРАЧИ информацию о врачах, 
-- Процент отчисления на зарплату которых находится в некотором заданном 
-- диапазоне. Нижняя и верхняя границы диапазона задаются при выполнении 
-- запроса

-- 6	Запрос с вычисляемыми полями	Вычисляет размер заработной платы 
-- врача за каждый прием. Включает поля Фамилия врача, Имя врача, Отчество 
-- врача, Специальность врача, Стоимость приема, Зарплата. Сортировка по полю 
-- Фамилия врача 	 

-- 7	Итоговый запрос	Выполняет группировку по полю Дата приема. Для каждой
-- даты вычисляет минимальную стоимость приема

-- 8	Итоговый запрос	Выполняет группировку по полю Специальность. Для каждой 
-- специальности вычисляет максимальный Процент отчисления на зарплату от 
-- стоимости приема






-- 1	Запрос на выборку	
-- Выбирает из таблицы ВРАЧИ информацию о врачах, имеющих 
-- конкретную специальность (например, хирург)
declare @selectSpeciality nvarchar (100) 
set @selectSpeciality = N'Хирург';

select 
	*
from 
	[Doctors]
where
	[Doctors].Speciality = @selectSpeciality;
go

-- 2	Запрос на выборку	
-- Выбирает из таблицы ПАЦИЕНТЫ информацию о пациентах, 
-- родившихся до 01.01.1980 (дату можно выбрать другую)
declare @selectDate Date;
set @selectDate = '01-01-1980';

select 
	*
from 
	[Patients]
where
	[Patients].DateBirthPatient = @selectDate;
go

-- 3	Запрос на выборку	
-- Выбирает из таблицы ВРАЧИ информацию о врачах, имеющих
-- специальность «хирург», стоимость приема которых меньше 
-- 1200 рублей
declare @selectPrice int, @selectSpeciality nvarchar (100);
set @selectPrice = 1200;
set @selectSpeciality = N'Хирург';

select 
	*
from
	[Doctors]
where
	[Doctors].Speciality = @selectSpeciality and [Doctors].Price < @selectPrice;
go 

-- 4	Запрос с параметром	
-- Выбирает из таблицы ПАЦИЕНТЫ информацию о пациентах с 
-- заданной датой рождения. Дата рождения задается переменной 
-- при выполнении запроса
-- Существующие даты рождения пациентов:
-- '1970-01-12'
-- '1980-01-01'
-- '1979-03-04'
-- '1983-12-09'
-- '1989-09-13'
-- '1995-08-18'
-- '1997-03-15'
-- '1986-10-02'
-- '1975-02-23'
-- '1999-12-28'
declare @selectDate Date = '1989-09-13';

select 
	*
from
	[Patients]
where
	[Patients].DateBirthPatient = @selectDate;
go

-- 5	Запрос с параметром	
-- Выбирает из таблицы ПАЦИЕНТЫ информацию о пациентах, 
-- проживающих на улице, заданной переменной при выполнении 
-- запроса
-- Существующие улицы проживания пациентов
-- Петровского
-- Горького
-- Артёма

declare @selectStreet nvarchar(120) = N'Петровского[ ,.]%';

select
	*
from
	[Patients]
where
	[Patients].[Address] like @selectStreet;
go
	
-- 6	Запрос с параметром	
-- Выбирает из таблицы ВРАЧИ информацию о врачах, процент 
-- отчисления которых принадлежит диапазону, заданному переменными 
-- при выполнении запроса
declare @minPercent float = 5., @maxPercent float = 30.;

select 
	* 
from
	[Doctors]
where
	[Doctors].PercentSalary between @minPercent and @maxPercent;
go

-- 7	Итоговый запрос	
-- В таблице ПАЦИЕНТЫ выполняет группировку по полю Дата 
-- рождения. Для каждой даты группы вычисляет количество пациентов 
select
	[Patients].DateBirthPatient,
	Count(*) as [Count]
from
	[Patients]
group by 
	[Patients].DateBirthPatient;

-- 8	Итоговый запрос	
-- В таблице ВРАЧИ выполняет группировку по полю
-- Специальность. Для каждой специальности вычисляет количество 
-- докторов в группе, максимальный, минимальный и средний Процент 
-- отчисления 
select
	[Doctors].Speciality,
	Count(*) as [Count],
	Min([Doctors].PercentSalary) as MinPercent,
	Avg([Doctors].PercentSalary) as AvgPercent,
	Max([Doctors].PercentSalary) as MaxPercent
from
	[Doctors]
group by
	[Doctors].Speciality;

-- 9	Запрос на создание базовой таблицы	
-- Создает таблицу ВРАЧИ_ТЕРАПЕВТЫ, содержащую информацию 
-- о врачах-терапевтах, используйте select … into
declare @selectDoctor nvarchar(100) = N'Терапевт';

select 
	*
	into DoctorsTherapist
from
	[Doctors]
where
	[Doctors].Speciality = @selectDoctor;
go

-- удаление таблицы ВРАЧИ_ТЕРАПЕВТЫ
drop table [DoctorsTherapist];

-- 10	Запрос на создание базовой таблицы	
-- Создает копию таблицы ПАЦИЕНТЫ с именем КОПИЯ_ПАЦИЕНТЫ, 
-- используйте select … into
select
	*
	into PatientsCopy
from
	[Patients];

-- удаление таблицы КОПИЯ_ПАЦИЕНТЫ
drop table [PatientsCopy];
		
-- 11	Запрос на удаление	
-- Удаляет из таблицы ВРАЧИ_ТЕРАПЕВТЫ записи, в которых 
-- значение в поле Стоимость приема больше 200
declare @valuePrice int = 200;

delete
	[DoctorsTherapist]
where 
	[DoctorsTherapist].Price > @valuePrice;
go

-- 12	Запрос на удаление	
-- Удаляет из таблицы ПАЦИЕНТЫ записи о пациентах,
-- проживающих на улицах «Садовая» или «Содовая» или «Судовая» 
declare @valueStreet nvarchar (20) = N'С[аоу]довая[ ,.]%';

delete
	[Patients]
where 
	[Patients].[Address] like @valueStreet;
go

-- 13	Запрос на обновление	
-- Увеличивает значение в поле Стоимость приема таблицы 
-- ВРАЧИ на 10 процентов для врачей, имеющих специальность «хирург» 
-- и Процент отчисления у которых меньше 5% 
declare @valueSpeciality nvarchar (100) = N'Хирург', @valuePercent float = 5.;

update 
	[Doctors]
set
	[Price] *= 1.1
where
	[Doctors].Speciality = @valueSpeciality and [Doctors].PercentSalary < @valuePercent;
go

-- 14	Запрос на обновление	
-- Для записей таблицы ПАЦИЕНТЫ, у которых дата рождения 
-- между 01.01.1935 и 31.12.1959 к фамилии добавить строку «риск» 
-- (операция конкатенации строк: +, как в C#)
declare	@valueAppend nvarchar(10) = N' риск'
		, @minDate Date = '1935-01-01'
		, @maxDate Date = '1959-12-31';

update
	[Patients]
set
	[LastNamePatient] = [LastNamePatient] + @valueAppend
where
	[Patients].[DateBirthPatient] between @minDate and @maxDate;
go