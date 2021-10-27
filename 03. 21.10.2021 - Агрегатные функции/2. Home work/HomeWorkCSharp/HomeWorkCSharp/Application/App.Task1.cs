using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using HomeWorkCSharp.Models;        // модели

using static HomeWorkCSharp.Application.App.Utils;       // для использования утилит

namespace HomeWorkCSharp.Application
{
    public partial class App
    {
        #region Задание 1. Авиабилет

        /*
         * Задача 2. Напишите консольное приложение для учета заявок на авиабилеты. 
         * Каждая заявка содержит: номер заявки, пункт назначения, номер рейса, 
         * фамилию и инициалы пассажира, желаемую дату вылета. Для хранения данных 
         * использовать класс List<>.
         * 
         * Приложение должно обеспечивать выбор с помощью меню и выполнение одной 
         * из следующих функций:
         * •	формирование бинарного файла с коллекцией заявок
         * •	чтение из бинарного файла в список заявок
         * •	вывод всех заявок из коллекции в консоль
         * •	выборка в еще один список заявок по заданному номеру рейса и дате
         *      вылета при помощи именованного итератора;
         * •	добавление заявки в список, запись заявки в конец бинарного файла;
         * •	удаление заявок из списка по номеру заявки, сохранение измененной 
         *      коллекции в бинарный файла;
         * •	удаление всех заявок из списка и из бинарного файла;
         * •	упорядочивание списка заявок по номеру рейса, сохранение измененной 
         *      коллекции заявок в бинарный файл
         * •	упорядочивание списка заявок по желаемой дате рейса
        */

