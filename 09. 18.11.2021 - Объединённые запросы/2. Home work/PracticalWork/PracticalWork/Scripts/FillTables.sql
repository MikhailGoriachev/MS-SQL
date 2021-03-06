delete from Sales;			-- очистка таблицы Units		(Единицы_измерения)
delete from	Purchases;		-- очистка таблицы Goods		(Товары)
delete from	Sellers;		-- очистка таблицы Sellers		(Продавцы)
delete from	Goods;			-- очистка таблицы Purchases	(Закупки)
delete from	Units;			-- очистка таблицы Sales		(Продажи)

-- заполнение таблицы Units		(Единицы_измерения)
insert into Units
	(Long, Short)
values				-- Источник: https://balance.ua/ru/news/archive/edinicy-izmereniya-tovarovuslug-v-nalogovoy-nakladnoy
	(N'Метр',				N'м'),				-- 1
	(N'Квадратный метр',	N'м2'),				-- 2
	(N'Литр',				N'л'),				-- 3
	(N'Килограмм',			N'кг'),				-- 4
	(N'Грамм',				N'г'),				-- 5
	(N'Тонна метрическая',	N'т'),				-- 6
	(N'Центнер',			N'ц'),				-- 7
	(N'Штука',				N'шт'),				-- 8
	(N'Коробка',			N'кор'),			-- 9
	(N'Цистерна',			N'цистерн'),		-- 10
	(N'Ящик',				N'ящ'),				-- 11
	(N'Пакет',				N'пак'),			-- 12
	(N'Пачка',				N'пач'),			-- 13
	(N'Рулон',				N'рул'),			-- 14
	(N'Погонный метр',		N'пог. м'),			-- 15
	(N'Комплект',			N'компл')			-- 16


-- заполнение таблицы Goods		(Товары)
insert into Goods
	([Name])
values
	(N'Чай Lipton'),			-- 1
	(N'Чай Grenfield'),			-- 2
	(N'Чай Curtis'),			-- 3
	(N'Чай Richard'),			-- 4
	(N'Мука 1 сорт'),			-- 5
	(N'Мука высший сорт'),		-- 6
	(N'Гречка'),				-- 7
	(N'Рис'),					-- 8
	(N'Тетардь Interdruk'),		-- 9
	(N'Ячмень'),				-- 10
	(N'Тетардь KiteStudio'),	-- 11
	(N'Сахар'),					-- 12
	(N'Обои Адель'),			-- 13
	(N'Обои Grandeco'),			-- 14
	(N'Обои Асти'),				-- 15
	(N'Обои Континент'),		-- 16
	(N'Обои Сафари'),			-- 17
	(N'Обои Rasch'),			-- 18
	(N'Обои Синтра'),			-- 19
	(N'Обои Oscar');			-- 20


-- заполнение таблицы Sellers	(Продавцы)
insert into Sellers
	(Surname, [Name], Patronymic, Interest)
values
	(N'Астафьева',		N'Дарья',		N'Алексеевна',			8),				-- 1
	(N'Дмитриева',		N'София',		N'Кирилловна',			12),			-- 2
	(N'Григорьева',		N'Вера',		N'Владиславовна',		5),				-- 3
	(N'Литвинова',		N'Ольга',		N'Ярославовна',			8),				-- 4
	(N'Козырев',		N'Юрий',		N'Семёнович',			7),				-- 5
	(N'Власов',			N'Михаил',		N'Александрович',		4),				-- 6
	(N'Григорьев',		N'Игорь',		N'Андреевич',			8),				-- 7
	(N'Колесов',		N'Иван',		N'Александрович',		6),				-- 8
	(N'Черных',			N'Алина',		N'Ильинична',			7),				-- 9
	(N'Фадеева',		N'София',		N'Богдановна',			10);			-- 10

	

-- заполнение таблицы Purchases	(Закупки)
insert into Purchases
	(IdGoods, IdUnit, Price, Amount, DatePurchase)
