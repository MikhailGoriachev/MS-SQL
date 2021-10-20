using System;
using System.Collections;           // для необобщенной коллекции Hashtable
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
        
// Словарь, хэш, hashtable, ассоциативный массив 
// Словарь, Hashtable, хранит пары ключ - значение
// т.е. первый элемент пары является ключом этой пары, идентификатором пары,
// второй элемент пары является значением этой пары, элемент м.б. объектом 
// получаем нечто вроде модели реляционной таблицы БД
// !!! Значение ключа должно быть уникально !!!

// Доступ к значению конкретной пары - при помощи индексатора 
// в качестве индекса - значение ключа
// Словарь[Ключ] -- из словаря Словарь получить значение пары с ключом Ключ 

// Dictionary<TKey, TValue> - пары ключ - значение
// SortedDictionary<TKey, TValue> - пары ключ-значение, отсортировнные по ключу
// SortedList<TKey, TValue> - пары ключ-значение, отсортировнные по ключу. Отличается от 
//                            SortedDictionary использованием памяти, скоростью вставки и
//                            удаления элементов

namespace Hashtables
{
    class Program
    {
        static void Main(string[] args) {
            Console.Title = "Занятие 13.10.2021 - коллекции в C#, неупорядоченный и упорядоченный ассоциативные массивы";
            
            // HashtableDemo();
            DictionaryDemo();
        } // Main

        // пример работы с необобщенной коллекцией ключ - значение
        // интерфейс IDictionary
        private static void HashtableDemo() {
            Console.WriteLine("Работа с хэштейбл - словарем - ассоциативным массивом:\n");
            Hashtable ht = new Hashtable();

            try {
                // Добавление пар в словарь
                ht.Add("студент", "Петров А.М.");
                ht.Add("препод", "Васильева Ю.Л.");
                ht.Add("двоечник", "Сергеев Е.Г.");
                ht.Add("декан", "Грозный И.И.");
                ht.Add("удачник", "Болтай Ш.А.");
                ht.Add("игрушка", new Toy {Name = "мяч", Price = 85, AgeGroup = 12});
                ht.Add("число", 1429);

                Console.WriteLine($"\n\n\t{"[Ключ]", -15} -->  [Значение]");
                foreach (var key in ht.Keys) {
                    // !!!! Доступ по чтению к значению пары, индекс - значение ключа
                    // !!!! ht[key] -- доступ к значению по ключу
                    Console.WriteLine($"\t{key, -15} -->  {ht[key]}");
                } // foreach

                
                // выбрасывает исключение, т.к. такой ключ уже есть
                // ht.Add("студент", "Баранкин Вилли");
                ht["студент"] = "Баранкин Вилли";   // Neverhood
                Console.WriteLine($"\n\n\t{"[Ключ]",-15} -->  [Значение]");
                foreach (var key in ht.Keys) {
                    // !!!! Доступ по чтению к значению пары, индекс - значение ключа
                    // !!!! ht[key] -- доступ к значению по ключу
                    Console.WriteLine($"\t{key,-15} -->  {ht[key]}");
                } // foreach

                
                // добавление в коллецию - т.к. ключа "водитель" еще не было
                // в коллекции
                ht["водитель"] = "Тимофеев Ерофей";    // 
                Console.WriteLine($"\n\n\t{"[Ключ]",-15} -->  [Значение]");
                foreach (var key in ht.Keys) {
                    // !!!! Доступ по чтению к значению пары, индекс - значение ключа
                    // !!!! ht[key] -- доступ к значению по ключу
                    Console.WriteLine($"\t{key,-15} -->  {ht[key]}");
                } // foreach

                
                Console.WriteLine("\n\n\tТолько ключи, Keys:");
                foreach (var key in ht.Keys) {
                    Console.WriteLine($"\t{key}");
                } // foreach
                
                Console.WriteLine("\n\n\tТолько значения, Values:");
                foreach (var value in ht.Values) {
                    Console.WriteLine($"\t{value}");
                } // foreach

                // удаление по ключу
                ht.Remove("водитель");

                // Вывод на экран, пары ключ - значение
                Console.WriteLine($"\n\n\t{"[Ключ]", -15} -->  [Значение]");
                foreach (var key in ht.Keys) {
                    // !!!! Доступ по чтению к значению пары, индекс - значение ключа
                    // !!!! ht[key]
                    Console.WriteLine($"\t{key, -15} -->  {ht[key]}");
                } // foreach
            } catch (Exception ex) {
                Console.WriteLine($"\n\n\t{ex.Message}\n\n");
            } // try-catch
            
            Console.WriteLine("\n\n");
            
        } // HashtableDemo
   

