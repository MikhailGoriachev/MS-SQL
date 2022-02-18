-- 1	Хранимая процедура. Запрос на выборку	
--      Выбирает информацию о пациентах с заданной фамилией 	

-- удаление процедуры 
drop proc if exists Proc1;
go

-- создание процедуры
create proc Proc1 
	@surname nvarchar(60)			-- фаилия пациента
as
	begin
		select
			*
		from
			ViewPatients
		where
			ViewPatients.PatientSurname like @surname;
	end;
go


-- 2	Хранимая процедура. Запрос на выборку	
--      Выбирает информацию о врачах, для которых значение в поле 	
--      Процент отчисления на зарплату больше заданного (например, > 30%)	 

-- удаление процедуры 
drop proc if exists Proc2;
go

-- создание процедуры
create proc Proc2
	@percent float		-- процент отчисления на зарплату врача
as
	begin
		select
			*
		from
			ViewDoctors
		where
			ViewDoctors.[Percent] > @percent;
	end;
go


-- 3	Хранимая процедура. Запрос на выборку	
--      Выбирает информацию о приемах пациентов в заданный период

-- удаление процедуры 
drop proc if exists Proc3;
go

-- создание процедуры
create proc Proc3
	@dateBegin date,		-- минимальная дата периода
	@dateEnd date			-- максимальная дата периода
as
	begin
		select
			*
		from
			ViewAppointments
		where
			ViewAppointments.AppointmentDate between @dateBegin and @dateEnd;
	end;
go


-- 4	Хранимая процедура. Запрос на выборку	
--      Выбирает информацию о врачах заданной специальности. 

-- удаление процедуры 
drop proc if exists Proc4;
go

-- создание процедуры
create proc Proc4
	@speciality nvarchar(40)
as
	begin
		select
			*
		from
			ViewDoctors
		where
			ViewDoctors.Speciality like @speciality;		
	end;
go


-- 5	Хранимая процедура. Запрос на выборку	
--      Выбирает информацию обо всех приемах (ФИО пациента, ФИО и специальность 	
--      врача, дата приема) в некоторый заданный интервал времени. Нижняя и 	
--      верхняя границы интервала задаются при выполнении запроса	

-- удаление процедуры 
drop proc if exists Proc5;
go

-- создание процедуры
create proc Proc5
	@dateBegin date,		-- минимальная дата периода
	@dateEnd date			-- максимальная дата периода
as
	begin
		select
			PatientSurname + ' ' + PatientName + ' ' + PatientPatronymic as Patient
			, DoctorSurname + ' ' + DoctorName + ' ' + DoctorPatronymic as Doctor
			, AppointmentDate
		from
			ViewAppointments
		where
			AppointmentDate between @dateBegin and @dateEnd;
	end;
go

-- 6	Хранимая процедура. Запрос на выборку	
--      Вычисляет размер заработной платы врача за каждый прием. Включает поля 	
--      Фамилия врача, Имя врача, Отчество врача, Специальность врача, Стоимость 	
--      приема, Зарплата. Сортировка по полю Специальность врача	   
 	 	 	   
-- удаление процедуры 
drop proc if exists Proc6;
go

-- создание процедуры
create proc Proc6
as
	begin
		select
			ViewAppointments.DoctorSurname
			, ViewAppointments.DoctorName
			, ViewAppointments.DoctorPatronymic
			, ViewAppointments.Speciality
			, ViewAppointments.Price
			, ViewAppointments.[Percent]
			, (ViewAppointments.Price * (ViewAppointments.[Percent] / 100)) as SalaryAppointment
		from
			ViewAppointments
		order by
			ViewAppointments.Speciality;
	end;
go


-- 7	Хранимая процедура. Итоговый запрос. 	
--      Выполняет группировку по полю Дата приема. Для каждой даты вычисляет	
--      максимальную стоимость приема	   

-- удаление процедуры 
drop proc if exists Proc7;
go

-- создание процедуры
create proc Proc7
as
	begin
		select
			ViewAppointments.AppointmentDate
			, Count(*)						as Amount
			, Min(ViewAppointments.Price)	as MinPrice
			, Avg(ViewAppointments.Price)	as AvgPrice
			, Max(ViewAppointments.Price)	as MaxPrice
		from
			ViewAppointments
		group by
			ViewAppointments.AppointmentDate;
	end;
go


-- 8	Хранимая процедура. Итоговый запрос.	
--      Выполняет группировку по полю Специальность. Для каждой специальности 	
--      вычисляет средний Процент отчисления на зарплату от стоимости приема	   
			   
-- удаление процедуры 
drop proc if exists Proc8;
go

-- создание процедуры
create proc Proc8
as
	begin
		select
			ViewAppointments.Speciality
			, Count(*)						as Amount
			, Min(ViewAppointments.[Percent])	as MinPercent
			, Avg(ViewAppointments.[Percent])	as AvgPercent
			, Max(ViewAppointments.[Percent])	as MaxPercent
		from
			ViewAppointments
		group by
			ViewAppointments.Speciality;
	end;
go


-- 9	Хранимая процедура. Запрос на создание базовой таблицы	
--      Создает таблицу ВРАЧИ_ДАТА, содержащую информацию о врачах, осуществлявших 	
--      прием пациентов в день с заданной датой	   

-- удаление процедуры 
drop proc if exists Proc9;
go

-- создание процедуры
create proc Proc9
	@date date		-- дата приёма
as
	begin
		
		drop table if exists Doctors_Date;
			
		select
			*
			into Doctors_Date
		from
			Doctors
		where
			Doctors.Id in (select Appointments.IdDoctor from Appointments where Appointments.AppointmentDate = @date);
	end;
