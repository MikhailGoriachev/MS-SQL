using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Runtime.Serialization.Formatters.Binary; // для сериализации
using System.IO;

namespace SerialisationDemo
{
    class Program
    {
        static void Main(string[] args) {

            Console.Title = "Занятие 21.10.2021 - бинарная сериализация";

            // простая сериализация
            // SimpleSerialization();
            // Console.WriteLine("\n─────────────────────────────────────────────────────────────────────────────────────\n");

            // пример сериализации сложного объекта
            ComplexSerializtion();
            Console.WriteLine("\n─────────────────────────────────────────────────────────────────────────────────────\n");
        } // Main

        // сериализация базовых типлв
        private static void SimpleSerialization() {
            Example example1 = new Example(100, Math.PI, "Это пример строки", DateTime.Now);
            Example example2 = new Example(-1, Math.E, "Еще одна строка", new DateTime(1812, 8, 23));
            Class1  class1 = new Class1(11, "Массив для сериализации", 11); 
            // Console.WriteLine($"\nДанные для сохранения в файле сериализации:\n{example1}\n");
            // Console.WriteLine($"\nДанные для сохранения в файле сериализации:\n{example1}\n{example2}\n");
            Console.WriteLine($"\nДанные для сохранения в файле сериализации:\n{example1}\n{example2}\n{class1}");

            // форматтер для бинарной сериализации
            BinaryFormatter bf = new BinaryFormatter();

            using (FileStream fs = new FileStream(@"..\..\Example.dat", FileMode.Create)) {
                bf.Serialize(fs, example1);
                bf.Serialize(fs, example2);
                
                bf.Serialize(fs, class1);
            } // using

            Console.WriteLine("Сериализация выполнена");
            
            // изменение данных
            example1.StrData = "новая строка";
            example1.DblData = Math.E / 10;
            example2.DblData = -Math.E;
            example2.IntData = -1;
            example2.StrData = "-1";

            class1 = new Class1(3, "Новый массив", -1);
            Console.WriteLine($"\nДанные изменены\n{example1}\n{example2}\n{class1}");
            
            // восстановление, десериализация данных
            Console.WriteLine("\nДесериализация, восстановление данных");
            using (FileStream fs = new FileStream(@"..\..\Example.dat", FileMode.Open)) {
                // восстановление значений без вызова конструктора
                // несериализуемое поле теряет значение
                example1 = bf.Deserialize(fs) as Example;
                example2 = bf.Deserialize(fs) as Example;
                class1 = bf.Deserialize(fs) as Class1;
                // Console.WriteLine($"Данные восстановлены\n{example1}\n{example2}\n");
                Console.WriteLine($"Данные восстановлены\n{example1}\n{example2}\n{class1}\n");
            } // using
            
        } // SimpleSerialization


        // сериализация сложного объекта
        private static void ComplexSerializtion() {
            // форматтер для сериализации/десериализации
            BinaryFormatter bf = new BinaryFormatter();

            // создание объекта для инициализации
            Experimental experimental = new Experimental(
                new Example(100, Math.PI, "Это пример строки и это еще немного", DateTime.Now),
                new Class1(11, "Массив для сериализации", 3)
            );
            Console.WriteLine(experimental);

            // собственно сериализация
            using (FileStream fs = new FileStream(@"..\..\experimental.dat", FileMode.Create)) {
                bf.Serialize(fs, experimental);
            } // using
            Console.WriteLine("Сериализация выполнена");
            
            // изменяем поля объекта
            experimental.Example.DblData /= 100d;
            experimental.Class1.Name = "Другое имя";
            Console.WriteLine($"\nИзменили поля:\n{experimental}");

            // десериализация объекта
            using (FileStream fs = new FileStream(@"..\..\experimental.dat", FileMode.Open)) {
                experimental = bf.Deserialize(fs) as Experimental;
            } // using
            Console.WriteLine($"Десериализация выполнена\n{experimental}\n");

            Console.WriteLine("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
            experimental.Serialize(@"..\..\temp.dat");
            experimental = null;
            experimental = Experimental.Deserialize(@"..\..\temp.dat");
            Console.WriteLine($"\n{experimental}");

        } // ComplexSerializtion
    } // class Program
}
