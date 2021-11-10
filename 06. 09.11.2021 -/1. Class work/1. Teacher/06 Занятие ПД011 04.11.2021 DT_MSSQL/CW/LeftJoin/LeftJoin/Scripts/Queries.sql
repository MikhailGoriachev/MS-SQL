-- Левое соединение таблиц в запросе

-- Выполняет группировку по полю Специальность. Для каждой специальности 
-- вычисляет максимальный Процент отчисления на зарплату от стоимости приема
select
    Specialities.Speciality
    , COUNT(*)                as Amount
    , MIN(Doctors.[Percent])  as MinPercent
from
    Specialities left join Doctors on Doctors.IdSpeciality = Specialities.Id
group by
    Specialities.Speciality;
go

-- Выполняет группировку по полю Специальность. Для каждой специальности 
-- вычисляет максимальный Процент отчисления на зарплату от стоимости приема
select
    Specialities.Speciality
    , MAX(Doctors.[Percent])
from
    Specialities left join Doctors on Doctors.IdSpeciality = Specialities.Id
group by
    Specialities.Speciality;

-- Вывести всех пациентов и количестов приемов этих пациентов
-- (без расшифровки полей таблицы пациентов)
select
    Patients.Id
    , COUNT(Appointments.IdPatient) as AppointmentsAmount
from
    Patients left join Appointments on Appointments.IdPatient = Patients.Id
group by
    Patients.Id; 
go


-- Вывести всех пациентов и количестов приемов этих пациентов
-- (с расшифровкой полей таблицы пациентов)
select
    Patients.Id
    , Persons.Surname
    , Persons.[Name]
    , Persons.Patronymic
    , COUNT(Appointments.IdPatient) as AppointmentsAmount
from
    (Patients join Persons on Patients.IdPerson = Persons.Id) left join Appointments on Appointments.IdPatient = Patients.Id
group by
    Patients.Id, Persons.Surname, Persons.[Name], Persons.Patronymic; 


-- все пациенты и даты их приемов
select
    Patients.Id
    , Persons.Surname
    , Persons.[Name]
    , Persons.Patronymic
    , Appointments.AppointmentDate
    -- значение null заменим специальной датой
    , ISNULL(Appointments.AppointmentDate, '01-01-1900')
from
    (Patients join Persons on Patients.IdPerson = Persons.Id) left join Appointments on Appointments.IdPatient = Patients.Id
