using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.IO;        // для работы с потоками данных

namespace HomeWorkCSharp.Application
{
    // Класс Приложение (Утилиты)
    public partial class App
    {
        // Утилиты
        public class Utils
        {
            #region Утилиты

            // объект Random для заполнения массивов
            public static Random rand = new Random();

            // получение случайного вещественного числа в диапазоне (min, max]
            public static double GetDouble(int min, int max) => rand.Next(min, max) + rand.NextDouble();

            // вывод сообщения в цвете 
            public static void WriteColor(string msg, ConsoleColor textColor, ConsoleColor backColor = ConsoleColor.Black)
            {
                // текущий цвет 
                ConsoleColor tempText = Console.ForegroundColor;
                ConsoleColor tempBack = Console.BackgroundColor;

                // установк цвета
                SetColor(textColor, backColor);

                // вывод сообщения 
                Console.Write(msg);

                // возвращение цвета 
                SetColor(tempText, tempBack);
            }

            // вывод сообщения в цвете и позиционированием 
            public static void WriteColorXY(string msg = "", int posX = -1, int posY = -1, ConsoleColor textColor = ConsoleColor.White, ConsoleColor backColor = ConsoleColor.Black)
            {
                // позиционирование курсора
                PosXY(posX == -1 ? Console.CursorLeft : posX, posY == -1 ? Console.CursorTop : posY);

                // вывод сообщения в цвете
                WriteColor(msg, textColor, backColor);
            }

            // вывод сообщения о неправильно введённых данных, с указанием позиции
            public static void MsgErrorData(int posX = 0, int posY = -1, string msg = "Данные неверны!")
            {
                // вывод сообщения 
                WriteColorXY(msg, posX, posY == -1 ? Console.CursorTop - 1 : posY, ConsoleColor.Black, ConsoleColor.Red);

                // задержка по времени
                Thread.Sleep(500);
            }

            // позиционирование курсора
            public static void PosXY(int posX, int posY) => Console.SetCursorPosition(posX, posY);

            // установка цвета текста 
            public static void SetColor(ConsoleColor color) => Console.ForegroundColor = color; // SetColor

            // установка цвета текста и фона 
            public static void SetColor(ConsoleColor textColor, ConsoleColor backColor)
            {
                Console.ForegroundColor = textColor;
                Console.BackgroundColor = backColor;
            } // SetColor

            // вывод сообщения в первой строке консоли
            public static void ShowNavBarMessage(string msg)
            {
                // установка цвета
                Console.BackgroundColor = ConsoleColor.White;
                Console.ForegroundColor = ConsoleColor.DarkBlue;

                // позиционирование курсора
                Console.SetCursorPosition(0, 0);

                // заполенение первой строки цветом 
                Console.WriteLine($"{" ".PadLeft(Console.WindowWidth)}");

                // позиционирование курсора
                Console.SetCursorPosition(2, 0);

                // вывод сообщения 
                Console.WriteLine(msg);

                // позиционирование курсора
                Console.SetCursorPosition(0, 3);

                Console.ResetColor();
            } // ShowNavBarMessage

            // вывод файла 
            public static void ShowFile(string path, string info)
            {
                // информация о файле
                FileInfo file = new FileInfo(path);

                // вывод шапки таблицы вывода файла
                FileReaderHead((int)file.Length, file.Name, info);

                // вывод строк файла 
                ShowStringFile(path);

                // вывод подвала таблицы вывода файла
                ShowLine();
            }

            // вывод шапки таблицы вывода файла
            public static void FileReaderHead(int sizeFile, string nameFile, string info)
            {
                //                            20                        30                                    39   
                WriteColorXY("     ╔══════════════════════╦════════════════════════════════╦═════════════════════════════════════════╗\n", textColor: ConsoleColor.Magenta);
                WriteColorXY("     ║                      ║                                ║                                         ║", textColor: ConsoleColor.Magenta);
                WriteColorXY("Размер файла: ", 7, textColor: ConsoleColor.DarkYellow);
                WriteColorXY($"{sizeFile,6}", textColor: ConsoleColor.Green);
                WriteColorXY("Название файла: ", 30, textColor: ConsoleColor.DarkYellow);
                WriteColorXY($"{nameFile,-14}", textColor: ConsoleColor.Green);
                WriteColorXY("Инфо: ", 63, textColor: ConsoleColor.DarkYellow);
                WriteColorXY($"{info,-33}", textColor: ConsoleColor.Green);
                Console.WriteLine();

                //                   2                                                    90                                                 
                WriteColorXY("     ╠════╦═════════════════╩════════════════════════════════╩═════════════════════════════════════════╣\n", textColor: ConsoleColor.Magenta);
                WriteColorXY("     ║    ║                                                                                            ║", textColor: ConsoleColor.Magenta);
                WriteColorXY("N ", 7, textColor: ConsoleColor.DarkYellow);
                WriteColorXY("Содержимое файла", 44, textColor: ConsoleColor.DarkYellow);
                Console.WriteLine();

                WriteColorXY("     ╠════╬════════════════════════════════════════════════════════════════════════════════════════════╣\n", textColor: ConsoleColor.Magenta);
            }

            // вывод строк файла 
            public static void ShowStringFile(string path)
            {
                // считывание и вывод строк
                using (StreamReader sr = new StreamReader(File.OpenRead(path)))
                {
                    // номер строки
                    int n = 1;

                    // чтение и вывод строк
                    while (!sr.EndOfStream)
                    {
                        // строка из файла
                        string str = sr.ReadLine();

                        // вывод строки
                        WriteColorXY("     ║    ║                                                                                            ║", textColor: ConsoleColor.Magenta);
                        WriteColorXY($"{n++,2}", 7, textColor: ConsoleColor.DarkGray);
                        WriteColorXY($"{str,-90}", 12, textColor: ConsoleColor.Cyan);
                        Console.WriteLine();
                    }
                }
            }

            // вывод подвала таблицы вывода файла
            public static void ShowLine() =>
                WriteColorXY("     ╚════╩════════════════════════════════════════════════════════════════════════════════════════════╝\n", textColor: ConsoleColor.Magenta);

            #endregion
        }
    }
}