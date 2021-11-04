-- создание таблицы АВТОРЫ
CREATE TABLE [dbo].[Authors] (
    [Id]       INT           IDENTITY (1, 1) NOT NULL,  -- id
    [FullName] NVARCHAR (70) NOT NULL,                  -- Фамилия и инициалы автора
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

-- создание таблицы КНИГИ
CREATE TABLE [dbo].[Books] (
    [Id]         INT            IDENTITY (1, 1) NOT NULL,       -- Id
    [IdAuthor]   INT            NOT NULL,                       -- Id записи из таблицы АВТОРЫ
    [IdCategory] INT            NOT NULL,                       -- Id записи из таблицы КАТЕГОРИИ
    [Title]      NVARCHAR (150) NOT NULL,                       -- название книги
    [PubYear]    INT            NOT NULL,                       -- год издания
    [Price]      INT            NOT NULL,                       -- цена
    [Amount]     INT            NOT NULL,                       -- количество экземпляров книги
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Books_Authors] FOREIGN KEY ([IdAuthor]) REFERENCES [dbo].[Authors] ([Id]),               -- внешний ключ к полю IdAuthor
    CONSTRAINT [FK_Books_Categories] FOREIGN KEY ([IdCategory]) REFERENCES [dbo].[Categories] ([Id]),       -- внешний ключ к полю IdCategory
    CONSTRAINT [CK_Books_Column] CHECK ([PubYear]>(1960)),
    CONSTRAINT [CK_Books_Price] CHECK ([Price]>(0)),
    CONSTRAINT [CK_Books_Amount] CHECK ([Amount]>=(0))
);

-- создание таблицы КАТЕГОРИИ
CREATE TABLE [dbo].[Categories] (
    [Id]       INT           IDENTITY (1, 1) NOT NULL,      -- Id
    [Category] NVARCHAR (20) NOT NULL,                      -- название категории книги
    PRIMARY KEY CLUSTERED ([Id] ASC)
);
