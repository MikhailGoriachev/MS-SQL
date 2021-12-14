-- вывод данных таблицы DevisionTypes			(Типы подразделения)				
select
	*
from
	DevisionTypes;
go


-- вывод данных таблицы Persons					(Персоны)	 
select
	*
from
	Persons;
go


-- вывод данных таблицы UnitTypes				(Тип штатной единицы)				
select
	*
from
	UnitTypes;
go


-- вывод данных таблицы WorkLevels				(Рабочие разряды)
select
	*
from
	WorkLevels;
go


-- вывод данных таблицы Units					(Штатные елиницы)	 
select
	*
from
	ViewUnits;
go


-- вывод данных таблицы Devisions				(Подразделения)	 
select
	*
from
	ViewDevisions;
go


-- вывод данных таблицы DistributionUnits		(Распределение штатных единиц)	 
select
	*
from
	ViewDistributionUnits;
go


-- вывод данных таблицы StaffingTable			(Штатное расписание)	 
select
	*
from
	ViewStaffingTable;
go

-----------------------------------------------------------------------------------------

-- 1	Хранимая процедура
--		Выбирает из таблицы ПОДРАЗДЕЛЕНИЯ информацию о подразделениях, 
--		имеющих тип «отдел» или «цех», для которых Процент_надбавки_1 
--		больше значения, заданного параметром

-- удаление процедуры
drop proc if exists SelectionWhereInterestAllowancetOne;
go

-- создание процедуры
create proc SelectionWhereInterestAllowancetOne
	@interest int			-- процент надбавки 1 (за вредные условия труда)
as
	-- типы подразделений
	declare @type1 nvarchar(60) = N'Отдел', @type2 nvarchar(60) = N'Цех';

	-- запрос на выбор
	begin
		select
			*
		from
			ViewDevisions
		where
			DevisionType in (@type1, @type2) and InterestAllowancetOne > @interest;
	end;
go

-- набор параметров для демонстрации работы
declare @interest1 int = 5,			-- 1
		@interest2 int = 10,		-- 2
		@interest3 int = 25;		-- 3

-- демонстрация работы процедуры
exec SelectionWhereInterestAllowancetOne @interest1;		-- 1
exec SelectionWhereInterestAllowancetOne @interest2;		-- 2
exec SelectionWhereInterestAllowancetOne @interest3;		-- 3
go


-- 2	Хранимая процедура
--		Выбирает из таблицы ШТАТНЫЕ_ЕДИНИЦЫ информацию о штатных единицах 
--		с окладом в заданном диапазоне и значением в поле Процент_надбавки_2 
--		также равным заданному. Диапазон оклада и процент надбавки задавать 
--		параметрами

-- удаление процедуры 
drop proc if exists SelectionWhereLoHiSalaryAndInterestAllowancetTwo;
go

-- создание процедуры
create proc SelectionWhereLoHiSalaryAndInterestAllowancetTwo
	@loSalary int,		-- минимальное значение зарплаты
	@hiSalary int,		-- максимальное значение зарплаты
	@interest  int		-- процент надбавки 2 (за ненормированный рабочий день)
as
	begin
		-- запрос на выборку
		select
			*
		from
			ViewUnits
		where 
			Salary between @loSalary and @hiSalary and InterestAllowancetTwo = @interest
	end;
go

-- демонстрация работы процедуры

-- 1 набор параметров
declare @loSalary int = 80000, @hiSalary int = 100000, @interest int = 35;	
exec SelectionWhereLoHiSalaryAndInterestAllowancetTwo @loSalary, @hiSalary, @interest;
go

-- 2 набор параметров
declare @loSalary int = 50000, @hiSalary int = 70000, @interest int = 20;	
exec SelectionWhereLoHiSalaryAndInterestAllowancetTwo @loSalary, @hiSalary, @interest;
go

-- 3 набор параметров
declare @loSalary int = 30000, @hiSalary int = 50000, @interest int = 10;	
exec SelectionWhereLoHiSalaryAndInterestAllowancetTwo @loSalary, @hiSalary, @interest;
go


-- 3	Однотабличная функция	
--		Выбирает из таблицы ПОДРАЗДЕЛЕНИЯ информацию о подразделениях, для 
--		которых тип подразделения равен заданному параметром или Процент_надбавки_1 
--		равен заданному параметром 

-- удаление однотабличной функции
drop function SelectionWhereTypeDevisionOrInterestAllowancetOne;
go

