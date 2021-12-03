/* 

   Пользовательские функции

   В T-SQL различают
   ☼ функции, определяемые пользователем - хранимые функции
     ► скалярные функции - возвращают некое значение ("обычные" функции)
	   для упрощения алгоритмов запросов
	   для более эффективной работы программиста
     ► однотабличные, inline-функции, возвращают специальный тип - table
	   содержат один запрос к БД
	 ► многотабличные функции, multiline-функции, возвращают специальный тип - table
	   содержат один или более запросов к БД
   ☼ хранимые процедуры - упрощение программирования запросов
   ☼ триггеры - обработка событий, связанных с данными

   В T-SQL все эти функции и процедуры связаны с конкретной БД
   Функции/процедуры/триггеры - создаются / изменяются / удаляются
                                create    / alter      / drop

   Скалярные функции
								
   создание скалярной функции
   create function имяФункции(@имяПараметра1 тип, ...) 
       returns типВозвращаемогоЗначения
	   as
	   begin
	      операторы тела функции
		  return выражение
       end

   изменение скалярной функции - старая функция удаляется, новая
   функция применяется
   alter function имяФункции(@имяПараметра1 тип, ...) 
       returns типВозвращаемогоЗначения
	   as
	   begin
	      операторы тела функции
		  return выражение
       end

   удаление функции
   drop function имяВладельца.имяФункции


-- Пример создания скалярной функции

create function foo()
    returns int
	as
	begin
	    declare @a int = 100;
		return @a; 
	end
go

-- Пример изменения скалярной функции

alter function foo(@a int)
    returns int
	as
	begin
		return 2*@a 
	end
go

-- Пример удаления скалярной функции

drop function dbo.foo

-- Пример функции, возвращающей количество клиентов с
-- с заданной первой буквой фамилии
create function numClients(@firstLetter nvarchar) returns int
as
begin
	declare @n int
	select @n = (
	     select 
		     count(Family) 
		 from 
		     Clients 
		 where 
		     -- подходят строки с заданным первым символом и любым продолжением
		     Surname like @firstLetter + '%'
	)
	return @n
end

Более краткий вариант записи функции:

-- Пример функции, возвращающей количество клиентов с
-- с заданной первой буквой фамилии
create function numClients(@firstLetter nvarchar) returns int
as
begin
	return (
	select 
		count(Surname) 
	from 
		Clients 
	where 
		-- подходят строки с заданным первым символом и любым продолжением
		Surname like @firstLetter + '%'
	)
end 

*/

-- Пример создания скалярной функции

-- создание скалярной функции
create function foo()
    returns int
	as
	begin
	    declare @a int = 100;
		return @a; 
	end
go

-- вызов скалярной функции
declare @r int;
set @r = dbo.foo()
select @r as r
go

-- Пример изменения скалярной функции

-- alter для изменения
create function foo(@a int)
    returns int
	as
	begin
		return 2*@a; 
	end;
go

-- вызов функции
declare @r int;
set @r = dbo.foo(3);
select @r as r
go

-- Пример удаления скалярной функции
drop function foo;
go


declare @b int;

-- примеры вызова функции
set @b = dbo.foo(10);
print N'Значение, полученное из функции ' + ltrim(@b);

set @b = dbo.foo(20)
print N'Значение, полученное из функции ' + ltrim(@b)

print N'Значение, полученное из функции ' + ltrim(dbo.foo(30))

print N'Значение, полученное из функции ' + ltrim(@b)
select @b = dbo.foo(50);

-- это именно запрос!!!
select dbo.foo(40) as N'Значение функции'

-- вызов функции при помощи специального оператора
execute @b = dbo.foo 60
print N'Значение, полученное из функции ' + ltrim(@b)

exec @b = dbo.foo 70
print N'Значение, полученное из функции ' + ltrim(@b)

exec dbo.foo 80
print N'Функция отработала'
go
---------------------------------------------------------------

-- использование скалярной функции для получения данных из таблицы БД Library

-- средняя цена книги
drop function if exists AverageBookPrice;
go

create function AverageBookPrice()
    returns float
	as
	begin
	    -- вариант 1
	    declare @avgPrice float;
		select @avgPrice = AVG(Books.price) from Books;
		return @avgPrice;
		
		-- вариант 2
		-- return (select AVG(Books.price) from Books); 
	end;
go


select dbo.AverageBookPrice() as AvgBookPrice;

declare @avg float = dbo.AverageBookPrice();
print char(9) + N'Средняя цена книги: ' + convert(nvarchar, @avg);
go 


-- Пример функции, возвращающей количество книг с
-- с заданной первой буквой названия
drop function if exists NumBooks;
go

-- Получить количество книг, с заданным первым символом в названии
create function NumBooks(@firstLetter nvarchar) returns int
as
begin
	declare @n int;

	set @n = (
	     select 
		     count(*) 
		 from 
		     books 
		 where 
		     -- подходят строки с заданным первым символом и любым продолжением
		     books.title like @firstLetter + '%'
	);
	return @n;
end
go

-- применение функции
select dbo.numBooks('W') as totalBooks;
go
select dbo.numBooks(N'Э') as totalBooks;
go