values 
	( 1,	13,		520,	120,	'2021/11/22'),				-- 1
	( 2,	13,		320,	 30,	'2021/10/06'),				-- 2
	( 4,	 7,		630,	  4,	'2021/11/22'),				-- 3
	( 1,	13,		480,	 85,	'2021/03/07'),				-- 4
	(13,	14,		760,	 20,	'2021/11/15'),				-- 5
	( 3,	13,		350,	 70,	'2021/11/16'),				-- 6
	( 4,	13,		600,	 30,	'2021/11/13'),				-- 7
	( 1,	13,		500,	 90,	'2021/09/15'),				-- 8
	( 7,	 4,		 35,	350,	'2021/03/18'),				-- 9
	( 9,	 8,		 40,	 90,	'2021/11/22'),				-- 10
	(13,	14,		700,	 40,	'2021/10/15'),				-- 11
	(14,	14,		950,	 70,	'2021/10/15'),				-- 12
	(15,	14,		630,	 20,	'2021/09/18'),				-- 13
	(16,	14,		750,	 45,	'2021/09/18'),				-- 14
	(15,	14,		650,	 40,	'2021/11/22'),				-- 15
	(17,	14,		930,	 30,	'2021/10/15'),				-- 16
	(18,	14,		550,	 35,	'2021/09/15'),				-- 17
	(19,	14,		840,	 28,	'2021/09/15'),				-- 18
	(20,	14,		730,	 35,	'2021/09/18'),				-- 19
	(17,	14,		880,	 48,	'2021/08/19'),				-- 20
	(15,	14,		830,	 52,	'2021/08/19'),				-- 21
	(15,	14,		830,	 38,	'2021/05/15'),				-- 22
	(17,	14,		760,	 15,	'2021/05/08'),				-- 23
	(12,	 7,	   1200,	  3,	'2021/10/15'),				-- 24
	(15,	14,		760,	 18,	'2021/03/28'),				-- 25
	( 11,	 8,		 49,	 60,	'2021/01/06'),				-- 26
	( 4,	13,		720,	 16,	'2021/01/06'),				-- 27
	( 9,	 8,		 70,	120,	'2021/07/05'),				-- 28
	(11,	 8,		 35,	120,	'2021/05/09'),				-- 29
	(14,	14,		870,	 50,	'2021/06/18');				-- 30


-- заполнение таблицы Sales		(Продажи)
insert into Sales
	(DateSell, IdSeller, IdPurchase, Amount, Price, IdUnit)
values
	('2021/10/07',	4,	11,	 6,		780, 14),			-- 1
	('2021/11/16',	4,	18,	20,		890, 14),			-- 2
	('2021/06/07',	6,	12,	12,	   1200, 14),			-- 3
	('2021/10/03',	3,	 1,	16,		530, 13),			-- 4
	('2021/09/18',	4,	18,	10,		850, 14),			-- 5
	('2021/11/16',	3,	11,	11,		750, 14),			-- 6
	('2021/09/18',	2,	20,	12,		900, 14),			-- 7
	('2021/06/03',	6,	30,	 6,	   1000, 14),			-- 8
	('2021/10/07',	4,	20,	12,	   1080, 14),			-- 9
	('2021/06/18',	4,	27,	20,		760, 13),			-- 10
	('2021/06/03',	3,	27,	12,	    980, 13),			-- 11
	('2021/11/13',	7,	30,	 8,	   1090, 14),			-- 12
	('2021/06/18',	3,	20,	16,		950, 14),			-- 13
	('2021/10/07',	4,	11,	12,	   1000, 14),			-- 14
	('2021/09/18',	7,	27,	20,		990, 13),			-- 15
	('2021/09/18',	1,	12,	12,		560, 14),			-- 16
	('2021/11/13',	4,	12,	12,	   1050, 14),			-- 17
	('2021/09/18',	4,	20,	12,	    980, 14),			-- 18
	('2021/09/18',	2,	11,	10,		700, 14),			-- 19
	('2021/10/07',	4,	 1,	20,		560, 13);			-- 20

