/* 

  Триггеры
  Программный блок, сраб. по определенному событию, связанному с обработкой данных
  Также есть триггеры, срабатывающие на изменение разрешений безопасности
  
  2 группы триггеров данных
  ☼ instead of - перед каким-то действием / вместо какого-то действия 
  ☼ after/for  - после какого-то действия
  
  3 действия на которые настраиваются триггеры данных 
  ☼ insert
  ☼ update
  ☼ delete

  Операции с триггерами
  ☼ создание    create trigger
  ☼ изменение   alter  trigger
  ☼ удаление    drop   trigger
  
  ограничения для триггеров
  ► триггеры не создаются для временных таблиц
  ► у триггеров нет параметров
  ► триггеры нельзя вызвать явно
  ► нельзя вернуть значения из триггера
  ► в таблице м.б. только один триггер instead of
  ► в триггере нельзя использовать операции
    drop, create, alter database, alter table, select into,
    grant, revoke

  Синтаксис создания
  create trigger имяТриггера on имяТаблицы
      {after | for | instead of} {insert | delete | update}
	  with encryption
	  as
	  операторыТриггера 

  Синтаксис изменения
  alter trigger имяТриггера on имяТаблицы
      {after | for | instead of} {insert | delete | update}
	  with encryption
	  as
	  операторыТриггера 

  Синтаксис удаления
  drop trigger имяТриггера

  drop trigger onUpdate

-- триггер, срабатывающий на изменение таблицы
-- @@rowcount - количество строк, затронутых операцией
create trigger onUpdate on Books 
    for update 
	as
	raiserror('onUpdate: В таблице Books изменено записей: %d', 0, 1, @@rowcount);

  -- проверочный запрос для триггера
	 update Books
	 set Amount += 2
	 where Price < 500;

*/

drop trigger if exists onUpdate
drop trigger if exists onDelete
go

-- триггер, срабатывающий на изменение таблицы
-- @@rowcount - количество строк, затронутых операцией
-- При срабатывании триггера можно использовать две виртуальные таблицы: 
--      inserted хранит значения строк после обновления 
--      deleted хранит те же строки, но до обновления
alter trigger onUpdate on Books 
    for update 
	as
	begin
	    raiserror('Триггер onUpdate: В таблице Books изменено записей: %d', 0, 1, @@rowcount);
	end;	
go

-- проверочный запрос для триггера
update 
    Books
set 
    Amount += 2
where 
    Price < 500;
go


-- триггер на удаление записей из таблицы
-- книги Абрамяна М.Э. не удалять
create trigger onDelete on Books
    for delete
	as
	begin
	    -- подсчитать количество удаленных записей
		-- deleted: системная таблица, хранящая удаленные записи до завершения транзакции
		declare @counter int;
		select @counter = count(*) from deleted;
		print N'Запрос на удаление ' + convert(nvarchar, @counter) + N' зап.';
		
		-- проверка наличия среди удаляемых книг Абрамяна М.Э.
		declare @name nvarchar(70) = N'';
		select 
		    @name = Authors.FullName 
		from 
		    deleted join Authors on deleted.IdAuthor = deleted.IdAuthor
		where 
		    Authors.FullName = N'Абрамян М.Э.';  

		-- среди удаляемых есть книга Абрамяна М.Э. 
		if @name != N'' begin
			print N'Абрамяна не удалить!';
			-- откат транзакции
		    -- rollback transaction;
		    rollback tran;
		end else begin
		    raiserror(N'Удаляем %d записей', 0, 1, @counter);
		end;
    end;
		
go

-- тестовый запрос для удаления записей о книгах Абрамяна М.Э.
delete from  
    Books
where
    IdAuthor = (
	   select 
	       Authors.Id 
	   from 
	       Authors
       where
	       Authors.FullName = N'Абрамян М.Э.'
	);
go
