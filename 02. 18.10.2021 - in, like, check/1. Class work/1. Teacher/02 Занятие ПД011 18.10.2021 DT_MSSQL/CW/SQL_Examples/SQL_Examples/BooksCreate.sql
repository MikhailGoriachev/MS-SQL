CREATE TABLE [dbo].[Books]
(
	[Id] INT NOT NULL PRIMARY KEY Identity,
    [Title]   NVARCHAR (80) NOT NULL,
    Author    NVARCHAR (60) NOT NULL
                        DEFAULT ('Иванов И.И.'),
    [Public] INT        CHECK ([Public] > 2000) 
                        NOT NULL,
    Price    INT      CHECK (Price > 0) 
)
