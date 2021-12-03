-- удаление представлений
drop view if exists ViewProducers;
drop view if exists ViewActors;
drop view if exists ViewFilms;
drop view if exists ViewActorsOfFilm;
go

-- создание представления таблицы Producers		(Продюсеры)			
create view ViewProducers as
	select
		Producers.Id
		, Persons.LastName
		, Persons.FirstName
		, Persons.Patronymic
		, Persons.DateOfBirth
	from
		Producers inner join Persons on Producers.IdPerson = Persons.Id;
go


-- создание представления таблицы Actors		(Актёры)
create view ViewActors as 
	select
		Actors.Id
		, Persons.LastName
		, Persons.FirstName
		, Persons.Patronymic
		, Persons.DateOfBirth
	from
		Actors inner join Persons on Actors.IdPerson = Persons.Id;
go


-- создание представления таблицы Films			(Фильмы)
create view ViewFilms as 
	select
		Films.Id
		, Films.Title
		, ViewProducers.LastName
		, ViewProducers.FirstName
		, ViewProducers.Patronymic
		, Films.ReleaseDate
		, Films.Budget
		, Genres.Genre
		, Countries.Country
	from
		Films inner join ViewProducers on Films.IdProducer = ViewProducers.Id
			  inner join Genres		   on Films.IdGenre	   = Genres.Id
			  inner join Countries	   on Films.IdCountry  = Countries.Id;
go


-- создание представления таблицы ActorsOfFilm	(Актёры фильмов)
create view ViewActorsOfFilm as
	select
		ActorsOfFilm.Id
		, Films.Title as FilmTitle
		, Films.ReleaseDate as FilmRelease
		, ViewActors.LastName
		, ViewActors.FirstName
		, ViewActors.Patronymic
		, ViewActors.DateOfBirth
	from
		ActorsOfFilm inner join Films		on ActorsOfFilm.IdFilm	= Films.Id
				     inner join ViewActors	on ActorsOfFilm.IdActor = ViewActors.Id;
go