-- создание однотабличной функции
create function SelectionWhereTypeDevisionOrInterestAllowancetOne (@devisionType nvarchar(60), @interest int)
	returns table
as
return
	-- запрос на выборку
	select
		*
	from
		ViewDevisions
	where 
		DevisionType = @devisionType or InterestAllowancetOne = @interest;
go

-- демонстрация работы однотабличной функции

-- 1 набор параметров
declare @devisionType nvarchar(60) = N'Цех',		@interest int = 46;
select * from dbo.SelectionWhereTypeDevisionOrInterestAllowancetOne(@devisionType, @interest);
go

-- 2 набор параметров
declare @devisionType nvarchar(60) = N'Бригада',	@interest int = 12;
select * from dbo.SelectionWhereTypeDevisionOrInterestAllowancetOne(@devisionType, @interest);
go

-- 3 набор параметров
declare @devisionType nvarchar(60) = N'Отдел',		@interest int = 15;
select * from dbo.SelectionWhereTypeDevisionOrInterestAllowancetOne(@devisionType, @interest);
go


-- 4	Хранимая процедура	
--		Выбирает из таблицы ШТАТНЫЕ_ЕДИНИЦЫ информацию о штатных единицах с 
--		заданным параметром наименованием и заданной параметром величиной оклада

-- удаление процедуры 
drop proc SelectionWhereTypeUnitAndSalary;
go

-- создание процедуры
create proc SelectionWhereTypeUnitAndSalary
	@typeUnit nvarchar(60),		-- наименование типа штатной единицы
	@salary	  int				-- оклад
as
	begin
		-- запрос на выборку
		select
			*
		from
			ViewUnits
		where
			UnitType = @typeUnit and Salary = @salary;
	end;
go

-- демонстрация работы процедуры

-- 1 набор параметров
declare @typeUnit nvarchar(60) = N'Директор',	@salary int = 100000;
exec SelectionWhereTypeUnitAndSalary @typeUnit, @salary;
go

-- 2 набор параметров
declare @typeUnit nvarchar(60) = N'Начальник',	@salary int = 80000;
exec SelectionWhereTypeUnitAndSalary @typeUnit, @salary;
go

-- 3 набор параметров
declare @typeUnit nvarchar(60) = N'Инженер',	@salary int = 60000;
exec SelectionWhereTypeUnitAndSalary @typeUnit, @salary;
go


-- 5	Однотабличная функция	
--		Выбирает из таблицы ШТАТНЫЕ_ЕДИНИЦЫ информацию о штатных единицах, имеющих 
--		заданное параметром наименование, для которых Процент_надбавки_2 имеет 
--		значение из некоторого заданного диапазона. Нижняя и верхняя границы диапазона 
--		также задаются параметрами функции

-- удаление однотабличной фукнции
drop function SelectionWhereTypeUnitAndLoHiInterestAllowancetTwo;
go

-- создание однотабличной функции
create function SelectionWhereTypeUnitAndLoHiInterestAllowancetTwo (@typeUnit nvarchar(60), @loInterest int, @hiInterest int)
	returns table
as
return
	-- запрос на выборку
	select
		*
	from
		ViewUnits
	where
		UnitType = @typeUnit and InterestAllowancetTwo between @loInterest and @hiInterest;
go

-- демонстрация работы однотабличной функции

-- 1 набор параметров
declare @typeUnit nvarchar(60) = N'Бухгалтер', @loInterest int = 5, @hiInterest int = 20;
select * from SelectionWhereTypeUnitAndLoHiInterestAllowancetTwo(@typeUnit, @loInterest, @hiInterest);
go

-- 2 набор параметров
declare @typeUnit nvarchar(60) = N'Начальник', @loInterest int = 15, @hiInterest int = 30;
select * from SelectionWhereTypeUnitAndLoHiInterestAllowancetTwo(@typeUnit, @loInterest, @hiInterest);
go

-- 3 набор параметров
declare @typeUnit nvarchar(60) = N'Директор', @loInterest int = 30, @hiInterest int = 40;
select * from SelectionWhereTypeUnitAndLoHiInterestAllowancetTwo(@typeUnit, @loInterest, @hiInterest);
go


-- 6	Однотабличная функция	
--		Вычисляет размер подоходного налога с начисленной заработной платы для 
--		каждой распределенной штатной единицы в соответствии с таблицей 
--		РАСПРЕДЕЛЕНИЕ_ШТАТНЫХ_ЕДИНИЦ. Включает поля Наименование подразделения, 
--		Наименование единицы, Оклад, Процент_надбавки_1, Процент_надбавки_2, 
--		Размер зарплаты, Налог. Сортировка по полю Наименование подразделения

