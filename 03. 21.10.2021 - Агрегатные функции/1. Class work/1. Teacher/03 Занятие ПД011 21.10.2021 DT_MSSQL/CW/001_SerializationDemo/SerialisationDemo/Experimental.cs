using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


using System.Runtime.Serialization.Formatters.Binary;

namespace SerialisationDemo
{
    // сложный объект для сериализации
    [Serializable]
    class Experimental
    {
        // все поля класса должны быть сериализуемыми
        public Class1 Class1 { get; set; } 
        public Example Example { get; set; }

        // обязателен стандартный конструктор без параметров
        public Experimental() {
            Class1 = null;
            Example = null;
        } // Experimental

        public Experimental(Example example, Class1 class1) {
            Class1 = class1;
            Example = example;
        } // Experimental

        public override string ToString() =>
            $"{Class1}\n{Example}";

        // сериализация
        public void Serialize(string fileName) {
            BinaryFormatter bf = new BinaryFormatter();

            // собственно сериализация
            using (FileStream fs = new FileStream(fileName, FileMode.Create)) {
                bf.Serialize(fs, this);
            } // using
        }

        // десериализация - удобно выполнять статическим методом
        public static Experimental Deserialize(string fileName) {
            BinaryFormatter bf = new BinaryFormatter();
            Experimental obj;

            // собственно десериализация
            using (FileStream fs = new FileStream(fileName, FileMode.Open)) {
                obj = bf.Deserialize(fs) as Experimental;
            } // using

            return obj;
        } // Deserialize
    } // class Experimental
}
