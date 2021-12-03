 -- Даны два целых числа A и B (A < B). 
 -- Найти сумму всех целых чисел от A до B включительно.

 -- round(выражение, знаковВдробнойЧасти)
 -- rand() - случайное вещественное число от 0 до 1
declare @a int = 10*rand();
declare @b int  = @a + 10*rand() + 1; 
declare @sum int = 0;

-- переменная цикла
declare @x int = @a;

while @x <= @b begin
    set @sum += @x;    -- накопление суммы
	set @x += 1;       -- продвижение по цикла, следующее слагаемое
end;

-- использование функции convert() для преобразования числа в строковое представление
print char(10) + char(9) + N'Сумма целых чисел от ' + convert(nvarchar, @a) + N' до ' + convert(nvarchar, @b)+ 
      N' включительно равна ' + convert(nvarchar, @sum);
go