go


-- 10	Хранимая процедура. Запрос на создание базовой таблицы	
--      Создает копию таблицы ПАЦИЕНТЫ с именем КОПИЯ_ПАЦИЕНТЫ	   

-- удаление процедуры 
drop proc if exists Proc10;
go

-- создание процедуры
create proc Proc10
as
	begin
		
		drop table if exists Copy_Patients;
			
		select
			*
			into Copy_Patients
		from
			Patients;
	end;
go


-- 11	Хранимая процедура. Запрос на удаление	
--      Удаляет из таблицы КОПИЯ_ПАЦИЕНТЫ записи о пациентах, родившихся после 	
--      заданной даты	   

-- удаление процедуры 
drop proc if exists Proc11;
go

-- создание процедуры
create proc Proc11 
	@dateBirth date		-- дата рождения
as
	begin
		delete from
			Copy_Patients
		where
			Copy_Patients.BornDate > @dateBirth
	end;
go


-- процедура для создания таблицы КОПИЯ_ВРАЧИ

-- удаление процедуры
drop proc if exists ProcCreateCopyDoctors;
go

-- создание процедуры
create proc ProcCreateCopyDoctors
as
	begin
		
		drop table if exists Copy_Doctors;

		select
			*
			into Copy_Doctors
		from
			Doctors
	end;
go


-- 12	Хранимая процедура. Запрос на обновление		
--      Увеличивает значение в поле Процент отчисления на зарплату в таблице 	
--      КОПИЯ_ВРАЧИ на заданное значение процентов для врачей, имеющих заданную 	
--      врачебную специальность	 

-- удаление процедуры 
drop proc if exists Proc12;
go

-- создание процедуры
create proc Proc12
	@addPercent float,			-- процент для доабавления
	@speciality	nvarchar(40)	-- специальность врача
as
	begin
		update
			Copy_Doctors
		set
			[Percent] += @addPercent
		where
			Copy_Doctors.IdSpeciality in (select Specialities.Id from Specialities where Specialities.Speciality like @speciality);
	end;
go



-- процедура для вывода таблицы Copy_Patients

-- удаление процедуры
drop proc if exists ProcShowCopy_Patients;
go

-- создание процедуры
create proc ProcShowCopy_Patients
as
	begin 
		select
			Copy_Patients.Id
			, Persons.Surname				as PatientSurname				-- Фамилия пациента
			, Persons.[Name]				as PatientName					-- Имя пациента
			, Persons.Patronymic			as PatientPatronymic			-- Отчество пациента
			, Copy_Patients.BornDate										-- Дата рождения пациента
			, Copy_Patients.[Address]										-- Адрес проживания пациента
			, Copy_Patients.Passport										-- Паспортные данные
		from
			Copy_Patients inner join Persons on Copy_Patients.IdPerson = Persons.Id;
	end;
go


-- процедура для вывода таблицы Copy_Doctors

-- удаление процедуры
drop proc if exists ProcShowCopy_Doctors;
go

-- создание процедуры
create proc ProcShowCopy_Doctors
as
	begin
		select
			Copy_Doctors.Id
			, Persons.Surname					as DoctorSurname			-- Фамилия врача
			, Persons.[Name]					as DoctorName				-- Имя врача
			, Persons.Patronymic				as DoctorPatronymic			-- Отчество врача
			, Specialities.Speciality										-- Специальность
			, Copy_Doctors.Price													-- Цена приёма
			, Copy_Doctors.[Percent]												-- Процент от цены приёма врачу
		from
			Copy_Doctors inner join Persons		 on Copy_Doctors.IdPerson	  = Persons.Id
						 inner join Specialities on Copy_Doctors.IdSpeciality = Specialities.Id;
	end;
go


-- процедура для вывода таблицы Doctors_Date

-- удаление процедуры
drop proc if exists ProcShowDoctors_Date;
go

-- создание процедуры
create proc ProcShowDoctors_Date
as
	begin
		select
			Doctors_Date.Id
			, Persons.Surname					as DoctorSurname			-- Фамилия врача
			, Persons.[Name]					as DoctorName				-- Имя врача
			, Persons.Patronymic				as DoctorPatronymic			-- Отчество врача
			, Specialities.Speciality										-- Специальность
			, Doctors_Date.Price													-- Цена приёма
			, Doctors_Date.[Percent]												-- Процент от цены приёма врачу
		from
			Doctors_Date inner join Persons		 on Doctors_Date.IdPerson	  = Persons.Id
						 inner join Specialities on Doctors_Date.IdSpeciality = Specialities.Id;
	end;
go


-- процедура для вывода таблицы Doctors_Date для заданной сапециальности доктора

-- удаление процедуры
drop proc if exists ProcShowCopy_DoctorsSelectSpeciality;
go

-- создание процедуры
create proc ProcShowCopy_DoctorsSelectSpeciality
	@speciality nvarchar(40)			-- специальность врача
as
	begin
		select
			Copy_Doctors.Id
			, Persons.Surname					as DoctorSurname			-- Фамилия врача
			, Persons.[Name]					as DoctorName				-- Имя врача
			, Persons.Patronymic				as DoctorPatronymic			-- Отчество врача
			, Specialities.Speciality										-- Специальность
			, Copy_Doctors.Price													-- Цена приёма
			, Copy_Doctors.[Percent]												-- Процент от цены приёма врачу
		from
			Copy_Doctors inner join Persons		 on Copy_Doctors.IdPerson	  = Persons.Id
						 inner join Specialities on Copy_Doctors.IdSpeciality = Specialities.Id
		where
			Speciality like @speciality;
	end;
go

