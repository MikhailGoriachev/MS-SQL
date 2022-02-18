-- •	Создайте и протестируйте триггеры на добавление, изменение и удаление для таблицы ПРИЕМ 
--		o	Запрет удаления приемов за последние 3 года
--		o	Запрет изменения записей за дату, отличную от текущей (запрет редактирования «задним числом»)
--		o	Запрет повторной записи пациента на прием к тому же доктору в один и тот же день

-- Запрет удаления приемов за последние 3 года

-- удаление триггера
drop trigger if exists onDeleteAppointments;
go

-- создание триггера
create trigger onDeleteAppointments on Appointments 
	for delete
as
	begin
		-- флаг вхождения приёмов за последние 3 года
		declare @flag bit = 0;

		-- выборка приёмов за последние 3 года
		select
			@flag = 1
		from
			deleted
		where
			DateDiff(year, AppointmentDate, GetDate()) <= 3;
			
		-- если найдены записи за последние 3 года
		if @flag = 1
			rollback tran;
	end;
go

-- проверка удаления
delete from 
	Appointments
where
	DateDiff(year, AppointmentDate, GetDate()) <= 3;
	-- DateDiff(year, AppointmentDate, GetDate()) > 3;


-- Запрет изменения записей за дату, отличную от текущей (запрет редактирования «задним числом»)

-- удаление триггера
drop trigger if exists onUpdateAppointments;
go

-- создание триггера
create trigger onUpdateAppointments on Appointments
	for update
as
	begin
		-- флаг вхождения записей не сегодняшей даты
		declare @flag bit = 0;

		-- выборка записей не сегодняшней даты
		select
			@flag = 1
		from
			deleted
		where
			DateDiff(day, AppointmentDate, GetDate()) != 0;

		-- если найдены записи не сегодняшней даты
		if @flag = 1
			rollback tran;
	end;
go

-- проверка работы триггера
update 
	Appointments
set
	IdPatient = (select ViewPatients.Id from ViewPatients where ViewPatients.Passport = N'ВО12312')
where
	DateDiff(day, AppointmentDate, GetDate()) = 0;
go


-- Запрет повторной записи пациента на прием к тому же доктору в один и тот же день

-- удаление триггера
drop trigger if exists onInsertAppointments;
go

-- создание триггера
create trigger onInsertAppointments on Appointments
	for insert
as
	begin
		-- флаг вхождения пациентов, которые уже записаны к конкретному доктороу на ту же дату
		declare @flag bit = 0;

		-- выборка пацинтов по условию
		select 
			@flag = 1
		from
			inserted
		where
			(select Count(*) from Appointments where DateDiff(day, inserted.AppointmentDate, Appointments.AppointmentDate) = 0
														and inserted.IdDoctor  = Appointments.IdDoctor
														and inserted.IdPatient = Appointments.IdPatient) > 1

		-- если найдены записи по условию
		if @flag = 1
			rollback tran;
	end;
go

-- проверка работы триггера
insert into Appointments
	(AppointmentDate, IdPatient, IdDoctor)
values
    ('10-21-21',  1,  1);
    -- ('10-21-01',  2,  2);   
