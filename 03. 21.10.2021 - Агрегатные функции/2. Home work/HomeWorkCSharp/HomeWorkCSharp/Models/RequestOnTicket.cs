using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;       // бинарная сериализация

using static HomeWorkCSharp.Application.App.Utils;      // утилиты

namespace HomeWorkCSharp.Models
{
    // декоратор для бинарной и XML сериализации
    [Serializable]

    // класс Заявка на авиабилет
    public class RequestOnTicket
    {        
        // следующий номер заявки
        private static int _next;

        // номер заявки 
        private int _numberRequest;

        // пункт назначения
        private string _pointDest;

        // номер рейса 
        private string _numberFlight;

        // фамилия и инициалы покупатели
        private string _name;

        // желаемая дата вылета
        private DateTime _date;

        // перечесление размеров полей
        enum SizeField
        { 
            LengthPointDest = 40,
            LengthNumberFlight = 7,
            LengthName = 30,
        }

        #region Свойства 

        // доступ к полю _numberRequest
        public int NumberRequest { get => _numberRequest;  set => _numberRequest = value; }

        // доступ к полю _pointDest
        public string PointDest { get => _pointDest; 
            set => _pointDest = (!String.IsNullOrWhiteSpace(value) || value.Length < (int)SizeField.LengthPointDest) ? value : 
                throw new Exception($"RequestOnTicket: поле PointDest не может быть пустым или длинее " +
                    $"{SizeField.LengthPointDest} символов! Текущий размер: {value.Length}"); }

        // доступ к полю _numberFlight
        public string NumberFlight
        {
            get => _numberFlight;
            set => _numberFlight = (!String.IsNullOrWhiteSpace(value) || value.Length < (int)SizeField.LengthNumberFlight) ? value :
                throw new Exception($"RequestOnTicket: поле NumberFlight не может быть пустым или длинее " +
                    $"{SizeField.LengthNumberFlight} символов! Текущий размер: {value.Length}");
        }

        // доступ к полю _name
        public string Name
        {
            get => _name;
            set => _name = (!String.IsNullOrWhiteSpace(value) || value.Length < (int)SizeField.LengthName) ? value :
                throw new Exception($"RequestOnTicket: поле Name не может быть пустым или длинее " +
                    $"{SizeField.LengthName} символов! Текущий размер: {value.Length}");
        }

        // доступ к полю _date
        public DateTime Date
        {
            get => _date;
            set => _date = value;
        }

        // размер объекта в бинарном виде 
        public static int BinaryLength { get => sizeof(int) + (int)SizeField.LengthNumberFlight + (int)SizeField.LengthPointDest + (int)SizeField.LengthName + sizeof(long); }

        #endregion

        #region Конструкторы 

        // конструктор по умолчанию
        public RequestOnTicket()
        {
            // установка значений
            _numberRequest = _next++;
        }

        // конструктор статический
        static RequestOnTicket()
        {
            // установка зачений 
            _next = 1_000_000;
        }

        #endregion

        #region Методы

        // запись в бинарный файл
        public void Serialization(FileStream fs)
        {
            // форматтер
            BinaryFormatter formatter = new BinaryFormatter();

            // сериализация в файловый поток
            formatter.Serialize(fs, typeof(RequestOnTicket));
        }

        // чтение из бинарного файла
        public static RequestOnTicket Deserialization(FileStream fs)
        {
            // форматтер 
            BinaryFormatter formatter = new BinaryFormatter();

            // десериализация из файлового потока
            RequestOnTicket ticket = formatter.Deserialize(fs) as RequestOnTicket;

            // если текущий номер заявки равен значению поля _next 
            if (ticket._numberRequest == _next) _next++;

            return ticket;
        }

        // вывод элемента в таблицу
        public void ShowElem(int num)
        {
            WriteColorXY("     ║    ║            ║                      ║            ║                      ║            ║", textColor: ConsoleColor.Magenta);
            WriteColorXY($"{num, 2}", 7, textColor: ConsoleColor.DarkGray);
            WriteColorXY($"{_numberRequest, 10}", 12, textColor: ConsoleColor.Cyan);
            WriteColorXY($"{_pointDest, -20}", 25, textColor: ConsoleColor.Green);
            WriteColorXY($"{_numberFlight, -10}", 48, textColor: ConsoleColor.Cyan);
            WriteColorXY($"{_name, -20}", 61, textColor: ConsoleColor.Green);
            WriteColorXY($"{_date:d}", 84, textColor: ConsoleColor.Cyan);
            Console.WriteLine();
        }

        #endregion
    }
}
