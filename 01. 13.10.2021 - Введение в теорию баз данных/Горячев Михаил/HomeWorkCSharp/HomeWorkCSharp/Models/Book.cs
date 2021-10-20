using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using static HomeWorkCSharp.Application.App.Utils;      // подключение утилит

namespace HomeWorkCSharp.Models
{
    // Класс Книга
    internal class Book
    {
        // фамилия и инициалы автора
        private string _author;

        // название книги
        private string _title;

        // год издания
        private int _year;

        // количество книг 
        private int _count;

        // код библиотечного учёта (ББК)
        private string _code;

        #region Свойства 

        // доступ к полю _author
        public string Author { get => _author; set => _author = !String.IsNullOrWhiteSpace(value) ? value : 
                throw new Exception("Bool: поле Author не может быть пустым!"); }

        // доступ к полю _title
        public string Title
        {
            get => _title; set => _title = !String.IsNullOrWhiteSpace(value) ? value :
                throw new Exception("Bool: поле Title не может быть пустым!");
        }

        // доступ к полю _year
        public int Year
        {
            get => _year; set => _year = value > 0 ? value :
                throw new Exception("Bool: поле Year не может быть меньше или равно 0!");
        }

        // доступ к полю _count
        public int Count
        {
            get => _count; set => _count = value >= 0 ? value :
                throw new Exception("Bool: поле Count не может быть меньше 0!");
        }

        // доступ к полю _code
        public string Code
        {
            get => _code; set => _code = !String.IsNullOrWhiteSpace(value) ? value :
                throw new Exception("Bool: поле Code не может быть пустым!");
        }

        #endregion

        #region Методы

        // вывод элемента в таблицу
        public void ShowElem(int num)
        {
            WriteColorXY("     ║    ║                                ║                      ║      ║                 ║            ║", textColor: ConsoleColor.Magenta);
            WriteColorXY($"{num,2}", 7, textColor: ConsoleColor.DarkGray);
            WriteColorXY($"{_title,-30}", 12, textColor: ConsoleColor.Cyan);
            WriteColorXY($"{_author,-20}", 45, textColor: ConsoleColor.Cyan);
            WriteColorXY($"{_year, 4}", 68, textColor: ConsoleColor.Green);
            WriteColorXY($"{_code, -15}", 75, textColor: ConsoleColor.Cyan);
            WriteColorXY($"{_count, 10}", 93, textColor: ConsoleColor.Green);

            Console.WriteLine();
        }

        #endregion
    }
}
