using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hashtables
{
    class Toy
    {
        public string Name { get; set; }
        public int Price { get; set; }
        public int AgeGroup { get; set; }

        public override string ToString() =>
            $"{{{Name}: {Price:n2} руб., возраст {AgeGroup}+}}";
    } // class Toy
}
