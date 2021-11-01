-- пример создания таблицы и ее заполнение
CREATE TABLE [dbo].[NewBooks]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1), 
    [Author] NVARCHAR(60) NOT NULL, 
    [Title] NVARCHAR(150) NOT NULL, 
    [Publication] INT NOT NULL, 
    [Price] INT NOT NULL, 
    [Category] NVARCHAR(20) NOT NULL, 
    CONSTRAINT [CK_NewBooks_Publication] CHECK (Publication > 1990), 
    CONSTRAINT [CK_NewBooks_Column] CHECK (Price > 0)
)
go  -- без этого таблица не создавалась...

drop table [NewBooks]

insert into NewBooks
    (Author, Title, Publication, Price, Category)
values
    (N'Абрамян М.Э.', N'1000 задач по программированию', 2002, 100, N'задачник'),
    (N'Лукаш Т.Е.', N'NodeJS для серверов', 2016, 800, N'учебник'),
    (N'Аскольдиков Б.Н.', N'Apache 2.4 - оптимизация', 2012, 400, N'монография'),
    (N'Борисова Р.К.', N'Практикум STL для C++17', 2018, 700, N'задачник');
go