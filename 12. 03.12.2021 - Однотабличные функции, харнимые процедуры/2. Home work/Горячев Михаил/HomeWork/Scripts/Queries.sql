-- Вывести все фильмы, вышедшие на экран в текущем и прошлом году.
declare @currentYear int = Year(GetDate());
declare @previewYear int = @currentYear - 1;

select
	*
from
	ViewFilms
where
	Year(ViewFilms.ReleaseDate) between @previewYear and @currentYear;
go


-- Вывести информацию об актерах, снимавшихся в заданном фильме.
declare @film nvarchar(120) = N'Конференция';

select
	*
from
	ViewActorsOfFilm
where
	ViewActorsOfFilm.FilmTitle = @film;
go


-- Вывести информацию об актерах, снимавшихся как минимум в N фильмах.
declare @amountFilms int = 3;

select
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


-- Вывести информацию об актерах, которые были режиссерами хотя бы одного из фильмов.
select
	ViewActors.Id
	, ViewActors.LastName
	, ViewActors.FirstName
	, ViewActors.Patronymic
from
	ViewActors inner join (Actors inner join 
							(Persons inner join Producers on Persons.Id = Producers.IdPerson) on Actors.IdPerson = Persons.Id)
					on ViewActors.Id = Actors.Id


-- Вывести все фильмы, дата выхода которых была более заданного числа лет назад.
declare @year int = 2015;

select
	*
from
	ViewFilms
where
	Year(ViewFilms.ReleaseDate) > @year;
go


-- Вывести всех актеров и количество фильмов, в которых они участвовали.
select distinct
	ViewActors.Id
	, ViewActors.LastName
	, ViewActors.FirstName
	, ViewActors.Patronymic
	, (select Count(*) from ActorsOfFilm where ActorsOfFilm.IdActor = ViewActors.Id) as AmountFilms
from
	ViewActors left join ActorsOfFilm on ViewActors.Id = ActorsOfFilm.IdActor
go


-- Скалярная функция. Вывести количество актеров в заданном по названию фильме.

-- название фильма
declare @film nvarchar(120) = N'Доктор Лиза';

-- получение результата
declare @amount int = dbo.AmountActorsFilm(@film);

print (char(10) +
	   char(9)  + N'Количество актёров в фильме "' + @film + '": ' + ltrim(str(@amount)) +
	   char(10));
go


-- Скалярная функция. Вывести суммарный бюджет фильмов заданного режиссера.

-- режисёр
declare @producerLastName   nvarchar(60) = N'Астафьева';
declare @producerFirstName  nvarchar(60) = N'Дарья';
declare @producerPatronymic nvarchar(80) = N'Алексеевна';
declare @producerDateOfBirth date		 = N'1990/12/12';

-- получение результата
declare @sum int = dbo.BudgetFilmsProducer(@producerLastName, @producerFirstName, @producerPatronymic, @producerDateOfBirth);

print (char(10) +
	   char(9)  + N'Сумма бюджета фильмов режисера ' + @producerLastName + ' ' + @producerFirstName + ' ' + @producerPatronymic + ': ' + ltrim(str(@sum)) +
	   char(10));
go

