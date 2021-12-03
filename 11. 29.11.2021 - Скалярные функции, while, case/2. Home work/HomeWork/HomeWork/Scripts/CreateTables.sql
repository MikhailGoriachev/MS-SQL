-- удаление таблиц
drop table if exists ActorsOfFilm;
drop table if exists Films;
drop table if exists Actors;
drop table if exists Producers;
drop table if exists Persons;
drop table if exists Genres;
drop table if exists Countries;


-- создание таблицы	Countries		(Страны)				
create table dbo.Countries (
	Id			int					not null		primary key identity,
	Country		nvarchar(80)		not null,			-- Название страны
	constraint UQ_Countries_Country unique(Country)		-- ограничение на уникальность названия страны
);


-- создание таблицы	Genres			(Жанры)
create table dbo.Genres (
	Id			int					not null		primary key identity,
	Genre		nvarchar(80)		not null,			-- Название жанра
	constraint UQ_Genres_Genre unique(Genre)			-- ограничение на уникальность названия жанра
);


-- создание таблицы	Persons			(Персоны)
create table dbo.Persons (
	Id				int					not null		primary key identity,
	LastName		nvarchar(60)		not null,		-- Фамилия
	FirstName		nvarchar(60)		not null,		-- Имя
	Patronymic		nvarchar(80)		not null,		-- Отчество
	DateOfBirth		date				not null,		-- Дата рождения
	constraint CK_Persons_DateOfBirths check (DateOfBirth between '1850/01/01' and GetDate())	-- ограничение по дате рождения
);


-- создание таблицы	Producers		(Продюсеры)
create table dbo.Producers (
	Id				int					not null		primary key identity,
	IdPerson		int					not null		-- Персона
	constraint FK_Prodecers_IdPerson foreign key (IdPerson) references Persons(Id)		-- внешний ключ фильма персоны
);


-- создание таблицы	Actors			(Актёры)
create table dbo.Actors (
	Id				int					not null		primary key identity,
	IdPerson		int					not null		-- Персона
	constraint FK_Actors_IdPerson foreign key (IdPerson) references Persons(Id)			-- внешний ключ фильма персоны
);


-- создание таблицы	Films			(Фильмы)
create table dbo.Films (
	Id				int					not null		primary key identity,
	Title			nvarchar(120)		not null,		-- Название
	IdProducer		int					not null,		-- Продюсер
	ReleaseDate		date				not null,		-- Дата выхода
	Budget			int					not null,		-- Бюджет фильма
	IdGenre			int					not null,		-- Жанр
	IdCountry		int					not null,		-- Старана
	constraint CK_Films_ReleaseDate		check (ReleaseDate > '1900/01/01'),
	constraint FK_Films_IdProducer		foreign key (IdProducer) references Producers(Id),
	constraint FK_Films_IdGenre			foreign key (IdGenre)	 references Genres(Id),
	constraint FK_Films_IdCountry		foreign key (IdCountry)	 references Countries(Id)
);


-- создание таблицы	ActorsOfFilm	(Актёры фильмов)
create table dbo.ActorsOfFilm (
	Id				int					not null		primary key identity,
	IdFilm			int					not null,		-- Фильм
	IdActor			int					not null,		-- Актёр
	constraint FK_ActorsOfFilm_IdFilm	foreign key (IdFilm)	references Films(Id),	-- внешний ключ фильма
	constraint FK_ActorsOfFilm_IdActor	foreign key (IdActor)	references Actors(Id)	-- внешний ключ акётра
);