drop view if exists ViewBrands; 
go
drop view if exists ViewColors; 
go
drop view if exists ViewClients; 
go
drop view if exists ViewCars; 
go
drop view if exists ViewRentals; 
go


-- создание представления таблицы Brands (Модели_автомобилей)
create view ViewBrands as
	select
		Brands.Id
		, Brands.Brand
	from
		Brands;
go

-- создание представления таблицы Colors (цвета)
create view ViewColors as 
	select
		Colors.Id
		, Colors.Color
	from
		Colors;
go


-- создание представления таблицы Clients (Клиенты)
create view ViewClients as 
	select
		Clients.Id
		, Clients.Surname
		, Clients.[Name]
		, Clients.Patronymic
		, Clients.Passport
	from
		Clients;
go


-- создание представления таблицы Cars (Машины)
create view ViewCars as 
	select
		Cars.Id
		, Brands.Brand
		, Colors.Color
		, Cars.Plate
		, Cars.YearManuf
		, Cars.InshurancePay
		, Cars.Rental
	from
		Cars inner join Brands on Cars.IdBrand = Brands.Id
			 inner join Colors on Cars.IdColor = Colors.Id;
go


-- создание представления таблицы Rentals (Факты_проката)
create view ViewRentals as 
	select
		Rentals.Id
		, Clients.Surname
		, Clients.[Name]
		, Clients.Patronymic
		, Clients.Passport
		, Brands.Brand
		, Colors.Color
		, Cars.Plate
		, Cars.YearManuf
		, Cars.InshurancePay
		, Cars.Rental
		, Rentals.DateStart
		, Rentals.Duration
	from
		Rentals inner join Clients on Rentals.IdClient = Clients.Id
			    inner join (Cars inner join Brands on Cars.IdBrand = Brands.Id
								 inner join Colors on Cars.IdColor = Colors.Id)
					on Rentals.IdCar = Cars.Id;
go
