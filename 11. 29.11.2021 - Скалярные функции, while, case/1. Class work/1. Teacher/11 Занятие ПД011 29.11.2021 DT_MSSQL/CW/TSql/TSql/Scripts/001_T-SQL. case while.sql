-- управляющие операторы - продолжение


/* оператор множественного выбора в выражениях */
/*
1-я форма, фиксированное значение выражения в case, фиксированные значениЯ
           перечисляются в when
set @имяПеременной1 = case выражение
                       when результат1 then значение1
					   when результат2 then значение2
					   ...
					   when результатN then значениеN
					   else ещеОдноЗначение
                   end 
*/
declare @a int
declare @description nvarchar(50)
set @a = 1 + 6*rand();
set @description = case @a
                       when 1 then N'плохо'
					   when 2 then N'неудовлетворительно'
					   when 3 then N'удовлетворительно'
					   when 4 then N'хорошо'
					   when 5 then N'отлично'
					   else N'невероятно круто'
                   end;

print char(10) + char(9) + N'оценка ' + str(@a, 2) + N' - описание: ' + @description;
go

-- select surnameNp, case owner when 0 then 'доверенность' when 1 then 'владелец' end;

/* 2-я форма, условие в when
set @имЯПеременной1 = case 
                       when условие1 then значение1
					   when условие2 then значение2
					   ...
					   when условиеN then значениеN
					   else ещеОдноЗначение
                   end 
*/
declare @temperature int = -50 + 100*rand();
declare @description1 nvarchar(50)
set @description1 = case
                       when @temperature between -40 and -11  then N'холодно...'
                       when @temperature between -10 and   0  then N'холодновато...'
					   when @temperature between   1 and  10  then N'прохладно'
					   when @temperature between  11 and  25  then N'тепло'
					   when @temperature between  26 and  35  then N'жарко'
					   when @temperature between  36 and  46  then N'Африка'
					   else N'это не Земля'
                   end
print char(10) + char(9) + N'температура ' + str(@temperature, 3) + N' - описание: ' + @description1;
go

/* 

  оператор повторения
  while условиеПродолжения 
      операторТелаЦикла

  могут быть вложенные циклы

  оператор продолжения - передача управления на условие продолжения
  цикла
  continue

  оператор прерывания - выход из текущего цикла
  break

  оператор безусловного перехода
  goto

  Метка:
     оператор1
	 ...
	 операторN
	 goto Метка

*/

--  пример на оператор повторения
declare @str nvarchar(80) = N'';

declare @i int = 1 
while @i <= 10 begin
	
    if @i %2 = 0 begin
		set @i += 1;  -- очень важно, для выхода из цикла
		continue;
	end;
	
	if @i = 7 break;

    -- convert(тип, выражение) - преобразовать значение выражения в заданный тип
    set @str += convert(nvarchar, @i) + ' ';
    set @i += 1;
end;	 
print char(10) + char(9) + @str + char(10);
go

-------------------------------------------------
 
-- пример на case с константной в части when 
-- Start:  -- метка, на которую возможен переход по goto
-- более сложный пример - большое тело цикла
declare @code   int = 1                -- код веса
declare @weight float = 10000*rand()   -- вес для преобразования
declare @kylos  float
declare @k      float;   -- коэффициент пересчета для веса в кг

while @code <= 5 begin

    -- пример на break - @code > 3 выход из цикла 
	-- if @code > 3 break;

	-- пример на continue - пропускать четные коды единиц измерения веса
	-- if @code % 2 = 0 begin
	--     set @code += 1
	--    continue
    -- end;
  
    -- определение коэффициента пересчета в кг
	set @k = case @code 
		when 1 then 1e-6  -- мг в кг
		when 2 then 1e-3  -- г в кг
		when 3 then 1     -- кг в кг, преобразование не требуется 
		when 4 then 1e2   -- ц в кг
		when 5 then 1e3   -- т в кг
	end;   

	-- пересчет веса в кг 
    set @kylos = @weight * @k;

	-- словесное описание кода веса
	declare @descr nvarchar(10) = case @code
		when 1 then N'мг'
		when 2 then N'г'
		when 3 then N'кг'
		when 4 then N'ц'
		when 5 then N'т'
	end;

	print convert(nvarchar, @weight) + ' ' + @descr + char(9) +
		  N' это ' + char(9) + convert(nvarchar, @kylos) + N' кг';
    set @code += 1;
end
-- goto Start
go


-- пример на case с выражением в части when
declare @nomHour int = 0; -- час
print '';

Loop:
   
	declare @timesOfDay nvarchar(50) = case 
		when  @nomHour between  0 and  3 then N'ночь'
		when  @nomHour between  4 and 11 then N'утро'
		when  @nomHour between 12 and 17 then N'день'
		when  @nomHour between 18 and 23 then N'вечер'
		else  N'на этой планете в сутках 24 часа'
	end;
	print char(9) + N'Время суток для часа с номером ' + convert(nvarchar, @nomHour) + ': ' + @timesOfDay;
	
	-- увеличить час, перейьти к следующйей итерации
	set @nomHour += 4;
	if (@nomHour <= 23) goto Loop;
	
-- для вывода одного символа'  выводим его дважды
print char(10) + char(9) + N'Все, that''s all, falks!';
go