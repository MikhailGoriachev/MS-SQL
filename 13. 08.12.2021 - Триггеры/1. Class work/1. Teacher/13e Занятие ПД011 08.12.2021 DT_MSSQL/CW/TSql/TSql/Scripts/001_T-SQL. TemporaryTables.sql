/* 

-- Использование временной таблицы в запросе
-- select 
       список полей 
	   into имяТаблицы 
   from 
       ... 
   where 
       ...

select * into #table from Publications where Publications.Type like N'газета';
select * from #table;

-- ‼ важно, чтобы у всех столбцов были имена ‼
--   в нашем случае 1-й столбец - вычисляемый, имя не выводится сервером => нужен as
     (оператор задания псевдонима)     
	 
-- Выводим таблицу если есть данные для отображения
-- иначе - сообщение об отсутствии данных

   ##имяТаблицы - глобальная временная таблица (удаляется при завершении всех сеансов сервера)
   #имяТаблицы  - локальная временная таблица (удаляется при завершении текущего сеанса) 

*/

-- выбрать данные о книгах - пример локальной временной таблицы
select * into #temporary from Books where PubYear > 2018;
select * from #temporary;
go

--временная таблица м.б. удаление
drop table #temporary;
go

-- после удаления предыдущего варианта
-- во временную таблицу можно выбрать другой набор данных 
select * into #temporary from Authors where Id between 5 and 15;
select * from #temporary;
go

-- выбрать данные о категориях - пример глобальной временной таблицы
select * into ##temporary from Categories where Id >2;
select * from ##temporary;
go

-- глобальная временная таблица м.б. удаление
drop table if exists ##temporary;
go

-- в глобальную временную таблицу можно выбрать другой набор данных 
select * into ##temporary from Authors where FullName like N'Ш%';
select * from ##temporary;
go

-- пример использования default при создании таблицы, вставки записей в таблицу

drop table if exists Details;

create table Details (
     id     int not null identity(1, 1),  -- для автоинкремента
	 FamIO  nvarchar(60) not null default N'Неизвестный Н.Н.',
	 Age    int not null,
	 
	 constraint Details_PK primary key (id),
	 constraint Details_Age_check check (Age between 12 and 67) 
);
go


create table Logins (
	id      int          not null identity(1, 1) constraint Logins_PK primary key(id),
	logName nvarchar(25) not null                constraint Logins_UNIQ unique(logName),
	pswd    nvarchar(25) not null default '123',
	idDetail int         not null                
	    constraint FK_Details foreign key(idDetail) references Details(id) 
		    on update cascade   -- политика обновления связанных таблиц
			on delete cascade   -- политика удаления связанных таблиц
);
go

insert into Details values 
       (N'Романофф Н.Е', 35)
go

insert into Details values 
       (N'Петров П.Н', 45),
	   (N'Сидорова Т.Г.', 34),
	   (N'Васильева Е.Е.', 29)
go	  

insert into Details
    (Age)
values
    (42);


insert into Logins values
       (N'romanoff', '', 1),
	   (N'petrov', '', 2),
	   (N'ts', 'ts', 3),
	   (N'ee', 'parol', 4)
go

-- При явном задании списка полей, в качестве значений
-- не указанных полей и применяется значение, заданное оператором default
-- при создании таблицы
insert into Logins (logName, idDetail) values('yyy', 1);
insert into Logins (logName, idDetail) values('rrr', 1);

-- exec sp_helptext sp_renamedb

-----------------------------------------------------------------------------

-- проверка существования таблицы в БД, встроенной процедуры, функции
-- при помощи функции object_id

declare @name nvarchar(80) = N'Authors';

if OBJECT_ID(@name) is not null
    print N'Таблица ' + @name + N' найдена в БД Library';
else
    print N'Таблица ' + @name + N' не найдена в БД Library';

set @name = N'sumTwo'; 
if OBJECT_ID(@name) is not null
   print N'Хранимая процедура ' + @name + N' найдена в БД Library';
else
    print N'Хранимая процедура ' + @name + N' не найдена в БД Library';

set @name = N'GetBooksTable';
if OBJECT_ID(@name) is not null
   print N'Табличная функция ' + @name + N' найдена в БД Library';
else
    print N'Табличная функция  ' + @name + N' не найдена в БД Library';

set @name = N'foo'; 
if OBJECT_ID(@name) is not null
   print N'Скалярная функция ' + @name + N' найдена в БД Library';
else
    print N'Скалярная функция  ' + @name + N' не найдена в БД Library';    

-----------------------------------------------------------------------------
