-- создание уникального индекса для предотвращения дублирования данных в таблице
-- пациентов, без использования ограничения уникальности для номера и серии паспорта

-- удаление индекса 
drop index if exists Patients.IndexUniquePassportPatients;

-- создание индекса
create unique index IndexUniquePassportPatients on Patients(Passport); 
go

-- проверка работы индекса
insert into Patients
    (IdPerson, BornDate, [Address], Passport)
values
    (13, '02-12-2001', N'ул. Садовая, д. 123, кв. 12', N'ЕС45718');
go


-- создание индексов для представлений

-- создание индекса представления таблицы Doctors			(ВРАЧИ)

-- удаление индекса 
drop index if exists ViewDoctors.IndexViewDoctors;
go

-- создание индекса
create unique clustered index IndexViewDoctors on ViewDoctors(Id);
go


-- создание индекса представления таблицы Patients			(ПАЦИЕНТЫ)

-- удаление индекса 
drop index if exists ViewPatients.IndexViewPatients;
go

-- создание индекса
create unique clustered index IndexViewPatients on ViewPatients(Id);
go


-- создание индекса представления таблицы Appointments		(ПРИЕМЫ)

-- !!! не работает, так как в представлении идёт обращение к таблице Persons дважды !!!

-- -- удаление индекса 
-- drop index if exists ViewAppointments.IndexViewAppointments;
-- go
-- 
-- -- создание индекса
-- create unique clustered index IndexViewAppointments on ViewAppointments(Id);
-- go