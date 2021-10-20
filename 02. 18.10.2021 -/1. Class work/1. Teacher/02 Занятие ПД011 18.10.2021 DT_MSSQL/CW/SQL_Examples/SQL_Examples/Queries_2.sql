-- Выбрать все поля всех записей таблицы Books
select
    *
from
    Books;    
    

-- Выбрать все поля тех записей таблицы Books у которых
-- в фамилии или инициалах автора есть буква Р и цена
-- книги больше 100
select
   *
from
    Books
where
    (Author like N'Р%' or Author like N'%р%' or Author like N'%Р%') and Price > 100;      


-- Выбрать книги с годом издания, меньше заданного
select
   *
from
    Books
where
    [Public] < 2015;

-- Выбрать книги с ценой в заданном диапазоне
select
   *
from
    Books
where
    Price between 100 and 600;

-- Выбрать книги, дешевле 450 р.
select
   *
from
    Books
where
    Price < 450;

-- Выбрать книги, дороже 600 р.
select
   *
from
    Books
where
    Price > 600;

 -- Выбрать все поля всех записей таблицы Books,
 -- упорядочить выбранные записи по авторам 
select
   *
from
    Books
order by
    Author;

 -- Выбрать все поля всех записей таблицы Books,
 -- упорядочить выбранные записи по убыванию году издания  
select
   *
from
    Books
order by
    [Public] desc;
   
 -- Выбрать все поля записей таблицы Books, для которых стоимость 
 -- книги в диапазоне от 100 до 600 р.
 -- упорядочить выбранные записи по убыванию года издания   
select
   *
from
    Books
where
    Price between 100 and 600    
order by
    Price desc, [Public];