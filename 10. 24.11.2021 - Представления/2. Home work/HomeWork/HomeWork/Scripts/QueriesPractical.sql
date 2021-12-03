-- 12	Изучение T-SQL	Задача If13. 
-- Даны три числа. Найти среднее из них (то есть число, расположенное между 
-- наименьшими наибольшим). Числа формируйте генератором случайных чисел

-- диапазон для генерации
declare @lo int = 5, @hi int = 15;

-- генерация трех чисел
declare @a int = (rand() * (@hi - @lo) + @lo), @b int = (rand() * (@hi - @lo) + @lo), @c int = (rand() * (@hi - @lo) + @lo);

-- среднее число
declare @avg int;

-- поиск среднего числа из трех чисел
if @a < @b and @b < @c or @a > @b and @b > @c 
begin
	set @avg = @b;
end else if @b < @a and @a < @c or @b > @a and @a > @c
begin
	set @avg = @a;
end else 
begin
	set @avg = @c;
end

-- вывод чисел и результата
print(char(10) +
	  char(9) + N'12. Изучение T-SQL	Задача If13.' + char(10) + 
	  char(9) + N'Даны три числа. Найти среднее из них (то есть число, расположенное между' + char(10) + 
	  char(9) + N'наименьшими наибольшим). Числа формируйте генератором случайных чисел' + char(10) + 
	  char(10) + 
	  char(9) + N'Числа:' + char(10) +
	  char(9) + N'a = ' + ltrim(str(@a)) + char(10) + 
	  char(9) + N'b = ' + ltrim(str(@b)) + char(10) + 
	  char(9) + N'c = ' + ltrim(str(@c)) + char(10) +
	  char(10) + 
	  char(9) + N'Результат:' + char(10) + 
	  char(9) + N'Среднее число из чисел a(' + ltrim(str(@a)) + '), b(' + ltrim(str(@b)) + '), c(' 
	  + ltrim(str(@c)) + '): ' + ltrim(str(@avg)) + char(10));
go


-- 13	Изучение T-SQL	Задача If14. 
-- Даны три числа. Вывести вначале наименьшее, а затем наибольшее из данных 
-- чисел. Числа формируйте генератором случайных чисел

-- диапазон для генерации
declare @lo int = 5, @hi int = 15;

-- генерация трех чисел
declare @a int = (rand() * (@hi - @lo) + @lo), @b int = (rand() * (@hi - @lo) + @lo), @c int = (rand() * (@hi - @lo) + @lo);

-- минимальное и максимальное значение
declare @min int, @max int;

-- минимального и максимального из трех чисел
if @a > @b begin	-- если A больше B
	if @b > @c begin	-- если A максимальное, а B минимальное
		set @max = @a;
		set @min = @c;
	end
	else if @a > @c begin -- если A максимальное, а B минимальное
		set @max = @a;
		set @min = @b;
	end
	else begin			-- если C максимальное, а B минимальное 
		set @max = @c
		set @min = @b
	end
end else if @b > @a begin	-- если B больше A
	if @a > @c begin		-- если B максимальное, а C минимальное
		set @max = @b;
		set @min = @c;
	end
	else if @b > @c begin	-- если B максимальное, а A минимальное 
		set @max = @b;
		set @min = @a;
	end
	else begin				--  если C максимальное, а A минимальное
		set @max = @c;
		set @min = @a;
	end
end else if @c > @a begin
	set @max = @c;
	set @min = @a;
end
else begin
	set @max = @a;
	set @min = @c;
end

print(char(10) +
	  char(9) + N'13. Изучение T-SQL	Задача If14.' + char(10) + 
	  char(9) + N'Даны три числа. Вывести вначале наименьшее, а затем наибольшее из данных' + char(10) + 
	  char(9) + N'чисел. Числа формируйте генератором случайных чисел' + char(10) + 
	  char(10) + 
	  char(9) + N'Числа:' + char(10) + 
	  char(9) + N'a = ' + ltrim(str(@a)) + char(10) +
	  char(9) + N'b = ' + ltrim(str(@b)) + char(10) + 
	  char(9) + N'c = ' + ltrim(str(@c)) + char(10) + 
	  char(10) + 
	  char(9) + N'Результат:' + char(10) + 
	  char(9) + N'Максимальное и минимальное число среди чисел a(' + ltrim(str(@a)) + '), b(' 
	  + ltrim(str(@b)) + '), c(' + ltrim(str(@c)) + N'): минимальное - ' + ltrim(str(@min)) + N', максимальное - ' 
	  + ltrim(str(@max)) + char(10));
go

-- 14	Изучение T-SQL	Задача If15. 
-- Даны три числа. Найти сумму двух наибольших из них. Числа формируйте 
-- генератором случайных чисел

-- диапазон для генерации
declare @lo int = 5, @hi int = 15;

