-- Задача 1
-- Дано случайное целое число от 1 до 12
-- Для этого числа вывести название месяца, используя оператор case 
-- с фиксированными значениями 

print char(9) + N'Задача 1'
declare @nomMonth int = 1 + 11*rand(); -- случайное число от 1 до 12 - номер месяца
declare @nameMonth nvarchar(50) = case @nomMonth
    when  1 then N'январь'
	when  2 then N'февраль'
	when  3 then N'март'
    when  4 then N'апрель'
	when  5 then N'май'
	when  6 then N'июнь'
    when  7 then N'июль'
	when  8 then N'август'
	when  9 then N'сентябрь'
    when 10 then N'октябрь'
	when 11 then N'ноябрь'
	when 12 then N'декабрь'
end;
print char(9) + N'Название месяца с номером ' + convert(nvarchar, @nomMonth) + ': ' + @nameMonth;
go

-- Задача 2
-- Для случайного числа в диапазоне от 1 до 12
-- при помощи case с условием вывести название времени года (1, 2, 12 - это зима
-- 3, 4, 5 - это весна, ...)
declare @nomMonth int = 1 + 11*rand(); -- случайное число от 1 до 12 - номер месяца
print char(10) + char(9) + N'Задача 2';

declare @nameSeason nvarchar(50) = case 
    when  @nomMonth between 3 and 5 then N'весна'
	when  @nomMonth between 6 and 8 then N'лето'
	when  @nomMonth between 9 and 11 then N'осень'
    else N'зима'
end;
print char(9) + N'Время года для месяца с номером ' + convert(nvarchar, @nomMonth) + ': ' + @nameSeason;
go

-- Задача 3
-- Для случайного числа в диапазоне от 0 до 23
-- при помощи case с условием вывести название времени суток
--  0 ...  3 ночь
--  4 ... 11 утро
-- 12 ... 17 день
-- 18 ... 23 вечер
print char(10) + char(9) + N'Задача 3'
declare @nomHour int = 23*rand(); -- час, случайное число от 0 до 23

declare @timesOfDay nvarchar(50) = case 
    when  @nomHour between  0 and  3 then N'ночь'
	when  @nomHour between  4 and 11 then N'утро'
	when  @nomHour between 12 and 17 then N'день'
	when  @nomHour between 18 and 23 then N'вечер'
end;

print char(9) + N'Время суток для часа с номером ' + convert(nvarchar, @nomHour) + ': ' + @timesOfDay;
go


-- Задача 4
-- Заменить английские названия цветов (только четыре, остальные варианты 
-- заменяем словом "белый",
-- red, green, blue, black), при помощи case с фиксированными значениями
print char(10) + char(9) + N'Задача 5'
declare @enColor nvarchar(20) = N'yet', @ruColor nvarchar(20);

set @ruColor = case @enColor
	when N'red'   then N'красный'
	when N'green' then N'зеленый'
	when N'blue'  then N'синий'
	when N'black' then N'черный'
	else N'белый'
end;

print char(9) + N'Цвету "' + @enColor + N'" в английском языке соответствует цвет "' + 
      @ruColor + N'" в русском языке ';
go