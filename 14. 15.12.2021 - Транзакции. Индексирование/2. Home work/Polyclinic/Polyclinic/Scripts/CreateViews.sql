-- удаление представлений
drop view if exists ViewAppointments;
drop view if exists ViewDoctors;
drop view if exists ViewPatients;
go

-- представление таблицы Doctors			(ВРАЧИ)

-- удаление представления 
-- drop view if exists ViewDoctors;
-- go

-- создание представления
create view ViewDoctors with schemabinding
as
	select
		Doctors.Id
		, Persons.Surname					as DoctorSurname			-- Фамилия врача
		, Persons.[Name]					as DoctorName				-- Имя врача
		, Persons.Patronymic				as DoctorPatronymic			-- Отчество врача
		, Specialities.Speciality										-- Специальность
		, Doctors.Price													-- Цена приёма
		, Doctors.[Percent]												-- Процент от цены приёма врачу
	from
		dbo.Doctors inner join dbo.Persons on dbo.Doctors.IdPerson = dbo.Persons.Id
					inner join dbo.Specialities on dbo.Doctors.IdSpeciality = dbo.Specialities.Id;
go


-- представление таблицы Patients			(ПАЦИЕНТЫ)

-- удаление представления 
-- drop view if exists ViewPatients;
-- go

-- создание представления
create view ViewPatients with schemabinding
as
	select
		Patients.Id
		, Persons.Surname				as PatientSurname				-- Фамилия пациента
		, Persons.[Name]				as PatientName					-- Имя пациента
		, Persons.Patronymic			as PatientPatronymic			-- Отчество пациента
		, Patients.BornDate												-- Дата рождения пациента
		, Patients.[Address]											-- Адрес проживания пациента
		, Patients.Passport												-- Паспортные данные
	from
		dbo.Patients inner join dbo.Persons on dbo.Patients.IdPerson = dbo.Persons.Id;
go

-- представление таблицы Appointments		(ПРИЕМЫ)

-- удаление представления 
-- drop view if exists ViewAppointments;
-- go

-- создание представления
create view ViewAppointments with schemabinding
as
	select
		Appointments.Id
		, Appointments.AppointmentDate									-- Дата приёма
		, Doc.Surname						as DoctorSurname			-- Фамилия врача
		, Doc.[Name]						as DoctorName				-- Имя врача
		, Doc.Patronymic					as DoctorPatronymic			-- Отчество врача
		, Specialities.Speciality										-- Специальность
		, Doctors.Price													-- Цена приёма
		, Doctors.[Percent]												-- Процент от цены приёма врачу
		, Pat.Surname						as PatientSurname			-- Фамилия пациента
		, Pat.[Name]						as PatientName				-- Имя пациента
		, Pat.Patronymic					as PatientPatronymic		-- Отчество пациента
		, Patients.BornDate												-- Дата рождения пациента
		, Patients.[Address]											-- Адрес проживания пациента
		, Patients.Passport												-- Паспортные данные
	from
		dbo.Appointments inner join (dbo.Doctors inner join dbo.Persons Doc on dbo.Doctors.IdPerson = Doc.Id
						 						 inner join dbo.Specialities on dbo.Doctors.IdSpeciality = dbo.Specialities.Id) 
						 			on  dbo.Appointments.IdDoctor = Doctors.Id
						 inner join (dbo.Patients inner join dbo.Persons Pat on dbo.Patients.IdPerson = Pat.Id) 
									on  dbo.Appointments.IdPatient = Patients.Id
go