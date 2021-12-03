/*
    Объединение результатов запросов применяется в том случае если необходимо получить 
    совокупность строк двух и более запросов, которые выполняются независимо друг от друга
    
    Для того чтобы результаты запросов можно было объединить они должны соответствовать 
    определенным условиям совместимости:
         ■ количество столбцов в каждом запросе должно быть одинаковым;
         ■ типы данных соответствующих столбцов во всех запросах должны 
           быть совместимы
    
    Также при объединении запросов существует ряд особенностей:
         ■ в результирующем наборе, полученном при объединении, будут использоваться имена 
           столбцов, которые были указаны в первом запросе;
         ■ нельзя сортировать каждый запрос по отдельности, осуществить сортировку можно 
           только всего составного запроса, указав по его окончанию оператор ORDER BY

     Для объединения запросов применяются ключевые слова union, union all
*/

-- Ключевое слово UNION позволяет объединить результаты запросов и
-- применяется в том случае, когда в результирующем наборе необходимо 
-- исключить повторяющиеся строки

-- объединение таблиц риэлторов и клиентов
select
    Persons.Surname + N' ' + Substring(Persons.[Name], 1, 1) + N'.' +  + Substring(Persons.Patronymic, 1, 1)  + N'.'
                     as FullName
   , N'владелец'    as [Role]
from
    Owners join Persons on Owners.IdPerson = Persons.Id

union

select
    Persons.Surname + ' ' + Substring(Persons.[Name], 1, 1) + '.' + Substring(Persons.Patronymic, 1, 1) + '.'
    , N'риэлтор' 
from
    Realtors join Persons on Realtors.IdPerson = Persons.Id


order by 
    -- [Role];
    FullName;
go

-- Ключевое слово UNION ALL также позволяет объединять результаты различных запросов, 
-- однако выполняется быстрее, чем UNION, потому что не тратит время на удаление дублирующих 
-- строк в объединяемых запросах

-- объединение таблиц риэлторов и клиентов
select
    Persons.Surname + N' ' + Substring(Persons.[Name], 1, 1) + N'.' +  + Substring(Persons.Patronymic, 1, 1)  + N'.'
                     as FullName
    , N'владелец'    as [Role]
from
    Owners join Persons on Owners.IdPerson = Persons.Id

union all

select
    Persons.Surname + ' ' + Substring(Persons.[Name], 1, 1) + '.' + Substring(Persons.Patronymic, 1, 1) + '.'
    , N'риэлтор' 
from
    Realtors join Persons on Realtors.IdPerson = Persons.Id

order by 
    [Role];
go

-- Объединение результатов запросов можно также применять, в том случае если необходимо 
-- получить сводную информацию из различных SQL-запросов, которые связаны между собой 
-- определенным критерием 

-- union в этом случае сортирует выход объединения, union all - не сортирует

-- средняя цена квартир и средняя цена сделок, сумма сделок в базе данных
select
    N'Средняя предложенная цена квартиры' as Title
    , AVG(Offers.Price) as Price
from
    Offers

union all

select 
    N'Средняя сумма сделки'
    , AVG(Deals.DealPrice)
from
    Deals
    
union all

select
    N'Всего сумма по сделкам в базе'
    , SUM(Deals.DealPrice)
from
    Deals

union all

select
    N'Всего квартир на учете'
    , COUNT(Apartments.Id)
from
    Apartments;

go