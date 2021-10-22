using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

using static HomeWorkCSharp.Application.App.Utils;       // для использования утилит

/*
 * Задача 1. В трех строках текстового файла data.txt (в папке исходного текста)
 * через пробел записаны три числа, например, так:
 * 
 * 3 5 3
 * 2 1 3
 * 1 3 5
 * 
 * Для каждого набора определите среднее число (т.е. число между минимальным и
 * максимальным из чисел) и выведите получившиеся четверки чисел в текстовый файл
 * с именем result.txt в папке исходного текста. Т.е. должно получиться следующее:
 * 
 * 3 5 3		3
 * 2 1 3		2
 * 1 3 5 		3
 * 
 * Задача 2. В текстовом файле найти количество слов в тексте, у которых первый и 
 * последний символы совпадают (выполнять поиск дважды - с учетом и без учета 
 * регистра символов). Вывести текстовый файл, найденные слова в консоль.
*/

namespace HomeWorkCSharp.Application
{
    // константы для меню
    internal enum Cmd
    {
        pointExit,
        pointOne,
        pointTwo,
        pointThree,
        pointFour,
        pointFive,
        pointSix
    }

    public partial class App
    {

        #region Меню заданий 

        // меню заданий
        public void Menu()
        {
            // пункты меню 
            string[] points =
            {
                "Задание 1. Поиск среднего значения",
                "Задание 2. Количество слов"
            };


            // нажатая клавиша
            ConsoleKey num = new ConsoleKey();

            // вывод меню
            while (true)
            {
                try
                {
                    // отчистка консоли
                    Console.Clear();

                    // цвет 
                    Console.ForegroundColor = ConsoleColor.Cyan;

                    // координаты курсора
                    int x = 5, y = Console.CursorTop + 3;

                    // заголовок
                    Console.SetCursorPosition(x + 3, y); WriteColor($"{"    Главное меню"}", ConsoleColor.Blue);

                    y += 2;

                    // вывод пунктов меню
                    Array.ForEach(points, item => WriteColorXY(item, x, y++));

                    // вывод пункта выхода из приложения
                    Console.SetCursorPosition(x, ++y); Console.WriteLine("0. Выход");

                    y += 4;

                    // ввод номера задания
                    Console.SetCursorPosition(x, y); Console.Write("Введите номер задания: ");
                    num = Console.ReadKey().Key;

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

                        // Задание 1. Название задания
                        case ConsoleKey.NumPad1:
                            goto case ConsoleKey.D1;
                        case ConsoleKey.D1:
                            // запуск задания 
                            Task1();
                            break;

                        // Задание 2. Название задания
                        case ConsoleKey.NumPad2:
                            goto case ConsoleKey.D2;
                        case ConsoleKey.D2:
                            // запуск задания 
                            Task2();
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
            }
        } // Menu

        #endregion

    }
}
