/* 

SQL (Structured Query Language):
   DML - Data Manipulation Language 
         операторы выбора и изменения данных
         
   DDL - Data Definition Language
         создание и изменение БД, таблиц 

   DCL - Data Control Language
         управление доступом к данным
   
*/

/* блочный комментарий */
-- строчный комментарий 

select
   42 as 'Ответ'; 

select
  1 + 1 + 5 + 7 + 150 + 253 + 120 + 10 as 'сумма на вечеринку';

-- операции над данными
-- + - * /  конкатенация строк +
  
 -- примеры запросов не к таблицам базы данными 
select 
   -3*3 as prod;
  
select
  N'привет, ' + N'мир SQL' as result; 

-- объединение запросов - union all, количество полей у объединяемых запросов
-- должно быть одинаковым  
select                    /* первый запрос - вертикальный стиль размещения полей */
   2   as oper1, 
   '+' as operation,
   2   as oper2, 
   2+2 as result, 
   N'сумма' as comment
   
union all  -- объединение запроса

select     /* второй запрос - горизонтальный стиль размещения полей */
   2, '-', 2, 2-2, N'разность' 
   
union all

select
   3
   , '*'
   , 4
   , 3*4
   , N'произведение'
;  

-- Запросы к базе данных

-- выбрать все поля всех записей из таблицы Persons
select * from Persons;

-- выбрать все поля всех записей из таблицы Cities
select
    *
from
    Cities;    

-- выбрать поля SurnameNP, Age всех записей таблицы Persons   
select
      Fullname     
    , Age   -- стиль MS SQL
from
     Persons;  
     
 -- вывести только названия городов из таблицы Cities
select 
    [Name] 
from 
    Cities;
        
    
-- операторы для сравнения 
--    < <= = != <> >= >
--      !>         !< 
--    between lowBound and highBound 
--    in, like
-- есть также not, or, and

-- выбрать поля SurnameNP, Age записей таблицы Persons
-- у которых возраст между 30 и 35	
SELECT
    Fullname
    , Age
FROM
    Persons
WHERE
    30 <= Age and Age <= 35 
    -- Age between 30 and 35       
;

-- выбрать поля SurnameNP, Age записей таблицы Persons
-- у которых возраст равен 33	    
select
    Fullname
    , Age
from
    Persons
where
    Age != 33        
;
   

-- выбрать поля SurnameNP, Age записей таблицы Persons
-- у которых возраст 22 года, 33 года или 55 лет (оператор in)
select
    Fullname
    , Age
from
    Persons
where
    -- Age = 34 or Age = 56 or Age = 42
    Age in (34, 56, 42)
;

select
    Fullname
    , Age
from
    Persons
where
    -- Age = 34 or Age = 56 or Age = 42
    Age not in (34, 56, 42)
;
  
-- выбрать поля Fullname, Age записей таблицы Persons
-- у которых фамилия начинается со строки Федоров	  
select
    Fullname
    , Age
from
    Persons
where
    -- like: _ один любой символ, % - произвольное
    Fullname like N'Федоров%'
;        

select
    Fullname
    , Age
from
    Persons
where
    -- like: _ один любой символ, % - произвольное
    Fullname not like N'Федоров%'
;       