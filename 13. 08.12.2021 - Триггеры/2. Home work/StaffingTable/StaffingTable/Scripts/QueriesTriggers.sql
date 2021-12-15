-- •	Разработайте триггеры для операций вставки, удаления записей и 
--		изменения записей для таблицы РАСПРЕДЕЛЕНИЕ_ШТАТНЫХ_ЕДИНИЦ базы данных.
--		Для таблицы ШТАТНЫЕ_ЕДИНИЦЫ разработайте триггеры для операций вставки и 
--		изменения записей. Триггеры должны сообщать о количестве измененных в 
--		процессе работы операций строк таблицы. Триггер изменения таблицы 
--		ШТАТНЫЕ_ЕДИНИЦЫ должен предотвратить изменение должности «инженер-электрик».
--		Продемонстрировать работу триггеров при помощи тестирующих скриптов

-- Разработайте триггеры для операций вставки, удаления записей и 
-- изменения записей для таблицы РАСПРЕДЕЛЕНИЕ_ШТАТНЫХ_ЕДИНИЦ базы данных.
-- Триггеры должны сообщать о количестве измененных в процессе работы операций 
-- строк таблицы. Триггер изменения таблицы 

-- триггер для операции вставки

-- удаление триггера
drop trigger if exists onInsertDistributionUnits;
go

-- создание триггера 
create trigger onInsertDistributionUnits on DistributionUnits
	for insert
	as
	begin
		-- вывод сообщения
		raiserror(N'    onInsertDistributionUnits: Количество измененных строк в таблице DistributionUnits: %d', 0, 1, @@rowcount);
	end
go

-- демонстрация работы тригера
insert into DistributionUnits	-- заполнение таблицы DistributionUnits		(Распределение штатных единиц)
	(IdDevision, IdUnit, Amount)
values
	-- администрация	(22 человек)
	(1,		 1,		 1),		-- 1	(Директор)
	(1,		 3,		 1),		-- 2	(Начальник)
	(1,		 5,		 5),		-- 3	(Менеджер)
	(1,		 6,		10),		-- 4	(Менеджер)
	(1,		 9,		 3),		-- 5	(Инженер)
	(1,		10,		 2);		-- 6	(Инженер)
go


-- триггер для операции обновления

-- удаление триггера
drop trigger if exists onUpdateDistributionUnits;
go

-- создание триггера 
create trigger onUpdateDistributionUnits on DistributionUnits
	for update
	as
	begin
		-- вывод сообщения
		raiserror(N'    onUpdateDistributionUnits: Количество измененных строк в таблице DistributionUnits: %d', 0, 1, @@rowcount);
	end
go

-- демонстрация работы триггера
update
	DistributionUnits
set
	Amount += 15;
go


-- триггер для операции удаления 

-- удаление триггера
drop trigger if exists onDeleteDistributionUnits;
go

-- создание триггера
create trigger onDeleteDistributionUnits on DistributionUnits 
	for delete
	as
	begin
		-- вывод сообщения
		raiserror(N'    onDeleteDistributionUnits: Количество измененных строк в таблице DistributionUnits: %d', 0, 1, @@rowcount);
	end;
go

-- демонстрация работы тригера
delete from DistributionUnits;
go


-- Триггер изменения таблицы ШТАТНЫЕ_ЕДИНИЦЫ должен предотвратить
-- изменение должности «инженер-электрик».

-- удаление триггера
drop trigger if exists onUpdateUnits;
go

-- создание триггера 
create trigger onUpdateUnits on Units
	for update
	as
	begin
		-- флаг вхождения записей с типом "Инженер-электрик"
		declare @flag bit = 0;

		-- тип записи 
		declare @unitType nvarchar(60) = N'Инженер-электрик';

		-- если среди обновляемых записей, есть записи с типом "Инженер-электрик"
		select @flag = 1 from deleted where deleted.IdUnitType in (select UnitTypes.Id from UnitTypes where UnitTypes.Title = @unitType);
		
		if @flag = 1 begin
			-- вывод сообщения
			raiserror (N'    onUpdateUnits: Нельзя изменять запись "Инженер-электрик"!', 0, 1);

			-- отмена транзакции
			rollback tran;
		end;
			

	end;
go

-- демонстрация работы триггера

-- тип записи 
declare @unitType nvarchar(60) = N'Инженер-электрик';

update 
	Units
set
	Salary += 10000
where
	IdUnitType in (select UnitTypes.Id from UnitTypes where UnitTypes.Title = @unitType);
	-- IdUnitType in (select UnitTypes.Id from UnitTypes where UnitTypes.Title != @unitType);	-- демонстрация, что изменение других записей работает
go
