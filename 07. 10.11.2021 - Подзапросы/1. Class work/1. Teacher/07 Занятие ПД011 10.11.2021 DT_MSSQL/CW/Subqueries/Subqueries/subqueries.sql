-- Ключевые слова для подзапросов: in, any, some, all, exists

-- in
-- вывести книги авторов, фамилии которых начинаются на букву К
-- подзапрос возвращает набор значений, нам необходимо вывести 
-- все записи с этими значениями
-- !!! пример искусственный - лучше без подзапроса !!!
select
   authors.[name]
   , books.title
   , books.[year]
   , books.price
   , books.amount
from
    books join authors on books.idAuthor = authors.id
where
    -- authors.name like N'К%'
    authors.[name] in (select authors.[name] from authors where authors.[name] like N'К%')
order by
    authors.name;
        
-- not in
-- вывести книги авторов, кроме тех, фамилии которых начинаются на букву К
select
   authors.[name]
   , books.title
   , books.[year]
   , books.price
   , books.amount
from
    books  join authors on books.idAuthor = authors.id
where
    authors.[name] not in (select authors.name from authors where authors.name like N'К%')
order by
    authors.[name];       
 
-- exists
-- вывести авторов, книги которых есть в библиотеке

-- а) без подзапроса
select
   authors.id
   , authors.name
from
    authors join books on authors.id = books.idAuthor
group by
    authors.id, authors.name 
having
    COUNT(books.idAuthor) > 0   
order by
    authors.name    
;  


-- б) с подзапросом
-- перебираем всех авторов из таблицы авторов
-- отбираем только тех, чьи идентификаторы существуют/находятся в таблице книг
select
    authors.id
    , authors.name
from
    authors
where
    -- authors.id - данные из таблицы authors доступны в подзапросе к таблице books 
    exists (select * from books where books.idAuthor = authors.id)
order by
    authors.name 
;            

-- not exists
-- вывести категории, книги которых отсутствуют в библиотеке
select 
   categories.id
   , categories.category
from
    categories
where
    not exists (select * from books where books.idCategory = categories.id)
order by
    categories.category    
;

-- any, some  могут использоваться с операциями сравнения
-- выбрать всех авторов учебников
select
    *
from
    authors
where
    authors.id = any (
        select books.idAuthor from books where books.idCategory = (select id from categories where Category = N'учебник')
);

-- all
-- вывести все книги, количество которых больше количества монографий
select
    Authors.[Name]
    , Books.Title
    , Books.Amount
    , Categories.Category
from
    books join authors on books.idAuthor = authors.id
          join categories on books.idCategory = categories.id
where
    -- собственный подзапрос - т.е. к таблице основного запроса
    books.amount > all (select books.amount from books where books.idCategory = 3);     
    
-----------------------------------