-- удаление фукнции
drop function if exists CalculationIncomeTax;
go

-- создание функции
create function CalculationIncomeTax()
	returns table
as
return
	select TOP (select count(*) from ViewDistributionUnits)
		Id
		, DevisionTitle					-- Наименование подразделения
		, DevisionType					-- Тип подразделения
		, UnitType						-- Наименование единицы 
		, Salary						-- Оклад
		, InterestAllowancetOne			-- Процент_надбавки_1
		, InterestAllowancetTwo			-- Процент_надбавки_2
		, Salary * (1 + (InterestAllowancetOne + InterestAllowancetTwo) / 100.) as FinalSalary		-- Размер зарплаты
		, Salary * (1 + (InterestAllowancetOne + InterestAllowancetTwo) / 100.) * 0.17 as IncomeTax	-- Налог
	from
		ViewDistributionUnits
	order by
		ViewDistributionUnits.DevisionTitle;
go

-- демонстрация работы функции
select 		
	Id
	, DevisionTitle					-- Наименование подразделения
	, DevisionType					-- Тип подразделения
	, UnitType						-- Наименование единицы 
	, Salary						-- Оклад
	, InterestAllowancetOne			-- Процент_надбавки_1
	, InterestAllowancetTwo			-- Процент_надбавки_2
	, str(FinalSalary, 10, 2)		-- Размер зарплаты
	, str(IncomeTax, 10, 2)			-- Налог
from 
	CalculationIncomeTax();
go


-- 7	Однотабличная функция	
--		Выполняет группировку по полю Тип подразделения в таблице 
--		ПОДРАЗДЕЛЕНИЯ. Для каждой группы вычисляет среднее значение 
--		по полю Процент_надбавки_1

-- удаление однотабличной функции
drop function if exists CalculationAvgInterestAllowancetOne;
go

-- создание однотабличной функции
create function CalculationAvgInterestAllowancetOne()
	returns table
as
return
	select
		DevisionType
		, Count(*)						as  Amount
		, Min(InterestAllowancetOne)	as	[MinInterest]
		, Avg(InterestAllowancetOne)	as	[AvgInterest]
		, Max(InterestAllowancetOne)	as	[MaxInterest]
	from
		ViewDevisions
	group by
		DevisionType;
go

-- демонстрация работы функци
select
	*
from
	CalculationAvgInterestAllowancetOne() as result
order by 
	result.AvgInterest desc;		-- сортировка по среднему значению процента надбавки 1 (необязательно)
go


-- 8	Однотабличная функция	
--		Выполняет группировку по полю Наименование штатной единицы в таблице 
--		ШТАТНЫЕ_ЕДИНИЦЫ. Для каждой группы вычисляет минимальное и максимальное 
--		значения по полю Отпуск

-- удаление однотабличной функции
drop function if exists CalculationMinAndMaxLeaveDays;
go

-- создание однотабличной функции
create function CalculationMinAndMaxLeaveDays()
	returns table
as
return
	select
		UnitType
		, Count(*)			as Amount
		, Min(LeaveDays)	as MinLeaveDays
		, Avg(LeaveDays)	as AvgLeaveDays
		, Max(LeaveDays)	as MaxLeaveDays
	from
		ViewUnits
	group by
		UnitType;
go

-- демонстарция работы функции
select * from CalculationMinAndMaxLeaveDays();
go


-- 9	Запрос на создание базовой таблицы (просто запрос)	
--		Создает таблицу ШТАТНЫЕ_ЕДИНИЦЫ_ИНЖЕНЕР, содержащую информацию о штатных 
--		единицах с наименованием «инженер»

-- удаление таблицы Units_Engineer
drop table if exists Units_Engineer;
go

-- наименование штатной единицы
declare @unitType nvarchar(60) = N'Инженер';

-- сохранение выборки в таблицуUnits_Engineer
select 
	*
	into Units_Engineer
from
	ViewUnits
where
	ViewUnits.UnitType = @unitType;
go

-- вывод таблицы Units_Engineer
select
	*
from
	Units_Engineer;
go


-- 10	Хранимая процедура	
--		Создает копию таблицы ПОДРАЗДЕЛЕНИЯ с именем КОПИЯ_ПОДРАЗДЕЛЕНИЯ

-- удаление процедуры 
drop table if exists CopyDevisionTable;
go

