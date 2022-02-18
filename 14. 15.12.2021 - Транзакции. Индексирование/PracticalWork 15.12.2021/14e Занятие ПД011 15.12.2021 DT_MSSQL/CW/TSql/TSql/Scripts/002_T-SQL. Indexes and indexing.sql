/* 
Хранение данных в таблицах БД:
     - запись
	 - страница 8 КБайт
	 - экстент
	 
Индексы в базах данных

Индекс - служебная таблица, хранящая порядок чтения/записи
связанной с ней таблицы, соответствующий заданному критерию 
сортировки - для поиска данных


Или так:
"Индекс представляет собой упорядоченный логический указатель 
на записи в таблице"

Т.е. вместо физической сортировки связанной таблицы строится
служебная таблица (обычно небольшая)

Чтение записей в порядке следования в индексе - замена сортировки
исходной таблицы

Создание индекса
create index имяИндекса on ИмяТаблицы(Поле1 ASC|DESC, Поле2 ASC|DESC, ...)
create index имяИндекса on ИмяПредставления(Поле1 ASC|DESC, Поле2 ASC|DESC, ...)

Удаление индекса
drop index имяТаблицы.имяИндекса
drop index ИмяПредставления.имяИндекса

Индексы ускоряют поиск по полю - ключу индекса

создание уникального индекса
create unique index имяИндекса on имяТаблицы(Поле1 ASC|DESC, Поле2 ASC|DESC, ...)

применение уникального индекса
► предотвращение дубликатных данных
► сортировка по индексному выражению оператором select без использования order by

представления можно индексировать
индексированные представления физически размещаются на накопителе (материализуются
- в OracleDB так и называются - материализованные)

‼ если строится запрос к таблица для которой есть индексированное представление,
  то запрос перестривается на использование этого представления

‼ Особенности создания представлений с возможностью индексирования
  (материализации) в MS-SQL Server
  а) требуется указать ключевые слова with  schemabinding
  б) требуется использовать имена таблиц вида владелец.ИмяТаблицы
     (обычно dbo.ИмяТаблицы)
	 
     create view ИмяПредставления
     with schemabinding
     as 
     select 
     	списокПолей
     from
     	dbo.ИмяТаблицы 
		
‼ Особенности создания индекса представлений в MS-SQL Server
  (материализации) - требуется явное указание ключевого слова clustered
  индекс должен быть уникальным:

  create unique clustered index ИмяИндекса on ИмяПредставления (списокПолей);

*/


create index  BooksAuthor on Books(IdAuthor) ;
go

select * from Books where IdAuthor = 6;
go

drop index if exists Books.BooksAuthor; 
go


-- получить список индексов таблицы
exec sp_helpindex Books;

-- уникальный индекс, предотвращающий дублирование данных
-- уникальный индекс по ФИО подписчиков
create unique index UniqFullname on Authors(Fullname);
go

drop index Authors.UniqFullname;

exec sp_helpindex Authors;

insert into Authors(FullName) values
    (N'Иванова О.В.'); 

insert into Authors(FullName) values
    (N'Иванова О.В.'); 

delete from Subscribers where id >= 20;

select * from Authors;
go

-----------------------------------------------------------------------------
-- создание представления для издания с возможностью индексирования
create view ViewPublications with schemabinding
as
select
    Publications.Id
	, PublicationTypes.TypesName
	, Publications.PublicationIndex
	, Publications.PublicationName
	, Publications.Price
from
    dbo.Publications join dbo.PublicationTypes on Publications.IdType = PublicationTypes.Id
go

-- индексирование представления по ключу PublicationIndex (материализация)
-- создание уникального индекса
create unique clustered index IndexesViewPeriodicals on ViewPublications (PublicationIndex);
go
select * from ViewPublications order by PublicationIndex;
