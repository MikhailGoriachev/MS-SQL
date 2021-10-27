using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;       // бинарная серилизация
using System.Xml.Serialization;     // XML сериализация

using static HomeWorkCSharp.Application.App.Utils;      // утилиты

namespace HomeWorkCSharp.Models
{
    // класс Список заявок на авиабилеты
    public class RequestTicketList : IEnumerable
    {
        #region Свойства

        // список заявок
        public List<RequestOnTicket> Requests { get; set; }

        // размер списка заявок
        public int Length { get => Requests.Count; }

        // название файла для сохранения в бинарном виде
        public string NameSaveBinaryFile { get; set; }

        // название файла для сохранения в XML виде
        public string NameSaveXMLFile { get; set; }

        #endregion

        #region Конструкторы, индексатор

        // конструктор по умолчанию
        public RequestTicketList() : this(new List<RequestOnTicket>(), @"..\..\TicketsBase.bin", @"..\..\TicketsBase.xml") { }

        // конструктор инициализирующий
        public RequestTicketList(List<RequestOnTicket> requests, string nameSaveBinaryFile, string nameSaveXMLFile)
        {
            // установка значений
            Requests = requests;
            NameSaveBinaryFile = nameSaveBinaryFile;
            NameSaveXMLFile = nameSaveXMLFile;
        }

        // индексатор
        public RequestOnTicket this[int index]
        {
            get => isIndex(index) ? Requests[index] : 
                throw new IndexOutOfRangeException($"RequestTicketList: Выход за " +
                    $"пределы коллекции! Значение индекса: {index}");

            set => Requests[index] = isIndex(index) ? value :
                throw new IndexOutOfRangeException($"RequestTicketList: Выход за " +
                    $"пределы коллекции! Значение индекса: {index}");
        }

        // проверка индекса на корректность
        private bool isIndex(int index) => index >= 0 && index < Requests.Count();

        #endregion

        #region Методы

        // бинарная сериализация списка
        public void BinarySerializationList()
        {
            // сохранение всех элементов в файл
            using (FileStream fs = new FileStream(NameSaveBinaryFile, FileMode.Create, FileAccess.Write))
            {
                // форматтер 
                BinaryFormatter formatter = new BinaryFormatter();

                // сериализация коллекции
                formatter.Serialize(fs, Requests);                             
            }
        }

        // бинарная десериализация списка
        public void BinaryDeserializationList()
        {
            // загрузка всех элементов из файла в список
            using (FileStream fs = new FileStream(NameSaveBinaryFile, FileMode.OpenOrCreate, FileAccess.Read))
            {
                // очистка списка 
                Requests.Clear();

                // форматтер 
                BinaryFormatter formatter = new BinaryFormatter();

                // десериализация коллекции
                Requests = formatter.Deserialize(fs) as List<RequestOnTicket>;
            }
        }

        // XML сериализация списка
        public void XMLSerializationList()
        {            
            using (FileStream fs = new FileStream(NameSaveXMLFile, FileMode.Create, FileAccess.Write))
            {
                // сериализатор
                XmlSerializer serializer = new XmlSerializer(typeof(List<RequestOnTicket>));

                // сериализация
                serializer.Serialize(fs, Requests);
            }
        }

        // XML десериализация списка
        public void XMLDeserializationList()
        {
            using (FileStream fs = new FileStream(NameSaveXMLFile, FileMode.OpenOrCreate, FileAccess.Read))
            {
                // сериализатор
                XmlSerializer serializer = new XmlSerializer(typeof(List<RequestOnTicket>));

                // десериализация
                Requests = serializer.Deserialize(fs) as List<RequestOnTicket>;
            }
        }

        // именованный итератор по заявкам с заданным номером рейса и датой вылета
        public IEnumerable<RequestOnTicket> IterByNumFlightAndDate(string numberFlight, DateTime date)
        {
            for (int i = 0; i < Requests.Count(); i++)
                if (Requests[i].NumberFlight == numberFlight && Requests[i].Date == date)
                    yield return Requests[i];
        }

        // добавление заявки в список и файл
        public void AddRequest(RequestOnTicket request)
        {
            // добавление заявки в список
            Requests.Add(request);

            // сериализация модифицированной коллекции
            BinarySerializationList();
        }

