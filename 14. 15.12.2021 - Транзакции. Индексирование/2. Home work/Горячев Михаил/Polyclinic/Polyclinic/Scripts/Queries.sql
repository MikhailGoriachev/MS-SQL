-- запросы к таблицам базы данных Polyclinic

-- таблица Specialities
select 
    *
from
    Specialities;

-- таблица Persons
select
    *
from
    Persons;

-- таблица Patients
select
    *
from   
    ViewPatients;

-- таблица Doctors
select
    *
from
    ViewDoctors;


-- таблица Appointments
select
    *
from
    ViewAppointments;

-- ------------------------------------------------------------------------

-- запросы к таблицам базы данных Polyclinic по заданию

 
-- 1	Хранимая процедура. Запрос на выборку	
--      Выбирает информацию о пациентах с заданной фамилией 	

-- запрос 1
declare @surname nvarchar(60) = N'Трубихин';
exec Proc1 @surname;
go

-- запрос 2
declare @surname nvarchar(60) = N'Чмыхало';
exec Proc1 @surname;
go

-- запрос 3
declare @surname nvarchar(60) = N'Князьков';
exec Proc1 @surname;
go


-- 2	Хранимая процедура. Запрос на выборку	
--      Выбирает информацию о врачах, для которых значение в поле 	
--      Процент отчисления на зарплату больше заданного (например, > 30%)	 

-- запрос 1
declare @percent float = 5;
exec Proc2 @percent;
go

-- запрос 2
declare @percent float = 2;
exec Proc2 @percent;
go

-- запрос 3
declare @percent float = 1;
exec Proc2 @percent;
go


-- 3	Хранимая процедура. Запрос на выборку	
--      Выбирает информацию о приемах пациентов в заданный период

-- запрос 1
declare @dateBegin date = N'2021/10/01', @dateEnd date = N'2021/10/25';
exec Proc3 @dateBegin, @dateEnd;
go

-- запрос 2
declare @dateBegin date = N'2021/11/01', @dateEnd date = N'2021/11/25';
exec Proc3 @dateBegin, @dateEnd;
go

-- запрос 3
declare @dateBegin date = N'2021/12/01', @dateEnd date = N'2021/12/25';
exec Proc3 @dateBegin, @dateEnd;
go


-- 4	Хранимая процедура. Запрос на выборку	
--      Выбирает информацию о врачах заданной специальности. 

-- запрос 1
declare @speciality nvarchar(40) = N'терапевт';
exec Proc4 @speciality;
go

-- запрос 2
declare @speciality nvarchar(40) = N'стоматолог';
exec Proc4 @speciality;
go

-- запрос 3
declare @speciality nvarchar(40) = N'окулист';
exec Proc4 @speciality;
go


-- 5	Хранимая процедура. Запрос на выборку	
--      Выбирает информацию обо всех приемах (ФИО пациента, ФИО и специальность 	
--      врача, дата приема) в некоторый заданный интервал времени. Нижняя и 	
--      верхняя границы интервала задаются при выполнении запроса	

-- запрос 1
declare @dateBegin date = N'2021/10/01', @dateEnd date = N'2021/10/25';
exec Proc5 @dateBegin, @dateEnd;
go

-- запрос 2
declare @dateBegin date = N'2021/11/01', @dateEnd date = N'2021/11/25';
exec Proc5 @dateBegin, @dateEnd;
go

-- запрос 3
declare @dateBegin date = N'2021/12/01', @dateEnd date = N'2021/12/25';
exec Proc5 @dateBegin, @dateEnd;
go


-- 6	Хранимая процедура. Запрос на выборку	
--      Вычисляет размер заработной платы врача за каждый прием. Включает поля 	
--      Фамилия врача, Имя врача, Отчество врача, Специальность врача, Стоимость 	
--      приема, Зарплата. Сортировка по полю Специальность врача	   
 	 	 	   
-- запрос 
exec Proc6;


-- 7	Хранимая процедура. Итоговый запрос. 	
--      Выполняет группировку по полю Дата приема. Для каждой даты вычисляет	
--      максимальную стоимость приема	   

-- запрос
exec Proc7;


-- 8	Хранимая процедура. Итоговый запрос.	
--      Выполняет группировку по полю Специальность. Для каждой специальности 	
--      вычисляет средний Процент отчисления на зарплату от стоимости приема	   

-- запрос 
exec Proc8;


-- 9	Хранимая процедура. Запрос на создание базовой таблицы	
--      Создает таблицу ВРАЧИ_ДАТА, содержащую информацию о врачах, осуществлявших 	
--      прием пациентов в день с заданной датой	   

-- запрос 1
declare @date date = '12-22-21'; 
exec Proc9 @date;
exec ProcShowDoctors_Date;
go

-- запрос 2
declare @date date = '10-28-21'; 
exec Proc9 @date;
exec ProcShowDoctors_Date;
go

-- запрос 3
declare @date date = '11-02-17'; 
exec Proc9 @date;
exec ProcShowDoctors_Date;
go


-- 10	Хранимая процедура. Запрос на создание базовой таблицы	
--      Создает копию таблицы ПАЦИЕНТЫ с именем КОПИЯ_ПАЦИЕНТЫ	   

-- запрос 
exec Proc10;
exec ProcShowCopy_Patients;
go

-- 11	Хранимая процедура. Запрос на удаление	
--      Удаляет из таблицы КОПИЯ_ПАЦИЕНТЫ записи о пациентах, родившихся после 	
--      заданной даты	   

-- запрос на выборку содержимого таблицы КОПИЯ_ПАЦИЕНТЫ
select * from Copy_Patients;

-- запрос 1
declare @date date = '2001/01/01';
exec Proc11 @date;
exec ProcShowCopy_Patients;
go

-- запрос 2
declare @date date = '1980/01/01';
exec Proc11 @date;
exec ProcShowCopy_Patients;
go

-- запрос 3
declare @date date = '1960/01/01';
exec Proc11 @date;
exec ProcShowCopy_Patients;
go


-- 12	Хранимая процедура. Запрос на обновление		
--      Увеличивает значение в поле Процент отчисления на зарплату в таблице 	
--      КОПИЯ_ВРАЧИ на заданное значение процентов для врачей, имеющих заданную 	
--      врачебную специальность	 

-- создание таблицы КОПИЯ_ВРАЧИ
exec ProcCreateCopyDoctors;

-- вывод таблицы КОПИЯ_ВРАЧИ
exec ProcShowCopy_Doctors;

-- запрос 1
declare @percent float = 10, @speciality nvarchar(40) = N'терапевт';
exec ProcShowCopy_DoctorsSelectSpeciality @speciality;
exec Proc12 @percent, @speciality;
exec ProcShowCopy_DoctorsSelectSpeciality @speciality;
go

-- запрос 2
declare @percent float = 10, @speciality nvarchar(40) = N'стоматолог';
exec ProcShowCopy_DoctorsSelectSpeciality @speciality;
exec Proc12 @percent, @speciality;
exec ProcShowCopy_DoctorsSelectSpeciality @speciality;
go

-- запрос 3
declare @percent float = 10, @speciality nvarchar(40) = N'окулист';
exec ProcShowCopy_DoctorsSelectSpeciality @speciality;
exec Proc12 @percent, @speciality;
exec ProcShowCopy_DoctorsSelectSpeciality @speciality;
go
