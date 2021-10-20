using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using HomeWorkCSharp.Models;                // подключение моделей

using static HomeWorkCSharp.Application.App.Utils;       // для использования утилит

namespace HomeWorkCSharp.Application
{
    public partial class App
    {
        #region Задание 1. Библиотека

        /*
         * Задача 1. Разработайте консольное приложение для учета книг в 
         * библиотеке. Сведения о книгах содержат: фамилию и инициалы 
         * автора, название, год издания, количество экземпляров данной
         * книги в библиотеке, код библиотечного учета (ББК).
         * 
         * Требуется хранить книги в коллекции List<Book>, реализовать 
         * следующий функционал:
         * •	Начальное заполнение коллекции книг (иницализация или 
         *      генерация – по Вашему выбору)
         * •	добавление данных о книге, вновь поступающей в библиотеку 
         *      – не вводите с клавиатуры, формируйте данные книги;
         * •	изменения количества экземпляров заданной книги – индекс 
         *      изменяемой книги задавайте случайным числом, изменение 
         *      количества – также случайное число; 
         * •	создать Dictionary<string, int> для пар «автор – суммарное 
         *      количество книг»
         * •	удаление данных о списываемой книге по коду библиотечного
         *      учета, код вводить с клавиатуры;
         * •	выдача сведений о всех книгах, упорядоченных по авторам;
         * •	выдача сведений о всех книгах, упорядоченных по годам 
         *      издания.

         */

