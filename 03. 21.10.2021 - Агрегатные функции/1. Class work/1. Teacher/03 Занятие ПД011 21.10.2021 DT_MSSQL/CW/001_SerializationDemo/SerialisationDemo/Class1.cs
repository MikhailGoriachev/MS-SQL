using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SerialisationDemo
{ 
    [Serializable]
    class Class1
    {
        // поля для сериализации
        private int[] _arr;  // массив (коллекция)
        public string Name { get; set; }

        // обязателен стандартный конструктор без параметров

        // конструктор
        public Class1(int n, string name, int fillValue) {
            _arr = new int[n];
            for (int i = 0; i < _arr.Length; i++) _arr[i] = fillValue;

            Name = name;
        } // Class1

        // строковое представление
        public override string ToString() {
            StringBuilder sb = new StringBuilder(Name);
            sb.Append(": ");
            foreach (var item in _arr) {
                sb.Append($"{item, 6}");
            } // foreach
            sb.Append("\n");
            return sb.ToString();
        } // ToString
    } // class Class1
}
