using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.IO;        // для работы с потоками данных

using static HomeWorkCSharp.Application.App.Utils;       // для использования утилит

namespace HomeWorkCSharp.Application
{
    public partial class App
    {
        #region Задание 2. Количество слов

        /*
         * Задача 2. В текстовом файле найти количество слов в тексте, у которых первый и 
         * последний символы совпадают (выполнять поиск дважды - с учетом и без учета 
         * регистра символов). Вывести текстовый файл, найденные слова в консоль.
        */

        // Задание 2. Поиск среднего значения
        public void Task2()
        {
            Console.Clear();

            ShowNavBarMessage("Задание 2. Количество слов");

            // путь к файлу
            string path = @"..\..\words.txt";

            // создание и заполнение файла 
            CreateAndFillTextFile(path);

            // вывод файла 
            ShowFile(path, "Исходное содержание файла");

            Console.WriteLine();

            // слова с учётом регистра
            var result1 = CountWordsFile(path, item => item[0] == item[item.Length - 1], out int count);

            // чтение файла, вывод слов, которые начинаются и заканчиваются на "а" с учётом регистра
            ShowWords(result1, count, info: "С учётом регистра");

            // слова без учёта регистра
            var result2 = CountWordsFile(path, item => { string s = item.ToLower(); return s[0] == s[item.Length - 1]; }, out count);

            // чтение файла, вывод слов, которые начинаются и заканчиваются на "а" с без учёта регистра
            ShowWords(result2, count, info: "Без учёта регистра");
        }

        // создание и заполнение файла 
        private void CreateAndFillTextFile(string path)
        {
            // информация о файле
            FileInfo file = new FileInfo(path);

            // массив слов 
            string[] words = {
                "бочка",
                "Ягода",
                "Машина",
                "арбуз",
                "август",
                "армада",
                "Аркада",
                "арка",
                "Артемида",
                "Аура",
                "Американка",
                "дыня",
                "инвентарь",
                "зеленка",
                "гранат",
                "пружина",
                "комната",
                "сок",
                "полено",
                "конюх",
                "кинотеатр",
                "карта",
                "окно",
            };

            // создание и открытие файла
            using (StreamWriter sw = new StreamWriter(file.Create(), Encoding.UTF8))
            {
                // количество строк с числами
                int n = rand.Next(10, 20);

                // заполнение файла 
                for (int i = 0; i < n; i++)
                { 
                    // запись в файл
                    sw.Write($"{words[rand.Next(0, words.Length)]} ");

                    // если слово кратно 5 то перевод строки
                    if (i != 0 && i % 5 == 0) sw.WriteLine();

                    // сохранение
                    sw.Flush();
                }
            }
        }

        // получение количества и массива слов соответсвующих предикатору
        private Dictionary<string, int> CountWordsFile(string path, Predicate<String> predicate, out int count)
        {
            // содержание файла
            string[] content = File.ReadAllText(path).Split(" ".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);

            // словарь
            Dictionary<string, int> dictionary = new Dictionary<string, int>();

            // слова отвечающие предикатору
            string[] words = Array.FindAll(content, predicate);

            // подсчёт количеств и слова, которые соответствуют предикатору
            foreach (var item in words) {
                // если слово есть в словаре
                if (dictionary.ContainsKey(item)) dictionary[item]++;
                else dictionary[item] = 1;
            }

            // общее количество слов
            count = words.Length;

            return dictionary;
        }

        // вывод слов
        private void ShowWords<T>(IEnumerable<T> words, int size, string name = "Слова", string info = "Список")
        {
            WriteColorXY("     ╔══════════════════════╦════════════════════════════════╦═════════════════════════════════════════╗\n", textColor: ConsoleColor.Magenta);
            WriteColorXY("     ║                      ║                                ║                                         ║", textColor: ConsoleColor.Magenta);
            WriteColorXY("Размер файла: ", 7, textColor: ConsoleColor.DarkYellow);
            WriteColorXY("Количество слов: ", 7, textColor: ConsoleColor.DarkYellow);
            WriteColorXY($"{size,3}", textColor: ConsoleColor.Green);
            WriteColorXY("Название: ", 30, textColor: ConsoleColor.DarkYellow);
            WriteColorXY($"{name,-20}", textColor: ConsoleColor.Green);
            WriteColorXY("Инфо: ", 63, textColor: ConsoleColor.DarkYellow);
            WriteColorXY($"{info,-33}", textColor: ConsoleColor.Green);
            Console.WriteLine();

            //                   2                                                    90                                                 
            WriteColorXY("     ╠════╦═════════════════╩════════════════════════════════╩═════════════════════════════════════════╣\n", textColor: ConsoleColor.Magenta);
            WriteColorXY("     ║    ║                                                                                            ║", textColor: ConsoleColor.Magenta);
            WriteColorXY("N ", 7, textColor: ConsoleColor.DarkYellow);
            WriteColorXY("Значения", 52, textColor: ConsoleColor.DarkYellow);
            Console.WriteLine();

            WriteColorXY("     ╠════╬════════════════════════════════════════════════════════════════════════════════════════════╣\n", textColor: ConsoleColor.Magenta);

            // номер строки
            int n = 1;

            // вывод слов
            foreach(var str in words)
            {
                // вывод строки
                WriteColorXY("     ║    ║                                                                                            ║", textColor: ConsoleColor.Magenta);
                WriteColorXY($"{n++,2}", 7, textColor: ConsoleColor.DarkGray);
                WriteColorXY($"{str,-90}", 12, textColor: ConsoleColor.Cyan);
                Console.WriteLine();
            }
            WriteColorXY("     ╚════╩════════════════════════════════════════════════════════════════════════════════════════════╝\n", textColor: ConsoleColor.Magenta);
        }

        #endregion

    }
}
