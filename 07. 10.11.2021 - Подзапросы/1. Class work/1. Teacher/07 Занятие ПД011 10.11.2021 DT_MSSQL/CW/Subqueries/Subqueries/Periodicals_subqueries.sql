-- База данных «Учет подписки на периодические печатные издания»

-- Вспомогательный запрос - создание таблицы :)
-- Создает копию таблицы ПОДПИСЧИКИ с именем КОПИЯ_ПОДПИСЧИКИ		
drop table if exists Copy_Subscribers; 

-- создать новый вариант таблицы Copy_Subscribers
select
    *
    into Copy_Subscribers
from
    Subscribers;

-- показать выбранные в таблицу Copy_Subscribers данные 
select * from Copy_Subscribers;
go


-- Запрос на удаление	
-- Удаляет из таблицы КОПИЯ_ПОДПИСЧИКИ записи, в которых значение в поле Улица 
-- равно «Садовая»
-- показать таблицу Copy_Subscribers до удалания записей 
declare @street nvarchar(30)=N'ул. Садовая';

-- покажем улицы, которые есть в таблице-копии до удаления
select distinct
    Copy_Subscribers.Id
    , Streets.Street 
from 
    Copy_Subscribers join Streets on Copy_Subscribers.IdStreet = Streets.Id;


-- удаление по заданию с использованием подзапроса
delete from 
    Copy_Subscribers
where
    --                           подзапрос, возвращает идентификатор улицы @street
    Copy_Subscribers.IdStreet = (select Id from Streets where Street = @street);  

-- показать таблицу Copy_Subscribers после удалания записей
select distinct
    Copy_Subscribers.Id
    , Streets.Street 
from 
    Copy_Subscribers join Streets on Copy_Subscribers.IdStreet = Streets.Id;
go


-- 13 Запрос на обновление	
-- Увеличивает значение в поле Цена 1 экземпляра таблицы ИЗДАНИЯ на заданное 
-- параметром количество процентов для изданий, заданного параметром вида издания
declare @percent float=10, @pubType nvarchar(30)=N'газета';

-- выведем данные до изменения
select
    Publications.Title
    , Publications.Price
    , PubTypes.PubType
from
    Publications join PubTypes on Publications.IdPubType = PubTypes.Id
where
    PubTypes.PubType = @pubType;

-- выполнить модификацию цены для заданного вида издания
update 
    Publications
set
    Price *= ((100 + @percent)/100)
where
    --                        подзапрос, возвращает идентификатор типа издания
    Publications.IdPubType = (select 
                                  Id 
                              from 
                                  PubTypes 
                              where 
                                  PubType = @pubType);

-- данные после изменения цены
select
    Publications.Title
    , Publications.Price
    , PubTypes.PubType
from
    Publications join PubTypes on Publications.IdPubType = PubTypes.Id
where
    PubTypes.PubType = @pubType;
go    
