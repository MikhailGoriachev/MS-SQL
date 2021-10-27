using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SerialisationDemo
{
    [Serializable] // атрибут сериализации класса
    class Example
    {
        public int      IntData { get; set; }  // целое
        public double   DblData { get; set; }  // вещественное
        public string   StrData { get; set; }  // строка

        // запрет сериализации для поля - т.к. его значение не меняется 
        [NonSerialized] private const int _test = 101;

        public DateTime DtmData { get; set; }  // дата и время

        // обязателен стандартный конструктор без параметров
        public Example() { }

        public Example(int i, double d, string s, DateTime dt)
        {
            IntData = i;
            DblData = d;
            StrData = s;
            DtmData = dt;
        } // Example

        public override string ToString() =>
            $"{IntData} {DblData:f3} \"{StrData}\" {DtmData:d} {_test}";
    } // class Example
}
