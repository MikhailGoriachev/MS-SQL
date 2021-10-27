using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

// для сериализации/десериализации в XML-формате
using System.Xml.Serialization;

using XMLserialization.Models;

namespace XMLserialization
{
    class Program
    {
        static void Main(string[] args) {
            Console.Title = "Занятие 21.10.2021 - сериализация в XML формат и десериализация из XML формата";

            // работа с одним объектом
            // SimpleDemo("../../person.xml");
            // Console.WriteLine("───────────────────────────────────────────────────\n");

            // работа с коллекцией объектов
            // CollectionDemo("../../people.xml");
            // Console.WriteLine("───────────────────────────────────────────────────\n");

            // работа с колекцией сложных объектов (ссылки на другие объекты)
            ComplexObjectDemo("../../workers.xml");
            Console.WriteLine("───────────────────────────────────────────────────\n\n\n");
        } // Main

        // Работаем с одним объектом
        private static void SimpleDemo(string fileName) {
            // объект для сериализации
            Person person = new Person("Егорова", "Света", 29);
            Console.WriteLine($"Объект создан, {person}\n");

            // передаем в конструктор форматтера тип класса
            XmlSerializer formatter = new XmlSerializer(typeof(Person));

            // получаем поток данных, куда будем записывать сериализованный объект
            using (FileStream fs = new FileStream(fileName, FileMode.Create)) {
                formatter.Serialize(fs, person);
            }
            Console.WriteLine("Объект сериализован");

            // удаление данных объекта для чистоты эксперимента
            Person newPerson = null;

            // десериализация из XML
            using (FileStream fs = new FileStream(fileName, FileMode.OpenOrCreate)) {
                newPerson = formatter.Deserialize(fs) as Person;
            }
            Console.WriteLine($"\nОбъект десериализован, {newPerson}");
        } // SimpleDemo


        // Работа с коллекцией простых объектов (не содержащих ссылки на другие объекты)
        private static void CollectionDemo(string fileName) {
            Console.WriteLine("\n\nСериализация...");
            
            Person[] people = {
                new Person("Иванова", "Марина", 29),
                new Person("Романов", "Леонид", 25),
                new Person("Серова",  "Ирина", 23),
                new Person("Иванов",  "Андрей", 24),
                new Person("Бацуца",  "Арсений", 38),
                new Person("Вятчина", "Кристина", 28)
            };
            List<Person> listPerson = new List<Person>(people);
            
            // вывод коллекции до сериализации
            listPerson.ForEach(Console.WriteLine);

            // форматтер для сериализации
            XmlSerializer formatter = new XmlSerializer(typeof(List<Person>));

            // запись коллекции в поток данных
            using (FileStream fs = new FileStream(fileName, FileMode.Create)) {
                formatter.Serialize(fs, listPerson);
            } // using

            Console.WriteLine("\n\nДесериализация...");
            List<Person> newPeople = null;
            using (FileStream fs = new FileStream(fileName, FileMode.OpenOrCreate)) {
                newPeople = (List<Person>)formatter.Deserialize(fs);
            }
            
            // вывод коллекции после десерилаизации
            newPeople.ForEach(Console.WriteLine);
        } // CollectionDemo


        // сериализация и десериализация сложного объекта
        private static void ComplexObjectDemo(string fileName) {
            List<Worker> workers = new List<Worker>(new [] {
                new Worker("Иванова",  "Марина", 29, new Company("Contoso", 23e6)),
                new Worker("Романов",  "Леонид", 25, new Company("Contoso", 23e6)),
                new Worker("Серова",   "Ирина",  23, new Company("Amazon",   23000)),
                new Worker("Безос",    "Джефф",  23, new Company("Amazon",   23000)),
                new Worker("Михайлов", "Игорь",  37, new Company("Борей",   23000)),
                new Worker("Маск",     "Илон",   42, new Company("SpaceX",  5e8)),
                new Worker("Старк",    "Тони",   48, new Company("Stark Industries", 12e8))
            });

            // показать то, что попытаемся сериализовать 
            Console.WriteLine("\nСериализация:");
            workers.ForEach(Console.WriteLine);

            // объект класса XmlSerializer - форматирует другие объекты в XML
            // XmlSerializer formatter = new XmlSerializer(typeof(Worker[]));
            XmlSerializer formatter = new XmlSerializer(typeof(List<Worker>));

            // сериализация в XML
            using (FileStream fs = new FileStream(fileName, FileMode.Create)) {
                 formatter.Serialize(fs, workers);
            }

            // десериализация из XML
            workers.Clear(); // чистка коллекции для чистоты эксперимента
            using (FileStream fs = new FileStream(fileName, FileMode.OpenOrCreate)) {
                // newWorkers = (Worker[])formatter.Deserialize(fs);
                workers = formatter.Deserialize(fs) as List<Worker>;
            }


            // показать то, что удалость десериализовать 
            Console.WriteLine("\nДесериализовано:");
            workers.ForEach(Console.WriteLine);
            
        } // ComplexObjectDemo
    }
}