-- генерация трех чисел
declare @a int = (rand() * (@hi - @lo) + @lo), @b int = (rand() * (@hi - @lo) + @lo), @c int = (rand() * (@hi - @lo));

-- первое и второе максимальное значение 
declare @max1 int, @max2 int;

-- поиск максимальных значений
if @a >= @b and @a >= @c begin		-- первое максимальное A
	set @max1 = @a;				
	if @b >= @c						-- второе максимальное B
		set @max2 = @b;
	else 
		set @max2 = @c;				-- второе максиамальное C
end 
else if @b >= @a and @b >= @c begin	-- первое максимальное B
	set @max1 = @b;
	if @a >= @c						-- второе максимальное A
		set @max2 = @a;
	else							-- второе максимальное C
		set @max2 = @c;
end else begin						-- первое максимальное C
	set @max1 = @c;
	if @a > @b						-- второе максимальное A
		set @max2 = @a;
	else							-- второе максимальное B
		set @max2 = @b;
end

-- сумма первого и второго максимальных элементов
declare @sum int = @max1 + @max2;

print(char(10) +
	  char(9) + N'14. Изучение T-SQL	Задача If15. ' + char(10) +
	  char(9) + N'Даны три числа. Найти сумму двух наибольших из них. Числа формируйте' + char(10) +
	  char(9) + N'генератором случайных чисел' + char(10) +
	  char(10) +
	  char(9) + N'Числа:' + char(10) + 
	  char(9) + N'a = ' + ltrim(str(@a)) + char(10) +
	  char(9) + N'b = ' + ltrim(str(@b)) + char(10) + 
	  char(9) + N'c = ' + ltrim(str(@c)) + char(10) + 
	  char(10) + 
	  char(9) + N'Результат:' + char(10) + 
	  char(9) + N'Сумма первого (' + ltrim(str(@max1)) + N') и второго (' +
	  ltrim(str(@max2)) + N') максимальных элементов: ' + ltrim(str(@max1)) + 
	  ' + ' + ltrim(str(@max2)) + ' = ' + ltrim(str(@max1 + @max2))) + char(10);
go

-- 15	Изучение T-SQL	Задача If17. 
-- Даны три числа. Если их значения упорядочены по возрастанию или убыванию,
-- то удвоить их; в противном случае заменить значение каждой переменной на 
-- противоположное. Числа формируйте генератором случайных чисел или присваиванием

-- диапазон для генерации
declare @lo int = 10, @hi int = 50;

-- генерация трех чисел
declare @a int = (rand() * (@hi - @lo) + @lo), @b int = (rand() * (@hi - @lo) + @lo), @c int = (rand() * (@hi - @lo) + @lo);

-- сохранение исходных значений
declare @oldA int = @a, @oldB int = @b, @oldC int = @c;

-- информация о числах
declare @info nvarchar(40) = N'Числа упорядочены по убыванию';

-- обработка чисел по заданию
-- если все числа упорядочены по возрастанию или убыванию
if @a >= @b and @b >= @c or @a <= @b and @b <= @c begin
	if @a <= @b and @b <= @c 
		set @info = replace(@info, N'убыванию', N'возрастанию');

	set @a *= 2;
	set @b *= 2;
	set @c *= 2;
end else begin
	set @info = N'Числа не упорядочены';
	set @a = -@a;
	set @b = -@b;
	set @c = -@c;
end

print(char(10) +
	  char(9) + N'15	Изучение T-SQL	Задача If17.' + char(10) +
	  char(9) + N'Даны три числа. Если их значения упорядочены по возрастанию или убыванию,' + char(10) +
	  char(9) + N'то удвоить их; в противном случае заменить значение каждой переменной на ' + char(10) +
	  char(9) + N'противоположное. Числа формируйте генератором случайных чисел или присваиванием' + char(10) +
	  char(10) +
	  char(9) + N'Числа:' + char(10) + 
	  char(9) + N'a = ' + ltrim(str(@oldA)) + char(10) +
	  char(9) + N'b = ' + ltrim(str(@oldB)) + char(10) +
	  char(9) + N'c = ' + ltrim(str(@oldC)) + char(10) +
	  char(10) + 
	  char(9) + N'Результат:' + char(10) + 
	  char(9) + @info + char(10) +
	  char(9) + char(9) + left(N'a (' + ltrim(str(@oldA)) + N')', 30) + N' ➪ ' + ltrim(str(@a)) + char(10) +
	  char(9) + char(9) + left(N'b (' + ltrim(str(@oldB)) + N')', 20) + N' ➪ ' + ltrim(str(@b)) + char(10) +
	  char(9) + char(9) + left(N'c (' + ltrim(str(@oldC)) + N')', 20) + N' ➪ ' + ltrim(str(@c)) + char(10));
go