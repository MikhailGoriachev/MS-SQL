-- Запрос 1.
-- Вывести полную информацию обо всех изданиях (категорию
-- книги выводить полем categories.category)
select
    Books.Id
    , Authors.FullName
    , Categories.Category
    , Books.Title
    , Books.PubYear
    , Books.Price
    , Books.Amount
from
    Books, Authors, Categories
where
    Books.IdAuthor = Authors.Id and Books.IdCategory = Categories.Id;

select
    Books.Id
    , Authors.FullName
    , Categories.Category
    , Books.Title
    , Books.PubYear
    , Books.Price
    , Books.Amount
from
    Books inner join Authors on Books.IdAuthor = Authors.Id 
          inner join Categories on Books.IdCategory = Categories.Id;

select
    -- *
    Books.Id
    , Authors.FullName
    , Categories.Category
    , Books.Title
    , Books.PubYear
    , Books.Price
    , Books.Amount
from
    Books join Authors on Books.IdAuthor = Authors.Id 
          join Categories on Books.IdCategory = Categories.Id;

-- Запрос 2.
-- Вывести название, год издания, автора и цену учебников по Андроид
select
    Books.Id
    , Authors.FullName
    , Categories.Category
    , Books.Title
    , Books.PubYear
    , Books.Price
from
    Books inner join Authors on Books.IdAuthor = Authors.Id 
          inner join Categories on Books.IdCategory = Categories.Id
where
    Categories.Category = N'учебник' and
    Books.Title like N'Android %' or Books.Title like N'% Android' or Books.Title like N'% Android %';

-- Запрос 3.
-- Вывести название, год издания и количество задачников по LINQ 
select
    Books.Id
    , Categories.Category
    , Books.Title
    , Books.PubYear
    , Books.Amount
from
    Books join Authors on Books.IdAuthor = Authors.Id 
          join Categories on Books.IdCategory = Categories.Id
where
    Categories.Category = N'задачник' and
    Books.Title like N'LINQ %' or Books.Title like N'% LINQ' or Books.Title like N'% LINQ %';

-- Запрос 4.
-- Вывести автора, название, категорию и стоимость для каждой книги,
-- количество которых от 4 до 6 
select
    Books.Id
    , Authors.FullName
    , Categories.Category
    , Books.Title
    , Books.Price
    , Books.Amount
from
    Books join Authors on Books.IdAuthor = Authors.Id 
          join Categories on Books.IdCategory = Categories.Id
where
    Books.Amount between 4 and 6;

-- Запрос 5.
-- Вывести фамилии и инициалы авторов и количество книг этих авторов
select
    Authors.FullName
    , Sum(Books.Amount) as SumTotal
from
    Books join Authors on Books.IdAuthor = Authors.Id 
group by
    Authors.FullName;

-- Запрос 6.
-- Для категорий книг вывести количество, минимальную стоимость
-- книги, среднюю стоимость книги, максимальную стоимость книги

-- Запрос 7.
-- Вывести общее количество книг по C++


