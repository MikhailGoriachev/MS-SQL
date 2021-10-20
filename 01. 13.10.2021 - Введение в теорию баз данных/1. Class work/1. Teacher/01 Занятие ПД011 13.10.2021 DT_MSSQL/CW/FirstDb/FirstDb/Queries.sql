/* 
 * Пример запросов на языке SQL к таблице Persons
 *
 */

-- выбирает все столбцы всех записей таблицы Persons
-- (компактная форма записи запроса)
select * from Persons;

-- выбирает все столбцы всех записей таблицы Persons
-- (обычная форма записи запроса)
select
    * 
from 
    Persons;

-- выбирает заданные столбцы всех записей из таблицы Persons
select
   Id
   , Fullname
   , Salary
from
    Persons;


-- выбирает заданные столбцы тех записей из таблицы Persons,
-- в которых оклад больше 30000
select
   Id
   , Fullname
   , Salary
from
    Persons
where
    Salary > 30000;


-- выбирает заданные столбцы тех записей из таблицы Persons,
-- в которых возраст в диапазоне от 30 до 70 (включительно)
select
   *
from
    Persons
where
    Age between 30 and 70;