        // Пример работы со словарем - как типовой пример работы с
        // обобщенными коллекциями ключ - значение
        private static void DictionaryDemo() {
            Console.WriteLine("\nРабота со словарем:");

            // Словарь - пары ключ-значение для стран и их столиц
            //         ключ    значение
            Dictionary<string, string> countries = new Dictionary<string, string> {
                // C# 5.0
                //{ "Россия", "Москва"},
                //{ "Китай", "Пекин"},
                //{ "Япония", "токио"}

                // C# 6.0   --->    [ключ] = значение 
                ["Россия"] = "Москва",
                ["Китай"] = "Пекин",
                ["Япония"] = "Киото",   // да, именно так, изменим позднее
                ["Индия"] = "Дели",
                ["Германия"] = "Берлин"

            };

            // Основные операции - добавление, чтение, модификация, удаление
            //                     Create      Read    Update       Delete
            //                     C           R       U            D
            //                     CRUD oprations --> CRUD-операции
            // countries.Keys   -- все ключи, ключи не меняются
            // countries.Values -- все значения, значения меняются

            // чтение из словаря R - read
            foreach (var item in countries) {
                Console.WriteLine($"{item.Key, -12} - {item.Value}");
            } // foreach

            // добавление в словарь C - create
            Console.WriteLine("\nДобавить запись в словарь:");
            countries.Add("Беларусь", "Минск");
            foreach (var item in countries) {
                Console.WriteLine($"{item.Key, -12} - {item.Value}");
            } // foreach

            // Сокращенный способ добавления элемента в словарь
            countries["Сирия"] = "Дамаск";
            Console.WriteLine("\nДобавить в словарь индексированием:");
            foreach (var item in countries) {
                Console.WriteLine($"{item.Key, -12} - {item.Value}");
            } // foreach

            // изменение в словаре U - update
            Console.WriteLine("\nИзменить в словаре (по ключу):");
            countries["Япония"] = "Токио";
            foreach (var item in countries) {
                Console.WriteLine($"{item.Key,-12} - {item.Value}");
            } // foreach

            // удаление из словаря D - delete
            Console.WriteLine("\nУдалить из словаря (по ключу):");
            countries.Remove("Китай");
            foreach (var item in countries) {
                Console.WriteLine($"{item.Key, -12} - {item.Value}");
            } // foreach


            // выгрузка значений или ключей в массив 
            Console.WriteLine();
            string[] capitals = countries.Values.ToArray();
            Array.Sort(capitals);
            Array.ForEach(capitals, Console.WriteLine);
            Console.WriteLine(new string('-', 80));
        
            
            // Упорядоченный словарь
            SortedDictionary<string, string> capitalsDictionary = new SortedDictionary<string, string>();
            foreach (var country in countries) {
                capitalsDictionary[country.Value] = country.Key;
            }

            Console.WriteLine($"\n\n{"Столица", -12} - страна");
            foreach (var country in capitalsDictionary) {
                Console.WriteLine($"{country.Key, -12} - {country.Value}");
            } // foreach
            
            Console.WriteLine("\nSortedDictionary:");
            SortedDictionary<string, string> sortedDictionary = new SortedDictionary<string, string>() {
                ["Россия"] = "Москва",
                ["Китай"] = "Пекин",
                ["Япония"] = "Токио",
                ["Сирия"] = "Дамаск",
                ["Ангола"] = "Луанда",
                ["Венгрия"] = "Будапешт"
            };
            foreach (var item in sortedDictionary) {
                Console.WriteLine($"{item.Key, -12} - {item.Value}");
            } // foreach
            
            sortedDictionary.Add("Беларусь", "Минск");
            sortedDictionary.Add("Монголия", "Улан-Батор");   // Жугдэрдымыдыйн Гуррагча
            Console.WriteLine("\nДобавлены элементы:");
            foreach (var item in sortedDictionary) {
                Console.WriteLine($"{item.Key, -12} - {item.Value}");
            } // foreach
            
        } // DictionaryDemo

    } // class Program
}
