using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using static HomeWorkCSharp.Application.App.Utils;      // подключение утилит

namespace HomeWorkCSharp.Models
{
    // Класс Библиотека
    internal class Library
    {
        // коллекция книг 
        private List<Book> _books;

        // название библиотеки
        private string _name;

        #region Конструкторы и индексатор

        // конструктор по умолчанию
        public Library() : this(new List<Book>(), "Библиотека") { }

        // конструктор инициализирующий 
        public Library(List<Book> books, string name)
        {
            // установка значений
            _books = books;
            _name = name;
        }

        // индексатор
        public Book this[int index]
        { 
            get
            {
                // если индекс выход за границы массива
                if (index < 0 || index >= _books.Count)
                    throw new IndexOutOfRangeException("Library: выход за пределы массива!");

                return _books[index];
            }


            set
            {
                // если индекс выход за границы массива
                if (index < 0 || index >= _books.Count)
                    throw new IndexOutOfRangeException("Library: выход за пределы массива!");

                _books[index] = value;
            }

        }

        #endregion

        #region Свойства

        // доступ к полю _name
        public string Name { get => _name; set => _name = !String.IsNullOrWhiteSpace(value) ? value : 
                throw new Exception("Library: поле Name не может быть пустым!"); }

        // количество книг
        public int Count { get => _books.Count; }

        #endregion

        #region Методы 

        // добавление книги 
        public void AddBook(Book book) => _books.Add(book);

        // удаление книги по коду ББК
        public void DeleteBook(string code) => _books.RemoveAll(item => item.Code == code);

        // отчистка библиотеки
        public void Clear() => _books.Clear();

        // сортировка по автору 
        public void SortByAuthor() => _books.Sort((item1, item2) => 
            item1.Author.CompareTo(item2.Author));

        // сортировка по году издания
        public void SortByYear() => _books.Sort((item1, item2) =>
            item1.Year.CompareTo(item2.Year));

        // создание словаря для пар "автор – суммарное количество книг"
        public Dictionary<string, int> CreateDictionaryAuthorCount()
        {
            // словарь
            Dictionary<string, int> dictionary = new Dictionary<string, int>();

            // заполнение словаря
            foreach (var item in _books)
            {
                // если автор уже есть в словаре
                if (dictionary.ContainsKey(item.Author))
                    dictionary[item.Author]++;
                
                // иначе
                else dictionary[item.Author] = 1;
            }

            return dictionary;
        }

        // вывод словаря для пар "автор – суммарное количество книг"
        public void ShowDictionaryAuthorCount(Dictionary<string, int> dictionary)
        {
            // вывод заголовка таблицы
            WriteColorXY("     ╔════════════╦══════════════════════╦════════════╗\n", textColor: ConsoleColor.Magenta);
            WriteColorXY("     ║            ║                      ║            ║", textColor: ConsoleColor.Magenta);
            WriteColorXY("Размер: ", 7, textColor: ConsoleColor.DarkYellow);
            WriteColorXY($"{dictionary.Count,2}", textColor: ConsoleColor.Green);
            WriteColorXY("       Автор        ", 20, textColor: ConsoleColor.DarkYellow);
            WriteColorXY("Количество", 43, textColor: ConsoleColor.DarkYellow);

            Console.WriteLine();

            WriteColorXY("     ╠════════════╬══════════════════════╬════════════╣\n", textColor: ConsoleColor.Magenta);

            // номер элемента
            int i = 1;

            // вывод элементов таблицы
            foreach (var item in dictionary)
            {
                WriteColorXY("     ║            ║                      ║            ║", textColor: ConsoleColor.Magenta);
                WriteColorXY($"{i++, 2}", 7, textColor: ConsoleColor.DarkGray);
                WriteColorXY($"{item.Key, -20}", 20, textColor: ConsoleColor.Cyan);
                WriteColorXY($"{item.Value, 10}", 43, textColor: ConsoleColor.Green);

                Console.WriteLine();
            }

            // вывод подвала таблицы
            WriteColorXY("     ╚════════════╩══════════════════════╩════════════╝\n", textColor: ConsoleColor.Magenta);
        }

        // вывод данных в таблицу
        public void ShowTable(string info = "Исходные данные")
        {
            // вывод шапки таблицы
            ShowHead(_books.Count, _name, info);

            // вывод элементов таблицы
            ShowElements(_books);

            // вывод подвала таблицы
            ShowLine();
        }

        // вывод шапки таблицы
        public static void ShowHead(int size, string name = "Книги", string info = "Исходные данные")
        {
            //                        10                    30                                         50
            WriteColorXY("     ╔════════════╦════════════════════════════════╦════════════════════════════════════════════════════╗\n", textColor: ConsoleColor.Magenta);
            WriteColorXY("     ║            ║                                ║                                                    ║", textColor: ConsoleColor.Magenta);
            WriteColorXY("Размер: ", 7, textColor: ConsoleColor.DarkYellow);
            WriteColorXY($"{size,2}", textColor:ConsoleColor.Green);
            WriteColorXY("Название: ", 20, textColor: ConsoleColor.DarkYellow);
            WriteColorXY($"{name,-20}", textColor: ConsoleColor.Green);
            WriteColorXY("Инфо: ", 53, textColor: ConsoleColor.DarkYellow);
            WriteColorXY($"{info,-44}", textColor: ConsoleColor.Green);

            Console.WriteLine();
            
            //                   2                   30                          20            4            15             10
            WriteColorXY("     ╠════╦════════════════════════════════╦═══════╩══════════════╦══════╦═════════════════╦════════════╣\n", textColor: ConsoleColor.Magenta);
            WriteColorXY("     ║    ║                                ║                      ║      ║                 ║            ║", textColor: ConsoleColor.Magenta);
            WriteColorXY("N ", 7, textColor: ConsoleColor.DarkYellow);
            WriteColorXY("       Название книги         ", 12, textColor: ConsoleColor.DarkYellow);
            WriteColorXY("       Автор        ", 45, textColor: ConsoleColor.DarkYellow);
            WriteColorXY("Год", 68, textColor: ConsoleColor.DarkYellow);
            WriteColorXY("    ББК код    ", 75, textColor: ConsoleColor.DarkYellow);
            WriteColorXY("Количество", 93, textColor: ConsoleColor.DarkYellow);

            Console.WriteLine();

            WriteColorXY("     ╠════╬════════════════════════════════╬══════════════════════╬══════╬═════════════════╬════════════╣\n", textColor: ConsoleColor.Magenta);
        }

        // вывод элементов
        public static void ShowElements(IEnumerable<Book> books)
        {
            // порядковый номер
            int i = 1;

            // вывод элементов 
            foreach(var item in books)
                item.ShowElem(i++);
        }

        // вывод подвала
        public static void ShowLine() =>
            WriteColorXY("     ╚════╩════════════════════════════════╩══════════════════════╩══════╩═════════════════╩════════════╝\n", textColor: ConsoleColor.Magenta);

        #endregion
    }
}
