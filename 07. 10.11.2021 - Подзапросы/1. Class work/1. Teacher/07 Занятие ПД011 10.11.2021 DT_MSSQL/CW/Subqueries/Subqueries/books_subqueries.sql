-- Решение через подзапрос
-- Подзапрос - запрос в запросе
-- Для всех книг автора Абрамян М.Э. увеличить стоимость книг на 15%
update
    books
set
    price *= 1.15
where
    idAuthor = (select id from authors where name = N'Абрамян М.Э.');
          
update
    books
set
    price /= 1.15
where
    idAuthor = (select id from authors where name = N'Абрамян М.Э.');
       
      
-- С использованием подзапросов
-- Добавить монографию автора Кент Дж. с названием "Решения без проблем на C++",
-- 2011 года издания, стоимостью 720 р., количеством 3 экземпляра
insert into Books 
    (idAuthor, title, [year], price, idCategory, amount)
values
    ((select id from authors where name = N'Кент Дж.' ), 
    N'Решения без проблем на C++', 2011, 720, 
    (select id from categories where category = N'монография'), 
    3);  
        
-- С использованием подзапросами
-- Удалить монографию автора Кент Дж. с названием "Решения без проблем на C++",
-- 2011 года издания, стоимостью 720 р., количеством 3 экземпляра
delete from
    Books
where
    idAuthor = (select id from authors where name = N'Кент Дж.' ) and 
    title = N'Решения без проблем на C++' and
    [year] = 2011 and
    price = 720 and
    idCategory = (select id from categories where category = N'монография');