-- создание процедуры
create proc CopyDevisionTable
as
	begin
			
		-- удаление таблицы Copy_Devisions
		drop table if exists Copy_Devisions;

		-- сохранение выборки в таблицу Copy_Devisions
		select 
			*
			into Copy_Devisions
		from
			Devisions;
	end;
go

-- демонстрация работы процедуры
exec CopyDevisionTable;

-- вывод таблицы КОПИЯ_ПОДРАЗДЕЛЕНИЯ
exec ShowCopy_Devisions;	


-- 11	Хранимая процедура	
--		Удаляет из таблицы КОПИЯ_ПОДРАЗДЕЛЕНИЯ записи, в которых значение в поле 
--		Процент_надбавки_1 меньше заданного значения

-- удаление процедуры
drop proc if exists DeleteFromCopy_DevisionsWhereInterestAllowancetOneLess;
go

-- создание процедуры
create proc DeleteFromCopy_DevisionsWhereInterestAllowancetOneLess
	@interest int	-- процент надбавки 1
as
	begin
		delete from 
			Copy_Devisions
		where
			Copy_Devisions.InterestAllowancetOne < @interest;
	end;
go

-- демонстрация работы процедуры

-- вывод таблицы Copy_Devisions до удаления записей
exec ShowCopy_Devisions;	-- вывод таблицы Copy_Devisions

-- 1 набор параметров
declare @interest int = 12;
exec DeleteFromCopy_DevisionsWhereInterestAllowancetOneLess @interest;
exec ShowCopy_Devisions;	-- вывод таблицы Copy_Devisions
go

-- 2 набор параметров
declare @interest int = 15;
exec DeleteFromCopy_DevisionsWhereInterestAllowancetOneLess @interest;
exec ShowCopy_Devisions;	-- вывод таблицы Copy_Devisions
go

-- 3 набор параметров
declare @interest int = 30;
exec DeleteFromCopy_DevisionsWhereInterestAllowancetOneLess @interest;
exec ShowCopy_Devisions;	-- вывод таблицы Copy_Devisions
go


-- 12	Хранимая процедура	
--		Увеличивает значение в поле Процент_надбавки_1 таблицы КОПИЯ_ПОДРАЗДЕЛЕНИЯ 
--		на заданное параметром значение для заданного параметром подразделения

-- пересоздание таблицы КОПИЯ_ПОДРАЗДЕЛЕНИЯ
exec CopyDevisionTable;
go

-- удаление процедуры
drop proc if exists IncreaseInterestAllowancetOneFromCopy_Devisions;
go

-- создание процедуры
create proc IncreaseInterestAllowancetOneFromCopy_Devisions
	@value			int,			-- значение, для увеличения
	@devisionTitle	nvarchar(60),	-- название подразделения
	@devisionType	nvarchar(60)	-- тип подразделения
as
	begin
		update
			Copy_Devisions
		set
			InterestAllowancetOne += @value
		where
			Copy_Devisions.Title = @devisionTitle and 
			Copy_Devisions.IdDevisionType in 
				(select DevisionTypes.Id from DevisionTypes where DevisionTypes.Title = @devisionType);
	end;
go

-- демонстрация работы процедуры

-- вывод таблицы Copy_Devisions до удаления записей
exec ShowCopy_Devisions;	-- вывод таблицы Copy_Devisions

-- 1 набор параметров
declare @interest int = 3, @devisionTitle nvarchar(60) = N'Кадровый', @devisionType	nvarchar(60) = N'Отдел';
exec IncreaseInterestAllowancetOneFromCopy_Devisions @interest, @devisionTitle, @devisionType;
exec ShowCopy_Devisions;	-- вывод таблицы Copy_Devisions
go

-- 2 набор параметров
declare @interest int = 5, @devisionTitle nvarchar(60) = N'Бухгалтерия', @devisionType	nvarchar(60) = N'Филиал';
exec IncreaseInterestAllowancetOneFromCopy_Devisions @interest, @devisionTitle, @devisionType;
exec ShowCopy_Devisions;	-- вывод таблицы Copy_Devisions
go

-- 3 набор параметров
declare @interest int = 8, @devisionTitle nvarchar(60) = N'Администрация', @devisionType	nvarchar(60) = N'Филиал';
exec IncreaseInterestAllowancetOneFromCopy_Devisions @interest, @devisionTitle, @devisionType;
exec ShowCopy_Devisions;	-- вывод таблицы Copy_Devisions
go