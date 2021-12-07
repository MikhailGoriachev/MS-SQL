-- Разработайте запросы в виде однотабличных функций, проверьте их 
-- работу на трех наборах параметров (первый запрос, естественно,  
-- без параметров):

-- •	Вывести все фильмы, вышедшие на экран в текущем и прошлом 
--		году.

-- удаление функции
drop function if exists FilmsCurrentAndLastYear;
go

-- создание функции
create function FilmsCurrentAndLastYear()
	returns table
	as
	return
		select
			*
		from
			ViewFilms
		where
			Year(ViewFilms.ReleaseDate) between Year(GetDate()) - 1 and Year(GetDate());
		go
	go

-- демонстрация работы (один запрос, так как запрос без параметров)
select * from FilmsCurrentAndLastYear();


-- •	Вывести информацию об актерах, снимавшихся в заданном   
--		фильме.

-- удаление функции
drop function if exists SelectFilmActors;
go

-- создание функции
create function SelectFilmActors(@film nvarchar(120))
	returns table
	as 
	return
		select
			*
		from
			ViewActorsOfFilm
		where
			ViewActorsOfFilm.FilmTitle = @film;
		go
	go

-- демонстрация работы
select * from SelectFilmActors(N'Конференция');		-- 1 запрос
select * from SelectFilmActors(N'Спутник');			-- 2 запрос
select * from SelectFilmActors(N'Керосин');			-- 3 запрос


-- •	Вывести информацию об актерах, снимавшихся как минимум в   
--		N фильмах.

-- удаление функции 
drop function if exists ActorsAmountFilm;
go;

-- создание функции
create function ActorsAmountFilm(@amountFilms int)
	returns table
	as
	return
		select TOP(select count(*) from ViewActors)
			ViewActors.Id
			, ViewActors.LastName
			, ViewActors.FirstName
			, ViewActors.Patronymic
			, (select Count(*) from ActorsOfFilm where ActorsOfFilm.IdActor = ViewActors.Id) as AmountFilms
		from
			ViewActors
		where
			(select Count(*) from ActorsOfFilm where ActorsOfFilm.IdActor = ViewActors.Id) >= @amountFilms
		order by
			AmountFilms desc;
		go
	go

-- демонстрация работы функции
select * from ActorsAmountFilm(2);	-- 1 запрос
select * from ActorsAmountFilm(4);	-- 2 запрос
select * from ActorsAmountFilm(5);	-- 3 запрос


-- Разработайте запросы в виде хранимых процедур, проверьте их   
-- работу на трех наборах параметров (последний запрос, естественно,  
-- без параметров):

-- •	Вывести информацию об актерах, которые были режиссерами   
--		хотя бы одного из фильмов.

-- удаление процедуры 
drop proc if exists ActorsProducer;
go

-- создание процедуры
create proc ActorsProducer
as
	begin
		select
			ViewActors.Id
			, ViewActors.LastName
			, ViewActors.FirstName
			, ViewActors.Patronymic
		from
			ViewActors inner join (Actors inner join 
									(Persons inner join Producers on Persons.Id = Producers.IdPerson) 
										on Actors.IdPerson = Persons.Id)
							on ViewActors.Id = Actors.Id

	end;
go

-- демонстрация работы процедуры
exec dbo.ActorsProducer;
go


-- •	Вывести все фильмы, дата выхода которых была более заданного   
--		числа лет назад.

-- удаление процедуры
drop proc if exists FilmsOverAmountYear;
go

-- создание процедуры
create proc FilmsOverAmountYear
	@amountYear int
as 
	begin
		select
			*
		from
			ViewFilms
		where
			Year(ViewFilms.ReleaseDate) > @amountYear;
	end;
go

-- демонстрация работы процедуры
exec dbo.FilmsOverAmountYear  5;		-- 1 
exec dbo.FilmsOverAmountYear  2;		-- 2 
exec dbo.FilmsOverAmountYear 10;		-- 3 
go


-- •	Вывести всех актеров и количество фильмов, в которых они   
--		участвовали.

-- удаление процедуры
drop proc if exists ShowActorsAndAmountFilms;
go

-- создание процедуры
create proc ShowActorsAndAmountFilms
as
	begin
		select distinct
			ViewActors.Id
			, ViewActors.LastName
			, ViewActors.FirstName
			, ViewActors.Patronymic
			, (select Count(*) from ActorsOfFilm where ActorsOfFilm.IdActor = ViewActors.Id) as AmountFilms
		from
			ViewActors left join ActorsOfFilm on ViewActors.Id = ActorsOfFilm.IdActor
	end;
go

-- демонстрация работы процедуры
exec dbo.ShowActorsAndAmountFilms;
go
