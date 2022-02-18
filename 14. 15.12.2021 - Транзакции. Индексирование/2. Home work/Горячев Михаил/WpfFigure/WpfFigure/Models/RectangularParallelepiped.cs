using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WpfFigure.Models
{
    // Класс Прямоугольный параллелепипед
    public class RectangularParallelepiped
    {
        // сторона A
        private double _a;

        // сторона B
        private double _b;

        // сторона C
        private double _c;

        // плотность 
        private double _density;

        #region Свойства

        // доступ к полю _a
        public double A
        {
            get => _a; 
            set => _a = value > 0d ? value :
                throw new Exception("Значение стороны A должно быть больше 0!");
        }

        // доступ к полю _b
        public double B
        {
            get => _b; 
            set => _b = value > 0d ? value :
                throw new Exception("Значение стороны B должно быть больше 0!");
        }

        // доступ к полю _c
        public double C
        {
            get => _c; 
            set => _c = value > 0d ? value :
                throw new Exception("Значение стороны C должно быть больше 0!");
        }

        // доступ к полю _density
        public double Density
        {
            get => _density;
            set => _density = value > 0d
                ? value : throw new Exception("Значение плотности должно быть больше 0!");
        }

        #endregion

        #region Методы

        // площадь поверхности Источник: https://www-formula.ru/2011-09-24-00-29-48 
        public double Area() => 2 * (_a * _b + _a * _c + _b * _c);

        // объем Источник: https://www.rapidus.ru/volume-of-parallelepiped.html
        public double Volume() => _a * _b * _c;

        // масса Источник: https://znaika.ru/catalog/7-klass/physics/Raschet-massy-i-obema-veschestva-po-ego-plotnosti.html
        public double Weight() => Volume() * _density;

        #endregion
    }
}