        // Задание 1. Библиотека
        public void DemoTask1()
        {
            // библиотека
            Library library = new Library { Name = "\"Руниверс\"" };

            // инициализация библиотеки
            InitializationLibrary();

            #region Меню

            // пункты меню 
            string[] points =
            {
                "1. Формирование данных",
                "2. Добавление книги",
                "3. Изменение количества заданной книги",
                "4. Создание словаря для пар \"автор — суммарное количество книг\"",
                "5. Удаление данных о книге по коду",
                "6. Сортировка по автору",
                "7. Сортировка по году издания"
            };

            // нажатая клавиша
            ConsoleKey num;

            // вывод меню
            while (true)
            {
                // отчистка консоли
                Console.Clear();

                // цвет 
                Console.ForegroundColor = ConsoleColor.Cyan;

                int x = 5, y = Console.CursorTop + 3;

                // заголовок
                Console.SetCursorPosition(x + 3, y); WriteColor($"{"    Задание 1. Библиотека"}", ConsoleColor.Blue);

                y += 2;

                // вывод пунктов меню
                Array.ForEach(points, item => WriteColorXY(item, x, y++));

                // вывод пункта выхода из приложения
                Console.SetCursorPosition(x, ++y); Console.WriteLine("0. Выход");

                y += 4;

                // ввод номера задания
                Console.SetCursorPosition(x, y); Console.Write("Введите номер задания: ");
                num = Console.ReadKey().Key;

                try
                {

                    // обработка ввода 
                    switch (num)
                    {
                        // выход
                        case ConsoleKey.NumPad0:
                            goto case ConsoleKey.D0;
                        case ConsoleKey.Escape:
                            goto case ConsoleKey.D0;
                        case ConsoleKey.D0:
                            // позициониаровние курсора 
                            Console.SetCursorPosition(2, y + 5);
                            return;

                        // 1. Формирование данных
                        case ConsoleKey.NumPad1:
                            goto case ConsoleKey.D1;
                        case ConsoleKey.D1:
                            Console.Clear();
                            // запуск задания 
                            Point1();
                            break;

                        // 2. Добавление книги
                        case ConsoleKey.NumPad2:
                            goto case ConsoleKey.D2;
                        case ConsoleKey.D2:
                            Console.Clear();
                            // запуск задания 
                            Point2();
                            break;

                        // 3. Изменение количества заданной книги
                        case ConsoleKey.NumPad3:
                            goto case ConsoleKey.D3;
                        case ConsoleKey.D3:
                            Console.Clear();
                            // запуск задания 
                            Point3();
                            break;

                        // 4. Создание словаря для пар \"автор — суммарное количество книг\"
                        case ConsoleKey.NumPad4:
                            goto case ConsoleKey.D4;
                        case ConsoleKey.D4:
                            Console.Clear();
                            // запуск задания 
                            Point4();
                            break;

                        // 5. Удаление данных о книге по коду
                        case ConsoleKey.NumPad5:
                            goto case ConsoleKey.D5;
                        case ConsoleKey.D5:
                            Console.Clear();
                            // запуск задания 
                            Point5();
                            break;

                        // 6. Сортировка по автору
                        case ConsoleKey.NumPad6:
                            goto case ConsoleKey.D6;
                        case ConsoleKey.D6:
                            Console.Clear();
                            // запуск задания 
                            Point6();
                            break;

                        // 7. Сортировка по году издания
                        case ConsoleKey.NumPad7:
                            goto case ConsoleKey.D7;
                        case ConsoleKey.D7:
                            Console.Clear();
                            // запуск задания 
                            Point7();
                            break;

                        // если номер задания невалиден
                        default:

                            // установка цвета
                            Console.BackgroundColor = ConsoleColor.DarkRed;
                            Console.ForegroundColor = ConsoleColor.Black;

                            // позиционирование курсора
                            Console.SetCursorPosition(x, y); Console.WriteLine("         Номер задания невалиден!         ");

                            // выключение курсора
                            Console.CursorVisible = false;

                            // задержка времени
                            Thread.Sleep(1000);

                            // возвращение цвета
                            Console.ResetColor();

                            // включение курсора
                            Console.CursorVisible = true;

                            break;
                    } // switch
                } // try

                // стандартное исключение
                catch (Exception ex)
                {
                    Console.Clear();

                    // вывод сообщения об ошибке 
                    WriteColor(ex.Message, ConsoleColor.Red);
                    Console.WriteLine();
                    WriteColor(ex.StackTrace, ConsoleColor.Red);
                    Console.WriteLine();
                } // catch

                // обязательная часть
                finally
                {
                    // если пункт меню 0
                    if (num != ConsoleKey.D0 && num != ConsoleKey.NumPad0 && num != ConsoleKey.Escape)
                    {
                        // ввод клавиши для продолжения 
                        WriteColor("\n\n\tНажмите на [Enter] для продолжения...", ConsoleColor.Cyan);
                        Console.CursorVisible = false;
                        while (Console.ReadKey(true).Key != ConsoleKey.Enter) ;
                        Console.CursorVisible = true;
                    }
                } // finally
            } // while

            #endregion

            #region 1. Формирование данных

            // 1. Формирование данных
            void Point1()
            {
                ShowNavBarMessage("1. Формирование данных");

                // формирование данных
                InitializationLibrary();

                // вывод библиотеки
                library.ShowTable("После заполнения");
            }

            // инициализация библиотеки
            void InitializationLibrary(int size = 10)
            {
                // отчитска библиотеки
                library.Clear();

                // добавление книги в библиотеку
                for (int i = 0; i < size; i++)
                    library.AddBook(FactoryMethodBook());
            }

            // фабричный метод книги
            Book FactoryMethodBook()
            {
                // автор/название/код массив
                (string author, string tittles, string code)[] authorAndTittles = {
                    ("Джон Толкин",     "Властелин колец",              "35.743"),
                    ("Джейн Остин",     "Гордость и предубеждение",     "88.7"),
                    ("Филип Пулман",    "Тёмные начала",                "37.488"),
                    ("Джоан Роулинг",   "Гарри Поттер и Кубок огня",    "27.754"),
                    ("Харпер Ли",       "Убить пересмешника",           "48.800"),
                    ("Алан Милн",       "Винни Пух",                    "42.78"),
                    ("Джордж Оруэлл",   "1984",                         "90.75"),
                };

                // автор/название/код для книги
                var d = authorAndTittles[rand.Next(0, authorAndTittles.Length)];

                return new Book { Author = d.author, Title = d.tittles, Code = d.code, Count = rand.Next(10, 40), Year = rand.Next(1980, 2010) };
            }

            #endregion

            #region 2. Добавление книги

            // 2. Добавление книги
            void Point2()
            {
                ShowNavBarMessage("2. Добавление книги");

                // вывод книг
                library.ShowTable("До добавления книги");

                Console.WriteLine();

                // книга для добавления
                Book book = FactoryMethodBook();
                                
                // вывод книги для добавления
                Library.ShowHead(1, "Книга", "Для добавления");
                book.ShowElem(1);
                Library.ShowLine();

                Console.WriteLine();

                // добавление книги 
                library.AddBook(book);

                // вывод книг
                library.ShowTable("После добавления книги");
            }

            #endregion

            #region 3. Изменение количества заданной книги

            // 3. Изменение количества заданной книги
            void Point3()
            {
                ShowNavBarMessage("3. Изменение количества заданной книги");

                // вывод книг
                library.ShowTable("До изменения книги");

                Console.WriteLine();

                // индекс книги для изменения
                int i = rand.Next(0, library.Count - 1);

                // вывод книги для изменения
                Library.ShowHead(1, "Книга", "Для изменения");
                library[i].ShowElem(1);
                Library.ShowLine();

                Console.WriteLine();

                // изменение книги 
                library[i].Count = rand.Next(10, 40);

                // вывод книг
                library.ShowTable("После изменения книги");
            }

            #endregion

            #region 4. Создание словаря для пар \"автор — суммарное количество книг\"

            // 4. Создание словаря для пар \"автор — суммарное количество книг\"
            void Point4()
            {
                ShowNavBarMessage("4. Создание словаря для пар \"автор — суммарное количество книг\"");

                // создание и вывод словаря
                library.ShowDictionaryAuthorCount(library.CreateDictionaryAuthorCount());

            }

            #endregion

            #region 5. Удаление данных о книге по коду

            // 5. Удаление данных о книге по коду
            void Point5()
            {
                ShowNavBarMessage("5. Удаление данных о книге по коду");

                // вывод книг
                library.ShowTable("До удаления книги");

                Console.WriteLine();

                // индекс книги для удаления
                int i = rand.Next(0, library.Count - 1);

                // вывод книги для удаления
                Library.ShowHead(1, "Книга", "Для удаления");
                library[i].ShowElem(1);
                Library.ShowLine();

                Console.WriteLine();

                // удаление книги 
                library.DeleteBook(library[i].Code);

                // вывод книг
                library.ShowTable("После удаления книги");
            }

            #endregion


            #region 6. Сортировка по автору

            // 6. Сортировка по автору
            void Point6()
            {
                ShowNavBarMessage("6. Сортировка по автору");

                // сортировка 
                library.SortByAuthor();

                // вывод книг 
                library.ShowTable("После сортировки");
            }

            #endregion

            #region 7. Сортировка по году издания

            // 7. Сортировка по году издания
            void Point7()
            {
                ShowNavBarMessage("7. Сортировка по году издания");

                // сортировка 
                library.SortByYear();

                // вывод книг 
                library.ShowTable("После сортировки");
            }

            #endregion
        }

        #endregion
    }
}
