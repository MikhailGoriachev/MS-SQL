using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WpfFigure.Models
{
    // Класс Цилиндр
    public class Cylinder
    {
        // высота
        private double _height;

        // радиус
        private double _radius;

        // плотность 
        private double _density;

        #region Свойства

        // доступ к полю _height
        public double Height
        {
            get => _height; 
            set => _height = value > 0d ? value :
                throw new Exception("Значение высоты должно быть больше 0!");
        }

        // доступ к полю _radius
        public double Radius
        {
            get => _radius;
            set => _radius = value > 0d ? value :
                throw new Exception("Значение радиуса должно быть больше 0!");
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
        public double Area() => 2 * Math.PI * _radius * (_height + _radius);

        // объем Источник: https://www.calc.ru/obyem-tsilindra.html
        public double Volume() => Math.PI * (_radius * _radius) * _height;

        // масса Источник: https://znaika.ru/catalog/7-klass/physics/Raschet-massy-i-obema-veschestva-po-ego-plotnosti.html
        public double Weight() => Volume() * _density;

        #endregion
    }
}
