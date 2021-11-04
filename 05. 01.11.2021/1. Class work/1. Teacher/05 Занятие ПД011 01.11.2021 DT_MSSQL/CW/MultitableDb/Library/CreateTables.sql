-- создание таблицы авторов
CREATE TABLE [dbo].[Authors] (
    [Id]       INT           IDENTITY (1, 1) NOT NULL,
    [FullName] NVARCHAR (70) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

-- создание таблицы книг
CREATE TABLE [dbo].[Books] (
    [Id]         INT            IDENTITY (1, 1) NOT NULL,
    [IdAuthor]   INT            NOT NULL,
    [IdCategory] INT            NOT NULL,
    [Title]      NVARCHAR (150) NOT NULL,
    [PubYear]    INT            NOT NULL,
    [Price]      INT            NOT NULL,
    [Amount]     INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Books_Authors] FOREIGN KEY ([IdAuthor]) REFERENCES [dbo].[Authors] ([Id]),
    CONSTRAINT [FK_Books_Categories] FOREIGN KEY ([IdCategory]) REFERENCES [dbo].[Categories] ([Id]),
    CONSTRAINT [CK_Books_Column] CHECK ([PubYear]>(1960)),
    CONSTRAINT [CK_Books_Price] CHECK ([Price]>(0)),
    CONSTRAINT [CK_Books_Amount] CHECK ([Amount]>=(0))
);

-- создание таблицы категорий
CREATE TABLE [dbo].[Categories] (
    [Id]       INT           IDENTITY (1, 1) NOT NULL,
    [Category] NVARCHAR (20) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);
