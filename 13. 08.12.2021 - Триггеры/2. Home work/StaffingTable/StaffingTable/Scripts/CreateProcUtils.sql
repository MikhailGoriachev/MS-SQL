
-- процедура для вывода таблицы Copy_Devisions
drop proc if exists ShowCopy_Devisions;
go

create proc ShowCopy_Devisions
as
	begin
		select 
			Copy_Devisions.Id
			, Copy_Devisions.Title
			, DevisionTypes.Title as DevisionType
			, Copy_Devisions.InterestAllowancetOne
		from 
			Copy_Devisions inner join DevisionTypes on Copy_Devisions.IdDevisionType = DevisionTypes.Id; 
	end;
go
