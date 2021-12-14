drop view if exists ViewStaffingTable;		-- удаление представления таблицы StaffingTable			(Штатное расписание)	 
drop view if exists ViewDistributionUnits;	-- удаление представления таблицы DistributionUnits		(Распределение штатных единиц)	 
drop view if exists ViewDevisions;			-- удаление представления таблицы Devisions				(Подразделения)	 
drop view if exists ViewUnits;				-- удаление представления таблицы Units					(Штатные елиницы)	 
go

-- создание представления таблицы Units					(Штатные елиницы)	 
create view ViewUnits
as
	select
		Units.Id
		, UnitTypes.Title	as	UnitType				-- Тип штатной единицы
		, Units.Salary									-- Оклад
		, WorkLevels.Title	as WorkLevel				-- Рабочий разряд
		, Units.InterestAllowancetTwo					-- Процент надбавки 2
		, Units.LeaveDays								-- Количество дней отпуска
	from
		Units inner join UnitTypes	on Units.IdUnitType	 = UnitTypes.Id
			  inner join WorkLevels on Units.IdWorkLevel = WorkLevels.Id; 
go


-- создание представления таблицы Devisions				(Подразделения)	 
create view ViewDevisions
as
	select
		Devisions.Id						
		, DevisionTypes.Title	as DevisionType			-- Тип подразделения
		, Devisions.Title		as DevisionTitle		-- Название подразделения
		, Devisions.InterestAllowancetOne				-- Процент надбавки 1
	from
		Devisions inner join DevisionTypes on Devisions.IdDevisionType = DevisionTypes.Id;
go


-- создание представления таблицы DistributionUnits		(Распределение штатных единиц)	 
create view ViewDistributionUnits 
as
	select
		DistributionUnits.Id			
		, ViewDevisions.DevisionType				-- Тип подразделения
		, ViewDevisions.DevisionTitle				-- Название подразделения
		, ViewDevisions.InterestAllowancetOne		-- Процент надбавки 1
		, ViewUnits.UnitType						-- Тип штатной единицы
		, ViewUnits.Salary							-- Оклад
		, ViewUnits.WorkLevel						-- Рабочий разряд
		, ViewUnits.InterestAllowancetTwo			-- Процент надбавки 2
		, ViewUnits.LeaveDays						-- Количество дней отпуска
		, DistributionUnits.Amount					-- Количество единиц
	from
		DistributionUnits inner join ViewDevisions	on DistributionUnits.IdDevision	= ViewDevisions.Id
						  inner join ViewUnits		on DistributionUnits.IdUnit		= ViewUnits.Id
go


-- создание представления таблицы StaffingTable			(Штатное расписание)	 
create view ViewStaffingTable
as
	select
		StaffingTable.Id	
		, ViewDevisions.DevisionType				-- Тип подразделения
		, ViewDevisions.DevisionTitle				-- Название подразделения
		, ViewDevisions.InterestAllowancetOne		-- Процент надбавки 1
		, Persons.LastName							-- Фамилия
		, Persons.FirstName							-- Имя
		, Persons.Patronymic						-- Отчество
		, ViewUnits.UnitType						-- Тип штатной единицы
		, ViewUnits.Salary							-- Оклад
		, ViewUnits.WorkLevel						-- Рабочий разряд
		, ViewUnits.InterestAllowancetTwo			-- Процент надбавки 2
		, ViewUnits.LeaveDays						-- Количество дней отпуска
	from
		StaffingTable inner join ViewDevisions	on	StaffingTable.IdDevision = ViewDevisions.Id
					  inner join Persons		on	StaffingTable.IdPerson	 = Persons.Id
					  inner join ViewUnits		on	StaffingTable.IdUnit	 = ViewUnits.Id	
go