        // удаление заявки по номеру заявки из списка и сохранение списка в файл
        public void RemoveRequest(int numberRequest)
        {
            // добавление заявки в список
            Requests.Remove(Requests.Find(item => item.NumberRequest == numberRequest));

            // сериализация модифицированной коллекции
            BinarySerializationList();
        }

        // очистка списка и файла
        public void Clear()
        {
            // отчистка файла
            Requests.Clear();

            // сериализация модифицированной коллекции
            BinarySerializationList();
        }

        // упорядочивание по номеру рейса 
        public void OrderByNumberFlight()
        {
            // упорядочивание по номеру рейса
            Requests.Sort((item1, item2) => item1.NumberFlight.CompareTo(item2.NumberFlight));

            // сериализация модифицированной коллекции
            BinarySerializationList();
        }

        // упорядочивание по желаемой дате рейса 
        public void OrderByDate()
        {
            // упорядочивание по желаемой дате рейса
            Requests.Sort((item1, item2) => item1.Date.CompareTo(item2.Date));

            // сериализация модифицированной коллекции
            BinarySerializationList();
        }

        // реализация интерфейса IEnumerable
        public IEnumerator GetEnumerator() => Requests.GetEnumerator();

        // вывод списка в таблицу
        public void ShowTable(string name = "Заявки", string info = "Исходные данные")
        {
            // вывод шапки таблицы
            ShowHead(Requests.Count, name, info);

            // вывод элементов в таблицу
            ShowElements(Requests);

            // вывод подавала таблицы
            ShowLine();
        }

        // вывод шапки таблицы
        public static void ShowHead(int size, string name = "Заявки", string info = "Исходные данные")
        {
            //                       10                     30                                    41
            WriteColorXY("     ╔════════════╦════════════════════════════════╦═══════════════════════════════════════════╗\n", textColor:ConsoleColor.Magenta);
            WriteColorXY("     ║            ║                                ║                                           ║", textColor:ConsoleColor.Magenta);
            WriteColorXY("Размер: ", 7, textColor: ConsoleColor.DarkYellow);
            WriteColorXY($"{size, 2}", textColor: ConsoleColor.Green);
            WriteColorXY("Название: ", 20, textColor: ConsoleColor.DarkYellow);
            WriteColorXY($"{name,-20}", textColor: ConsoleColor.Green);
            WriteColorXY("Инфо: ", 53, textColor: ConsoleColor.DarkYellow);
            WriteColorXY($"{info,-35}", textColor: ConsoleColor.Green);
            Console.WriteLine();

            //                    2       10                20                10                20                10
            WriteColorXY("     ╠════╦═══════╩════╦══════════════════════╦════╩═══════╦══════════════════════╦════════════╣\n", textColor: ConsoleColor.Magenta);
            WriteColorXY("     ║    ║            ║                      ║            ║                      ║            ║", textColor:ConsoleColor.Magenta);
            WriteColorXY("N ", 7, textColor: ConsoleColor.DarkYellow);
            WriteColorXY("  Заявка  ", 12, textColor: ConsoleColor.DarkYellow);
            WriteColorXY("  Пункт назначения  ", 25, textColor: ConsoleColor.DarkYellow);
            WriteColorXY("   Рейс   ", 48, textColor: ConsoleColor.DarkYellow);
            WriteColorXY("     Покупатель     ", 61, textColor: ConsoleColor.DarkYellow);
            WriteColorXY("Жел. дата ", 84, textColor: ConsoleColor.DarkYellow);
            Console.WriteLine();

            WriteColorXY("     ╠════╬════════════╬══════════════════════╬════════════╬══════════════════════╬════════════╣\n", textColor: ConsoleColor.Magenta);
        }

        // вывод элементов в таблицу
        public static void ShowElements(IEnumerable<RequestOnTicket> collection)
        {
            // порядковый номер элемента
            int i = 1;

            // вывод элементов
            foreach (var item in collection)
                item.ShowElem(i++);
        }

        // вывод подвала таблицы
        public static void ShowLine() =>
            WriteColorXY("     ╚════╩════════════╩══════════════════════╩════════════╩══════════════════════╩════════════╝\n", textColor: ConsoleColor.Magenta);

        #endregion
    }
}
