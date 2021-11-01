-- Операторы DDL - Create, Update, Delete

-- CRUD-операции: Create, Read, Update, Delete
-- Create: insert
-- Read  : select
-- Update: update
-- Delete: delete
    
-- добавление записи в таблицу - create
/*
insert into имяТаблицы
    (списокСтолбцов)
values
    (списокЗначенийОднойЗаписи); 
*/
insert into Books
    (Author, Title, Publication, Price, Category)
values
    (N'Абрамян М.Э.', N'1000 задач по программированию', 2002, 100, N'задачник');


-- добавление нескольких записей в таблицу, bulk-операции
/*
insert into имяТаблицы
    (списокСтолбцов)
values
    (списокЗначенийЗаписи1),
    (списокЗначенийЗаписи2),
    ...
    (списокЗначенийЗаписиN); 
*/
insert into Books
    (Author, Title, Publication, Price, Category)
values
    (N'Лукаш Т.Е.', N'NodeJS для серверов', 2016, 800, N'учебник'),
    (N'Аскольдиков Б.Н.', N'Apache 2.4 - оптимизация', 2012, 400, N'монография'),
    (N'Борисова Р.К.', N'Практикум STL для C++17', 2018, 700, N'задачник');

-- изменение записи/записей в таблице, update
/* 
update
    имяТаблицы
set
    выражениеДляПоля1,
    выражениеДляПоля2,
    ...
    выражениеДляПоляN
where
    условиеВыбораЗаписи;
*/
-- увеличиваем цену задачников на 100 рублей 
update
    Books
set
    -- Price = Price + 100
    Price += 100
where
    Category = N'задачник'
;

-- как бы отмена изменений - запрос возвращает исходные значения
-- в поле цены задачников
update
    Books
set
    Price -= 100
where
    Category = N'задачник';  
    

-- изменение нескольких полей - изменить автора, уменьшить цену на 20%, 
-- увеличить год издания для книг автора Лукаш Т.Е.
update
    NewBooks
set
    Author = N'Павловская Т.Е.',
    Price *= 0.8,
    Publication += 1
where
    Author = N'Лукаш Т.Е.';

----------------------------
-- меняем цену и год издания для учебника
update
    Books
set
    Price += 200
    , Publication += 1
where
    category = N'учебник'; 
    
update
    Books
set
    Price -= 200
    , Publication -= 1
where
    category = N'учебник'; 


-- удаление записи/записей из таблицы
/*
delete from
    имяТаблицы
where
    необязательноеУсловиеОтбораЗаписей; 
*/
delete from
    NewBooks
where
    Author in (N'Васильев А.Н.', N'Лукаш Т.Е.', N'Аскольдиков Б.Н.', 'Борисова Р.К.'); 
    
-- удаление таблицы
drop table NewBooks;

-- копирование структуры и данных в таблицу
-- !!! ограничения не копируются !!!
select
   *
   into NewBooks
from
    Books;
