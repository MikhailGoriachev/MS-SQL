/* 
☼ хранимые функции
  ► однозапросные функции / однотабличные / однострочные
  ► многозапросные

  они возвращают таблицу, на них можно ссылаться в where

Операторы для работы с функциями: create, alter, drop (создание, изменение, удаление)

☼ синтаксис создания для однотабличной функции
  create function имяФункции(@имя1 тип1, ...)
  returns table
  with encryption   -- шифровать тело функции, одна из опций функции
  as
  return select-оператор

☼ синтаксис редактирования/изменения для однотабличной функции
  alter function имяФункции(@имя1 тип1, ...)
  returns table
  with encryption   -- шифровать тело функции, одна из опций функции
  as
  retrun select-оператор

☼ синтаксис удаления
  drop function имяФункции
  drop function GetMostPopularRouteTable

☼ синтаксис создания многотабличной функции
  create function имяФункции(@имя1 тип, ...)
  returns @имяПеременной table (  -- описание таблица
     имяСтолбца1 тип1, 
	 имяСтолбца2 тип2,
	 ...
	 имяСтолбцаN типN
  )
  with encryption        -- шифровать тело функции, одна из опций функции
  as
  begin
      операторы тела функции, формирующие таблицу в переменной @имяПеременной
	  return    -- да, просто пустой оператор, т.к. куда писать результат уже задано
  end

  ‼ в конце запросов проверяйте наличие ";" - это важно для функций

*/


-- Возвращает таблицу с книгами после заданного года издания 
create function GetBooksTable(@year int)
returns table
as
return 
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
go

-- вызов функции GetBooksTable()
select 
    * 
from 
    dbo.GetBooksTable(2014);

-- соединение таблицы, полученной из функции с другими таблицами базы данных
-- использование синонима источника данных
select 
     authors.FullName
	 , selection.Title
	 , selection.PubYear
from 
    -- сначала выполняется функция, затем join с гораздо меньшим количеством записей
    dbo.GetBooksTable(2014) as selection join authors
	on selection.idAuthor = authors.id;
go