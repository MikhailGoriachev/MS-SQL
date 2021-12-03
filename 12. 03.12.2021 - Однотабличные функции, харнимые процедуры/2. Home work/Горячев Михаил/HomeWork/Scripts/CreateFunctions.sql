-- Скалярная функция. Вывести количество актеров в заданном по названию фильме.
create function AmountActorsFilm (@film nvarchar(120))
	returns int
	begin
		return (select count(*) from ViewActorsOfFilm where ViewActorsOfFilm.FilmTitle = @film);
	end
go

-- Скалярная функция. Вывести суммарный бюджет фильмов заданного режиссера.
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
