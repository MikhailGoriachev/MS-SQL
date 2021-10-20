using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lists
{
    class Program
    {
        static void Main(string[] args) {

            Console.Title = "Занятие 13.10.2021 - обобщенная колекция List<>";

            // DemoBasic();

            DemoReference();

            Console.ReadLine();
        } // Main


        // список элементов базового типа, в данном случае int
        public static void DemoBasic() {
            // вывод элемента списка целых чисел
            // string f(int);
            Func<int, string> outIntItem = x => $"{x,8}";

            // List<int> numbers = new List<int>();
            // List<int> numbers = new List<int>(10); // емкость
            List<int> numbers = new List<int>() { 98, -21, 33, 42 };

            numbers.Add(-26); // добавление элемента
            Show("\nСформирован список целых          : ", numbers, outIntItem);

            // добавление коллекции элементов 
            numbers.AddRange(new int[] { -17, 8, 19 });
            Show("\nДобавлена коллекция в список целых: ", numbers, outIntItem);
            
            // вставка элемента в 0-ю позицию
            numbers.Insert(0, -13);
            Show("\nВставлен элемент в 0-ю позицию    : ", numbers, outIntItem);

            // чтение по индексу
            int last = numbers.Count - 1;
            Console.WriteLine($"\nПервый и последний элементы       : {numbers[0], 8}{" ".PadRight((8*(numbers.Count-2)))}{numbers[last], 8}");

            // изменить элемент по индексу:
            numbers[0] = 888;
            numbers[last] = 777;
            Show("\nПервый и последний изменены       : ", numbers, outIntItem);

            // удаление элемента из 1-й позиции
            numbers.RemoveAt(1);
            Show("\nУдален элемент из 1-й позиции     : ", numbers, outIntItem);

            // удаление всех отрицательных в стиле C
            // int n = numbers.Count;
            // for (int i = n - 1; i >= 0; i--)
            //     if (numbers[i] < 0) {
            //         numbers.RemoveAt(i);
            //         ++i;
            //     } // if
            // Show("\nТолько положительные элементы     : ", numbers, outIntItem);

            // сортировка элементов по убыванию модулей
            numbers.Sort((x, y) => Math.Abs(y).CompareTo(Math.Abs(x)));
            Show("\nСписок по убыванию модулей        : ", numbers, outIntItem);

            // сортировка по правилу "отрицательные в начало списка"
            numbers.Sort((x, y) => x < 0 && y >= 0?-1:x >= 0 && y < 0?1:0);
            Show("\nСписок по спец. правилу           : ", numbers, outIntItem);

            // выборка всех положительных в другой список
            List<int> positives = numbers.FindAll(x => x >= 0);
            Show("\nВсе положительные элементы        : ", positives, outIntItem);

        } // DemoBasic


        // Список объектов ссылочного типа
        public static void DemoReference() {
            // вывод элемента списка ссылочного типа
            Func<Toy, string> outItem = t => $"{t}\n";

            // Список элементов ссылочного типа
            // List<Toy> toys = new List<Toy>(3);
            // List<Toy> toys = new List<Toy>();
            List<Toy> toys = new List<Toy>(new[] {
                new Toy { Name = "Детская кухня", Price = 1260, AgeGroup = 12 },
                new Toy { Name = "Осьминожка", Price = 430, AgeGroup = 5 }
            });

            // Основные операции - добавление, чтение, модификация, удаление
            //                     Create      Read    Update       Delete
            //                     C           R       U            D

            toys.Add(new Toy { Name = "Мяч резиновый", Price = 190, AgeGroup = 3 });
            toys.Add(new Toy { Name = "Грузовик-трансформер", Price = 1830, AgeGroup = 5 });
            Show("\nСформирован список игрушек:\n", toys, outItem);
            
            // добавление коллекции элементов 
            toys.AddRange(new Toy[] {
                new Toy { Name = "Пирамидка",             Price =  120, AgeGroup = 1 },
                new Toy { Name = "Кубик Рубика",          Price =  320, AgeGroup = 7 },
                new Toy { Name = "Автомат светозвуковой", Price =  620, AgeGroup = 12 },
                new Toy { Name = "Кукла Маша",            Price =  210, AgeGroup = 7 },
                new Toy { Name = "Ёжик",                  Price =  330, AgeGroup =  5}
            });
            Show("\nДобавлена коллекция в список игрушек:\n", toys, outItem);

            // вставка элемента в 0-ю позицию
            toys.Insert(0, new Toy { Name = "Слон Элвис", Price = 1800, AgeGroup = 10 });
            Show("\nВставлен элемент в 0-ю позицию списка игрушек:\n", toys, outItem);

            // изменение элемента во 2-й позиции
            toys[2].Price += 100;
            Show("\nИзменена цена игрушки во 2-й позиции         :\n", toys, outItem);

            // удаление элемента из 1-й позиции
            toys.RemoveAt(1);
            Show("\nУдален элемент из 1-й позиции списка игрушек:\n", toys, outItem);

            
            // сортировка
            toys.Sort((t1, t2) => t1.Name.CompareTo(t2.Name));
            Show("\nСписок игрушек по названию:\n", toys, outItem);

            toys.Sort((t1, t2) => t2.AgeGroup.CompareTo(t1.AgeGroup));
            Show("\nСписок игрушек по убыванию возрастной категории:\n", toys, outItem);

            // выборка (игрушки с ценой в заданном диапазоне), упорядоченные по убыванию цены
            int loPrice = 100, hiPrice = 800;
            List<Toy> selected = toys.FindAll(t => loPrice <= t.Price && t.Price <= hiPrice);
            selected.Sort((t1, t2) => t2.Price.CompareTo(t1.Price));
            Show($"\nИгрушки с ценой в диапазоне [{loPrice:n2}, ..., {hiPrice:n2}],\n" +
                 $"(по убыванию цены):\n",
                selected, outItem);
        } // DemoReferences

        // вывод коллекции, title - заголовок, items - собственно коллекция,
        // outItem - делегат метода вывода
        // static void Show<T>(string title, ICollection<T> items, Func<T, string> outItem) {
        // static void Show<T>(string title, IList<T> items, Func<T, string> outItem) {
        static void Show<T>(string title, IEnumerable<T> items, Func<T, string> outItem) {
            // собрать строку и вывести в консоль
            StringBuilder sb = new StringBuilder(title);

            // Спасибо IEnumerable - за этот чудный foreach
            foreach (var item in items) {
                sb.Append(outItem(item));
            } // foreach

            Console.WriteLine(sb);
        } // Show
    } // class Program
}

