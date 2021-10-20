// ObservableCollection<T> - определен в System.Collection.ObjectModel,
// по функционалу - похож на список (List), может извещать внешние объекты
// о том, что коллекция была изменена 
// !! не умеет извещать об изменении элемента коллекции               !!
// !! такой функционал должен быть добавлен типу, которым закрывается !!
// !! коллекция                                                       !!

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel; // для ObservableCollection<T>
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ObservableCollectionDemo
{
    class Program
    {
        static void Main(string[] args) {
            Console.Title = "Занятие 13.10.2021 - коллекции в C# - ObservableCollection";
            
            ObservableCollectionDemo();
        } // Main

        
        // Коллекция ObservableCollection - список с уведомлениями об
        // изменении списка (!! не элементов !!) 
        private static void ObservableCollectionDemo() {
            ObservableCollection<User> users = new ObservableCollection<User> {
                new User { Name = "Наталья",  Age = 22},
                new User { Name = "Алекс",    Age = 21},
                new User { Name = "Оля",      Age = 19},
                new User { Name = "Иван",     Age = 22},
                new User { Name = "Полина",   Age = 23}
            };

            // назначить обработчик события изменения коллекции
            users.CollectionChanged += CollectionChangedEventHandler;
            Show("\nПользователи:\n", users);

            // вызовы, меняющие коллекцию
            
            // добавление - create
            users.Add(new User { Name = "Женя", Age = 23 });
            Show("\nДобавлен пользователь, теперь пользователи:\n", users);
            
            // удаление - delete
            users.RemoveAt(3);
            Show("\nУдален пользователь с индексом 3, теперь пользователи:\n", users);
            
            // заменена - replace 
            users[1] = new User { Name = "Стиви", Age = 89};
            Show("\nЗамена пользователя с индексом 1 на другого, пользователи:\n", users);
            
            // !!! изменение элемента не вызывает события !!!
            users[1].Age -= 70;
            users[1].Name = "Ренат";
            Show("\nИзменен пользователь с индексом 1, теперь пользователи:\n", users);

            // перемещение пользователей по списку
            users.Move(0, users.Count-1);
            Show("\nПервая и последняя записи поменялись местами, теперь пользователи:\n", users);

            users.Clear();
            Show("\nИз списка удалены все элементы:\n", users);
        } // ObservableCollectionDemo


        // Обработчик события CollectionChanged 
        private static void CollectionChangedEventHandler(object sender, NotifyCollectionChangedEventArgs e)
        {
            ConsoleColor old = Console.ForegroundColor;
            Console.ForegroundColor = ConsoleColor.DarkYellow;
            Console.Write("\nВ обработчике! ");

            switch (e.Action) {
                case NotifyCollectionChangedAction.Add:
                    Console.WriteLine($"Операция добавления. Добавлен {(User)e.NewItems[0]}");
                    break;
                case NotifyCollectionChangedAction.Remove:
                    Console.WriteLine($"Операция удаления. Удален {(User)e.OldItems[0]}");
                    break;
                case NotifyCollectionChangedAction.Replace:
                    Console.WriteLine($"Операция замены: {(User)e.OldItems[0]} на {(User)e.NewItems[0]}");
                    break;
                case NotifyCollectionChangedAction.Move:
                    Console.WriteLine($"Операция перемещения/обмена: {e.OldStartingIndex} и {e.NewStartingIndex}");
                    break;
                case NotifyCollectionChangedAction.Reset:
                    Console.WriteLine("Операция очистки");
                    break;
                default:
                    Console.WriteLine("Операция не распознана");
                    break;
            } // switch

            Console.ForegroundColor = old;
        } // CollectionChangedEventHandler


        // вывод коллекции 
        static void Show(string title, ICollection<User> userList) {
            // собрать строку и вывести в консоль
            StringBuilder sb = new StringBuilder(title);
            
            // Спасибо IEnumerable - за этот чудный foreach
            foreach (var item in userList) {
                sb.Append($"{item}\n");
            } // foreach

            Console.WriteLine(sb);
        } // Show
    } // class Program
}
