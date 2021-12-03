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
declare @amountYear int = 3;

select
	*
from
	ViewFilms
where
	DateDiff(year, ViewFilms.ReleaseDate, GetDate()) > @amountYear;
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
drop function if exists AmountActorsFilm;
go

create function AmountActorsFilm (@film nvarchar(120))
	returns int
	begin
		return (select count(*) from ViewActorsOfFilm where ViewActorsOfFilm.FilmTitle = @film);
	end
go

-- название фильма
declare @film nvarchar(120) = N'Доктор Лиза';

-- получение результата
declare @amount int = dbo.AmountActorsFilm(@film);

print (char(10) +
	   char(9)  + N'Количество актёров в фильме "' + @film + '": ' + ltrim(str(@amount)) +
	   char(10));
go


-- Скалярная функция. Вывести суммарный бюджет фильмов заданного режиссера.
drop function if exists BudgetFilmsProducer;
go

create function BudgetFilmsProducer (@lastName nvarchar(60), @firstName nvarchar(60), @patronymic nvarchar(80), @dateOfBirth date)
	returns int
	begin
		-- id режмесёра 
		declare @Id int = (select ViewProducers.Id from ViewProducers where ViewProducers.LastName = @lastName and
																		   ViewProducers.FirstName = @firstName and
																		   ViewProducers.Patronymic = @patronymic and
																		   ViewProducers.DateOfBirth = @dateOfBirth);

		return (select Sum(Films.Budget) from Films where Films.IdProducer = @Id);
	end
go

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

