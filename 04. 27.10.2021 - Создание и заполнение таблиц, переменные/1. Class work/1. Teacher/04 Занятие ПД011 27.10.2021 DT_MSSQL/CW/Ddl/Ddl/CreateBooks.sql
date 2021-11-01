CREATE TABLE [dbo].[Books]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1), 
    [Author] NVARCHAR(60) NOT NULL, 
    [Title] NVARCHAR(150) NOT NULL, 
    [Publication] INT NOT NULL, 
    [Price] INT NOT NULL, 
    [Category] NVARCHAR(20) NOT NULL, 
    CONSTRAINT [CK_Books_Publication] CHECK (Publication > 1990), 
    CONSTRAINT [CK_Books_Column] CHECK (Price > 0)
)