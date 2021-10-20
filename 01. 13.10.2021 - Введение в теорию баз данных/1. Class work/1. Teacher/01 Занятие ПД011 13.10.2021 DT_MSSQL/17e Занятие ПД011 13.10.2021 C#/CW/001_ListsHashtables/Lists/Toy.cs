using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lists
{
    // класс для хранения в List<>
    class Toy
    {
        public string Name { get; set; }   // наименование
        public int Price { get; set; }     // цена
        public int AgeGroup { get; set; }  // возрастная категория

        public override string ToString() =>
             $"{{{Name, -22}: {Price, 8:n2} руб., возраст {AgeGroup, 2}+}}";
    } // class Toy
}
