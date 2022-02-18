using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WpfFigure.Interface
{
    // Интерфейс Поведение фигуры
    internal interface IFigure
    {
        // площадь поверхности 
        double Area();

        // объем
        double Volume();

        // масса
        double Weight();
    }
}