        // Задание 1. Авиабилет
        public void Task1()
        {
            // список заявок
            RequestTicketList list = new RequestTicketList();

            // заполнение списка
            Itinialization();

            #region Меню

            // пункты меню 
            string[] points =
            {
                "1. Формирование данных",
                "2. Вывод данных в виде таблицы",
                "3. Бинарная сериализация заявок",
                "4. Бинарная десериализация заявок",
                "5. Выборка заявок по заданному номеру рейса и дате вылета",
                "6. Добавление заявки в список, бинарная сериализация",
                "7. Удаление зявки  по номеру, бинарная сериализация",
                "8. Удаление всех зявок, бинарная сериализация",
                "9. Упорядочивание по номеру рейса, бинарная сериализация заявок",
                "Q 10. Упорядочивание по заданной дате рейса, бинарная сериализация",
                "W 11. Сериализация коллекции в формате XML",
                "E 12. Десериализация коллекции в формате XML"
            };

            // нажатая клавиша
            ConsoleKey num;

            // вывод меню
            while (true)
            {
                // отчистка консоли
                Console.Clear();

                // цвет 
                Console.ForegroundColor = ConsoleColor.Cyan;

                int x = 5, y = Console.CursorTop + 3;

                // заголовок
                Console.SetCursorPosition(x + 3, y); WriteColor($"{"    Задание 1. Авиабилет"}", ConsoleColor.Blue);

                y += 2;

                // вывод пунктов меню
                Array.ForEach(points, item => WriteColorXY(item, x, y++));

                // вывод пункта выхода из приложения
                Console.SetCursorPosition(x, ++y); Console.WriteLine("0. Выход");

                y += 4;

                // ввод номера задания
                Console.SetCursorPosition(x, y); Console.Write("Введите номер задания: ");
                num = Console.ReadKey().Key;

                try
                {

                    // обработка ввода 
                    switch (num)
                    {
                        // выход
                        case ConsoleKey.NumPad0:
                            goto case ConsoleKey.D0;
                        case ConsoleKey.Escape:
                            goto case ConsoleKey.D0;
                        case ConsoleKey.D0:
                            // позициониаровние курсора 
                            Console.SetCursorPosition(2, y + 5);
                            return;

                        // 1. Формирование данных
                        case ConsoleKey.NumPad1:
                            goto case ConsoleKey.D1;
                        case ConsoleKey.D1:
                            Console.Clear();
                            // запуск задания 
                            Point1();
                            break;

                        // 2. Вывод данных в виде таблицы
                        case ConsoleKey.NumPad2:
                            goto case ConsoleKey.D2;
                        case ConsoleKey.D2:
                            Console.Clear();
                            // запуск задания 
                            Point2();
                            break;

                        // 3. Бинарная сериализация заявок
                        case ConsoleKey.NumPad3:
                            goto case ConsoleKey.D3;
                        case ConsoleKey.D3:
                            Console.Clear();
                            // запуск задания 
                            Point3();
                            break;

                        // 4. Бинарная десериализация заявок
                        case ConsoleKey.NumPad4:
                            goto case ConsoleKey.D4;
                        case ConsoleKey.D4:
                            Console.Clear();
                            // запуск задания 
                            Point4();
                            break;

                        // 5. Выборка заявок по заданному номеру рейса и дате вылета
                        case ConsoleKey.NumPad5:
                            goto case ConsoleKey.D5;
                        case ConsoleKey.D5:
                            Console.Clear();
                            // запуск задания 
                            Point5();
                            break;

                        // 6. Добавление заявки в список, бинарная сериализация
                        case ConsoleKey.NumPad6:
                            goto case ConsoleKey.D6;
                        case ConsoleKey.D6:
                            Console.Clear();
                            // запуск задания 
                            Point6();
                            break;

                        // 7. Удаление зявки  по номеру, бинарная сериализация
                        case ConsoleKey.NumPad7:
                            goto case ConsoleKey.D7;
                        case ConsoleKey.D7:
                            Console.Clear();
                            // запуск задания 
                            Point7();
                            break;

                        // 8. Удаление всех зявок, бинарная сериализация
                        case ConsoleKey.NumPad8:
                            goto case ConsoleKey.D8;
                        case ConsoleKey.D8:
                            Console.Clear();
                            // запуск задания 
                            Point8();
                            break;

                        // 9. Упорядочивание по номеру рейса, бинарная сериализация заявок
                        case ConsoleKey.NumPad9:
                            goto case ConsoleKey.D9;
                        case ConsoleKey.D9:
                            Console.Clear();
                            // запуск задания 
                            Point9();
                            break;

                        // 10. Упорядочивание по заданной дате рейса
                        case ConsoleKey.Q:
                            Console.Clear();
                            // запуск задания 
                            Point10();
                            break;

                        // 11. Сериализация коллекции в формате XML
                        case ConsoleKey.W:
                            Console.Clear();
                            // запуск задания 
                            Point11();
                            break;

                        // 12. Десериализация коллекции в формате XML
                        case ConsoleKey.E:
                            Console.Clear();
                            // запуск задания 
                            Point12();
                            break;

                        // если номер задания невалиден
                        default:

                            // установка цвета
                            Console.BackgroundColor = ConsoleColor.DarkRed;
                            Console.ForegroundColor = ConsoleColor.Black;

                            // позиционирование курсора
                            Console.SetCursorPosition(x, y); Console.WriteLine("         Номер задания невалиден!         ");

                            // выключение курсора
                            Console.CursorVisible = false;

                            // задержка времени
                            Thread.Sleep(1000);

                            // возвращение цвета
                            Console.ResetColor();

                            // включение курсора
                            Console.CursorVisible = true;

                            break;
                    } // switch
                } // try

                // стандартное исключение
                catch (Exception ex)
                {
                    Console.Clear();

                    // вывод сообщения об ошибке 
                    WriteColor(ex.Message, ConsoleColor.Red);
                    Console.WriteLine();
                    WriteColor(ex.StackTrace, ConsoleColor.Red);
                    Console.WriteLine();
                } // catch

                // обязательная часть
                finally
                {
                    // если пункт меню 0
                    if (num != ConsoleKey.D0 && num != ConsoleKey.NumPad0 && num != ConsoleKey.Escape)
                    {
                        // ввод клавиши для продолжения 
                        WriteColor("\n\n\tНажмите на [Enter] для продолжения...", ConsoleColor.Cyan);
                        Console.CursorVisible = false;
                        while (Console.ReadKey(true).Key != ConsoleKey.Enter) ;
                        Console.CursorVisible = true;
                    }
                } // finally
            } // while

            #endregion

            #region 1. Формирование данных

            // 1. Формирование данных
            void Point1()
            {
                ShowNavBarMessage("1. Формирование данных");

                // заполнение списка
                Itinialization();

                // вывод заполненного списка
                list.ShowTable(info: "После заполнения");
            }

            // заполнение списка
            void Itinialization()
            {
                // очистка списка
                list.Clear();

                // количество записей
                int n = GetInt(10, 15);

                // заполенение списка заявок
                for (int i = 0; i < n; i++)
                    list.AddRequest(FactoryMethodRequest());
            }

            // фабричный метод заявки
            RequestOnTicket FactoryMethodRequest()
            {
                // массив фамилий
                string[] surnames = new[]
                {
                    "Сазонов ",
                    "Третьяков ",
                    "Родионов ",
                    "Мазайло ",
                    "Брагин ",
                    "Власов ",
                    "Алексеев ",
                    "Прохоров ",
                    "Рыбаков",
                    "Богданов "
                };

                // массив иниалов
                string[] initials = new[]
                {
                    "Е. Я.",
                    "А. Ф.",
                    "Н. А.",
                    "В. И.",
                    "Т. Л.",
                    "Т. М.",
                    "У. Т.",
                    "Н. М.",
                    "И. Г.",
                    "Я. С."
                };


                // массив мест назначения
                string[] pointDest = new[]
                {
                    "Гонконг",
                    "Лондон",
                    "Сингапур",
                    "Бангкок",
                    "Париж",
                    "Макао",
                    "Дубай",
                    "Шеньчжень",
                    "Майами",
                    "Нью-Йорк"
                };

                // массив бувенный код номера рейса 
                string[] code = new[]
                {
                    "AC ",
                    "SK ",
                    "AM ",
                    "SU ",
                };

                // создание заявки
                return new RequestOnTicket
                {
                    NumberFlight = code[GetInt(0, code.Length)] + GetInt(1000, 10000),
                    PointDest = pointDest[GetInt(0, pointDest.Length)],
                    Name = surnames[GetInt(0, surnames.Length)] + initials[GetInt(0, initials.Length)],
                    Date = new DateTime(2022, GetInt(1, 13), GetInt(1, 28))
                };

            }

            #endregion

            #region 2. Вывод данных в виде таблицы

            // 2. Вывод данных в виде таблицы
            void Point2()
            {
                ShowNavBarMessage("2. Вывод данных в виде таблицы");

                // вывод списка
                list.ShowTable();
            }

            #endregion

            #region 3. Бинарная сериализация заявок

            // 3. Бинарная сериализация заявок
            void Point3()
            {
                ShowNavBarMessage("3. Бинарная сериализация заявок");

                // бинарная сериализация
                list.BinarySerializationList();

                // вывод списка для сохранения
                list.ShowTable("Сериализация");
            }

            #endregion

            #region 4. Бинарная десериализация заявок

            // 4. Бинарная десериализация заявок
            void Point4()
            {
                ShowNavBarMessage("4. Бинарная десериализация заявок");

                // бинарная десериализация
                list.BinaryDeserializationList();

                // вывод списка после загрузки из файла
                list.ShowTable("После десериализации");
            }

            #endregion

            #region 5. Выборка заявок по заданному номеру рейса и дате вылета

            // 5. Выборка заявок по заданному номеру рейса и дате вылета
            void Point5()
            {
                ShowNavBarMessage("5. Выборка заявок по заданному номеру рейса и дате вылета");

                // индекс элемента для данных
                var selItem = list[GetInt(0, list.Length)];

                // коллекция для выборки
                List<RequestOnTicket> select = new List<RequestOnTicket>();

                // выборка заявок по заданному номеру рейса и дате вылета
                foreach (var item in list.IterByNumFlightAndDate(selItem.NumberFlight, selItem.Date))
                    select.Add(item);

                // вывод списка 
                list.ShowTable();

                // вывод выбранных данных
                RequestTicketList.ShowHead(select.Count, name: "Отобранные данные", info: $"{selItem.NumberFlight} {selItem.Date:d}");
                RequestTicketList.ShowElements(select);
                RequestTicketList.ShowLine();
            }

            #endregion

            #region 6. Добавление заявки в список, бинарная сериализация

            // 6. Добавление заявки в список, бинарная сериализация
            void Point6()
            {
                ShowNavBarMessage("6. Добавление заявки в список, бинарная сериализация");

                // добавление в список элемента 
                list.AddRequest(FactoryMethodRequest());

                // вывод списка 
                list.ShowTable(info: $"Добавлен с номером заявки {list[list.Length - 1].NumberRequest}");
            }

            #endregion

            #region 7. Удаление зявки  по номеру, бинарная сериализация

            // 7. Удаление зявки  по номеру, бинарная сериализация
            void Point7()
            {
                ShowNavBarMessage("7. Удаление зявки  по номеру, бинарная сериализация");

                // удалённый элемент
                var delItem = list[GetInt(0, list.Length)];

                // удаление элемента
                list.RemoveRequest(delItem.NumberRequest);

                // вывод списка 
                list.ShowTable(info: $"Удалён с номером заявки {delItem.NumberRequest}");
            }

            #endregion

            #region 8. Удаление всех зявок, бинарная сериализация

            // 8. Удаление всех зявок, бинарная сериализация
            void Point8()
            {
                ShowNavBarMessage("8. Удаление всех зявок, бинарная сериализация");

                // вывод списка 
                list.ShowTable(info: $"До очистки");

                Console.WriteLine();

                // очистка 
                list.Clear();

                // вывод списка 
                list.ShowTable(info: $"После очистки");
            }

            #endregion

            #region 9. Упорядочивание по номеру рейса, бинарная сериализация заявок

            // 9. Упорядочивание по номеру рейса, бинарная сериализация заявок
            void Point9()
            {
                ShowNavBarMessage("9. Упорядочивание по номеру рейса, бинарная сериализация заявок");

                // упорядочивание
                list.OrderByNumberFlight();

                // вывод списка 
                list.ShowTable(info: $"После упорядочивания");
            }

            #endregion

            #region 10. Упорядочивание по заданной дате рейса, бинарная сериализация

            // 10.  Упорядочивание по заданной дате рейса, бинарная сериализация
            void Point10()
            {
                ShowNavBarMessage("10.  Упорядочивание по заданной дате рейса, бинарная сериализация");

                // упорядочивание
                list.OrderByDate();

                // вывод списка 
                list.ShowTable(info: $"После упорядочивания");
            }

            #endregion

            #region 11. Сериализация коллекции в формате XML

            // 11. Сериализация коллекции в формате XML
            void Point11()
            {
                ShowNavBarMessage("11. Сериализация коллекции в формате XML");

                // XML сериализация
                list.XMLSerializationList();

                // вывод списка 
                list.ShowTable(info: $"XML Сериализация");
            }

            #endregion

            #region 12. Десериализация коллекции из формата XML

            // 12. Десериализация коллекции из формата XML
            void Point12()
            {
                ShowNavBarMessage("12. Десериализация коллекции из формата XML");

                // XML десериализация
                list.XMLDeserializationList();

                // вывод списка 
                list.ShowTable(info: $"XML Десериализация");
            }

            #endregion

        }

        #endregion
    }
}
