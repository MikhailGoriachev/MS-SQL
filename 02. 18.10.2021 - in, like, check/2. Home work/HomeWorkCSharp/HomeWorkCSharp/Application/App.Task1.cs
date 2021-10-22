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
        #region Задание 1. Поиск среднего значения

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
         */

        // Задание 1. Поиск среднего значения
        public void Task1()
        {
            Console.Clear();

            ShowNavBarMessage("Задание 1. Поиск среднего значения");

            // путь к файлу
            string path = @"..\..\numbers.txt";

            // создание и заполнение файла 
            CreateAndFillNumbersFile(path);

            // вывод файла 
            ShowFile(path, "Исходное содержание файла");

            Console.WriteLine();

            // чтение файла и запись среднего значения
            ReadAndAverageWriteFile(path);

            // вывод файла 
            ShowFile(path, "Результирующее содержание файла");
        }

        // чтение файла и запись среднего значения
        private void ReadAndAverageWriteFile(string path)
        {
            // содержание файла
            string[] content = File.ReadAllText(path).Split('\n');

            // открытие файла по чтению и записи
            using (FileStream fs = new FileStream(path, FileMode.Open, FileAccess.ReadWrite))
            {
                // поток для записи
                StreamWriter sw = new StreamWriter(fs, Encoding.UTF8);

                int pos = (int)fs.Position;

                // список чисел в строке 
                List<int> numbers = new List<int>();

                foreach (var str in content)
                {
                    // если строка пустая
                    if (str.Length == 0) break;

                    // строки с числами
                    string[] strNum = str.Split(" ".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);

                    // отчистка списка
                    numbers.Clear();

                    // парс строк
                    foreach (var s in strNum) numbers.Add(int.Parse(s));

                    // сумма всех элементов 
                    int sum = 0;
                    numbers.ForEach(item => sum += item);

                    // среднее значение
                    int avg;

                    // если среднее значение второй элемент
                    if (numbers[0] >= numbers[1] && numbers[1] >= numbers[2] || numbers[0] <= numbers[1] && numbers[1] <= numbers[2])
                        avg = numbers[1];
                    // если среднее значение первый элемент
                    else if (numbers[0] <= numbers[1] && numbers[0] >= numbers[2] || numbers[0] >= numbers[1] && numbers[0] <= numbers[2])
                        avg = numbers[0];
                    // если среднее значение третий элемент
                    else avg = numbers[2];

                    // запись результата в файл
                    sw.Write($"{numbers[0],2} {numbers[1],2} {numbers[2],2}     {avg, 2}\n");

                    // сохранение записи в файле
                    sw.Flush();
                }
            }
        }

        // создание и заполнение файла 
        private void CreateAndFillNumbersFile(string path)
        {
            // информация о файле
            FileInfo file = new FileInfo(path);

            // создание и открытие файла
            using (StreamWriter sw = new StreamWriter(file.Create(), Encoding.UTF8))
            {
                // количество строк с числами
                int n = 3;

                // заполнение файла 
                for (int i = 0; i < n; i++)
                {
                    // генерация трёх чисел
                    int a = rand.Next(-5, 5);
                    int b = rand.Next(-5, 5);
                    int c = rand.Next(-5, 5);

                    // запись в файл
                    sw.Write($"{a, 2} {b, 2} {c, 2}\n");
                }
            }
        }

        #endregion

    }
}
