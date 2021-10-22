-- агрегатные функции
--      работает с группой записей, возвращает единственный результат
-- 5 агрегатный функций
--   COUNT() - количество
--   SUM()   - сумма
--   AVG()   - среднее значение
--   MIN()   - минимальное значение
--   MAX()   - максимальное значение

-- одна агрегатная функция в запросе
select 
    COUNT(*) as Count -- количество записей в таблице
from 
    books;
    
-- примеры запросов на COUNT
-- сколько книг с автором Абрамян
select 
    COUNT(*) as Count -- количество записей в таблице
from 
    books
where
    books.author like 'Абрамян М.Э.';
    
       
-- количество книг, изданных после 2003 года 
select 
    COUNT(*) as Count -- количество записей
from 
    books
where
    year > 2003;
    
-- суммарная стоимость всех книг библиотеки
select
     -- оба варианта допустимы
     SUM(price) as totalPrice 
     -- SUM(books.price) as totalPrice
from 
     books; 
     
-- минимальная цена книги
select
    MIN(books.price) as minPrice
from
    books;    
     
-- максимальная цена книги
select
    MAX(books.price) as maxPrice
from
    books;    
     

-- несколько агрегатных функций в одном запросе
-- выводим минимальный, средний, максимальный год издания   
select
    MIN(books.year)    as minYear
    , AVG(books.year)  as avgYear  -- округление только по явному требованию
    , MAX(books.year)  as maxYear
from
    books; 
    
-- выводим минимальный, среднюю, максимальную цену книги   
select
    MIN(books.price)    as minPrice
    , AVG(books.price)  as avgPrice  -- округление только по явному требованию
    , MAX(books.price)  as maxPrice
from
    books; 
    
-- группировка записей
-- пример группировки по категориям
-- вывести все категории книг
select
    category
    , COUNT(*) as total
from
    books
group by
    category
; 

-- получить различные записи по полю category
select distinct
    category
    -- !!! агрегатная функция "ломает" запрос !!!
    -- , COUNT(*) as total
from
    books
; 
    
-- пример группировки по году издания
select
    books.year
from
    books
group by
    books.year;        
    
-- пример применения группировки и агрегатной функции
-- выбрать количество книг по категориям  
-- минимальную, среднюю и максимальную цену
select
    category
    , COUNT(category) as quantity
    , MIN(price) as minPrice
    , AVG(price) as avgPrice
    , MAX(price) as maxPrice
from
    books
group by      -- группировать по категории 
    category; 
  
-- рейтинг категорий книг:
-- категория и количество книг в этой категории,
-- упорядоченные по убыванию (desc) количества книг в категории   
select
    category
    ,COUNT(category) as quantity
from
    books
group by      -- группировать по категории 
    category
order by
    quantity desc;  
    
-- два слова о сортировке
-- order by имяПоля или order by номерСтолбца
-- нумерация столбцов начинается с 1
-- можно сортировать и по нескольким столбцам
-- order by поле1 desc, поле2, поле3 desc, ...,  полеN
-- сортировка - в  порядке перечисления полей, т.е.
-- в начале по полю 1, затем по полю 2
select
    *
from
    books
order by
    5;    -- сортировка по цене

-- по убыванию цены    
select
    *
from
    books
order by
    5 desc;    -- сортировка по убыванию цены

-- по нескольким полям: авторы, цены    
select
    *
from
    books
order by
    2 desc, 5;    -- сортировка по авторам (обратный порядок), ценам
    
-- средний год издания, максимальная и средняя цена по категориям,
-- количество книг в категориях, суммарная стоимость книг в категориях
-- использование агрегатных функции SQL и встроенных функций
-- SQLite
select
    category
    , AVG(year) as avgYear
    , MAX(price) as maxPrice
    , AVG(price) as avgPrice   
    , printf("%.2f", AVG(price)) as avgPriceFormatted
    , COUNT(category) as amount       
    , SUM(price) as totalPrice
from
    books
group by      -- группировать по категории 
    category;

-----------------------------------------------------------------
-- агрегатная функция в условии отбора/фильтрации данных
-- синтаксис HAVING условноеВыржаение

-- авторы, средняя цена книг которых > 300
-- это пример на использование предложения HAVING 
select
    author
    , AVG(price) as AVGprice
from
    books
-- where
--    author like 'К%'    
group by
    author   
having
    AVG(price) > 500
    -- AVGprice > 500;  -- так тоже можно, это особенность SQLite              
order by
    AVGPrice desc;    