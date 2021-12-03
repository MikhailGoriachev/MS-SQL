/* 

   Хранимые процедуры
   ☼ встроенные: sp_xxxx
   ☼ определяемые программистом

   Вызов
   execute имяПроцедуры списокПараметров
   exec имяПроцедуры списокПараметров

   Создание процедуры
   create procedure ....
   create proc ....

   Изменение процедуры
   alter procedure ....

   Удаление процедуры 
   drop procedure имяПроцедуры

   Синтаксис создания процедуры
	create procedure имяПроцедуры
	    @пар1 тип = значПоУмолч output readonly,
	    ...
	    @пар1024 тип = значПоУмолч output readonly
	as
	begin
	    оператор-содержащий-select
		return выражение
	end

	-- пример процедуры, возвращающей значение
	create proc sumTwo
       @a int,
       @b int
	as
	begin
	   return @a + @b;
	end
	go

	-- тестовый вызов
	declare @res int 
	exec @res = sumTwo 1, 7
	select @res as 'сумма'
	go

*/
--exec sp_helpdb EntryExams_VPD011_031021
--exec sp_renamedb 'HWE_EntranceExams_09112019', 'HWE_EntranceExams_22112020'
--exec sp_helptext sp_helpdb  -- вывод текста процедуры sp_helpdb

-- пример процедуры с параметрами
create proc summa
   @a int,
   @b int,
   @sum int out
as
begin
   set @sum = @a + @b;
end
go


-- примеры обращения к процедуре
declare @result int

-- с явным указанием параметров
exec summa @b = 20, @a = 10, @sum = @result out
select 10, 20, @result

-- с позиционным указанем параметров
exec summa 20, 30, @result out
select 20, 30, @result

declare @x int = 40, @y int = 50
exec summa @a = @x, @b = @y, @sum = @result out
select @x, @y, @result
go

-------------------------------------------
-- процедура, возвращающая значение через return
create proc addTwo
   @a int,
   @b int
as
begin
   return @a + @b;
end
go

declare @summa int
declare @x int = 40, @y int = 50
exec @summa = addTwo @x, @y 
select @x, @y, @summa
go

-----------------------------------------------------------

-- Proc5. 
-- Описать процедуру RectPS(x1, y1, x2, y2, P, S), вычисляющую 
-- периметр P и площадь S прямоугольника со сторонами, параллельными 
-- осям координат, по координатам (x1, y1), (x2, y2) его противоположных вершин
-- (x1, y1, x2, y2  входные, P и S  выходные параметры вещественного типа). 
-- — помощью этой процедуры найти периметры и площади трех пр¤моугольников 
-- с данными противоположными вершинами.

create proc RectPS
    @x1 float,
	@y1 float,
	@x2 float,
	@y2 float,
	@p  float out,
	@s  float out
as
begin
    declare @a float = ABS(@x1 - @x2)
	declare @b float = ABS(@y1 - @y2)

	set @p = 2*@a + 2*@b
	set @s = @a * @b
end
go

-- Proc6. 
-- Описать процедуру DigitCountSum(K, C, S), находящую количество C
-- цифр целого положительного числа K, а также их сумму S (K - входной,
-- C и S - выходные параметры целого типа). — помощью этой процедуры
-- найти количество и сумму цифр для каждого из пяти данных целых чисел.
create proc DigitCountSum
   @k int,
   @c int out,   -- счетчик цифр
   @s int out    -- сумма цифр
as
begin
    set @c = 0;                 -- счетчик цифр
	set @s = 0;                 -- сумма цифр
    while @k != 0 begin         -- пока есть цифры в числе
	    set @c += 1;            -- посчитали очередную цифру
		set @s += @k % 10;  -- просуммировали очередную цифру
		set @k /= 10;       -- отбросили очередную младшую цифру
	end
end
go  

-----------------------------------------------------------------------

DECLARE	@p float,
		@s float;

EXEC	dbo.RectPS  @x1 = 1, @y1 = 1, @x2 = 3, 	@y2 = 3,
		@p = @p OUTPUT, -- параметр @p связать с локальной переменной @p 
		@s = @s OUTPUT;

SELECT	@p as '@p',
		@s as '@s';

DECLARE	@perim float,
		@area float;

EXEC	dbo.RectPS  @x1 = 1, @y1 = 1, @x2 = 3, 	@y2 = 3,
		@p = @perim OUTPUT,  -- параметр @p связать с локальной переменной @perim 
		@s = @area OUTPUT;

SELECT	@perim as '@p',
		@area as '@s';

EXEC	dbo.RectPS  1, 1, 3, 3, @perim OUTPUT, @area OUTPUT;

SELECT	@perim as '@p',
		@area as '@s';
GO

declare @x int = 503, @count int, @sum int;
exec DigitCountSum @x, @count out, @sum out;
select @x as number, @count as [count], @sum as sum;
go

-- Хранимые процедуры с запросом к таблицам базы данных -----------------------------

-- Возвращает таблицу с книгами после заданного года издания 
create procedure BooksTableAfterYear
     @year int
as
begin
    -- не обязательно выбирать все поля
	-- сортировка записей выполняется в функции только
	-- если указано количество обрабатываемых записей
	select top (select COUNT(*) from books) -- получим количество записей
		Id
		, IdAuthor
		, IdCategory
		, title
		, PubYear  
	from
		books
	where
	    PubYear > @year
	order by           -- сортировка
        PubYear;
end;
go


-- вызов процедуры для книг с годом издания после 2014
exec dbo.BooksTableAfterYear 2014;
go

exec dbo.BooksTableAfterYear 2016;
go

-- выбрать всех авторов
create proc GetAllAuthors
as
begin
	select
	    *
    from
	    Authors;
end;
go

-- выполнение
exec dbo.GetAllAuthors;
go