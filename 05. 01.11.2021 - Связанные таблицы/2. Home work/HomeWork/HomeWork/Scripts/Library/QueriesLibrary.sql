-- Запрос 1. Вывести полную информацию обо всех книгах
select
	Books.[Id]
	, Authors.[FullName]
	, Categories.[Category]
	, Books.[Title]
	, Books.[PubYear]
	, Books.[Price]
	, Books.[Amount]
from
	Books inner join Authors on Books.[IdAuthor] = Authors.[Id]
		  inner join Categories on Books.[IdCategory] = Categories.[Id];

-- Запрос 2. Запрос с параметрами. Вывести полную информацию по 
-- книгам заданного автора, изданным в заданный период. Например, 
-- автор Абрамян М.Э., период с 2002 по 2019
-- Варианты авторов: 
-- Шилдт Г.
-- Кент Дж.
-- Абрамян М.Э.
-- Дейтел П.
-- Кузнецов И.А.
-- Егоренко В.Н.
-- Кравец С.А.

-- переменные для отбора
declare @min int = 2002, @max int = 2019, @selectAuthor nvarchar(20) = N'Абрамян М.Э.';

select
	Books.[Id]
	, Authors.[FullName]
	, Categories.[Category]
	, Books.[Title]
	, Books.[PubYear]
	, Books.[Price]
	, Books.[Amount]
from
	Books inner join Authors on Books.[IdAuthor] = Authors.[Id]
		  inner join Categories on Books.[IdCategory] = Categories.[Id]
where
	Authors.[FullName] = @selectAuthor and Books.[PubYear] between @min and @max;
go

-- Запрос 3. Запрос с параметрами. Вывести название, год издания 
-- и количество (поле books.amount) книг заданной категории, 
-- имеющих заданную строку в названии. Например, категория 
-- «задачник», строка в названии «LINQ». 

-- переменные для отбора
declare @selectCategory nvarchar(20) = N'задачник', @selectStrTitle nvarchar(50) = N'%LINQ%';

select
	Books.[Id]
	, Books.[Title]
	, Books.[PubYear]
	, Books.[Amount]
	, Categories.[Category]
from
	Books inner join Categories on Books.[IdCategory] = Categories.[Id]
where
	Categories.[Category] = @selectCategory and Books.[Title] like @selectStrTitle;
go

-- Запрос 4. Запрос с параметрами. Вывести автора, название, 
-- категорию и стоимость для каждой книги, количество которых 
-- от 4 до 6 

-- переменные для отбора
declare @min int = 4, @max int = 6;

select
	Books.[Id]
	, Authors.[FullName]
	, Books.[Title]
	, Categories.[Category]
	, Books.[Price]
	, Books.[Amount]
from
	Books inner join Categories on Books.[IdCategory] = Categories.[Id]
		  inner join Authors on Books.[IdAuthor] = Authors.[Id]
where
	Books.[Amount] between @min and @max;
go

-- Запрос 5. Итоговый запрос. Вывести фамилии и инициалы авторов,
-- количество (сумма полей books.amount) книг этих авторов
select
	Authors.[FullName]
	, SUM(Books.[Amount]) as NumberOfCopies
	, COUNT(*) as [CountBooksAuthor]
from
	Books inner join Authors on Books.[IdAuthor] = Authors.[Id]
group by
	Authors.[FullName];

-- Запрос 6. Итоговый запрос. Для категорий книг вывести 
-- количество, минимальную стоимость книги, среднюю стоимость 
-- книги, максимальную стоимость книги
select
	Categories.[Category]
	, COUNT(*) as [Count]
	, MIN(Books.[Price]) as [MinPrice]
	, AVG(Books.[Price]) as [AvgPrice]
	, MAX(Books.[Price]) as [MaxPrice]
from
	Books inner join Categories on Books.[IdCategory] = Categories.[Id]
group by 
	Categories.[Category];

-- Запрос 7. Итоговый запрос. Вывести общее количество книг 
-- по C++ (сумма полей books.amount)

-- показать книги по C++
select
	Books.[Id]
	, Books.[Title]
	, Authors.[FullName]
	, Categories.[Category]
	, Books.Amount
from
	Books inner join Authors on Books.[IdAuthor] = Authors.[Id]
		  inner join Categories on Books.[IdCategory] = Categories.[Id]
where
	Books.Title like N'C++[ ,.!]%' or Books.Title like N'%[ ,.!]C++' or Books.Title like N'%[ ,.!]C++[ ,.!]%' or Books.Title like N'C++'

-- показать суммарное количество полей books.amount книг по C++
select
	N'C++' as [BooksOn]
	, SUM(Books.[Amount]) as [Count]
from
	Books inner join Authors on Books.[IdAuthor] = Authors.[Id]
		  inner join Categories on Books.[IdCategory] = Categories.[Id]
where
	Books.Title like N'C++[ ,.!]%' or Books.Title like N'%[ ,.!]C++' or Books.Title like N'%[ ,.!]C++[ ,.!]%' or Books.Title like N'C++'