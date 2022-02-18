using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WpfFigure.Models
{
    // Класс Сфера
    public class Sphere
    {
        // радиус
        private double _radius;

        // плотность 
        private double _density;

        #region Свойства

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
        public double Area() => 4 * Math.PI * (_radius * _radius);

        // объем Источник: https://multiurok.ru/files/priezientatsiia-na-tiemu-obiem-shara-i-iegho-chastiei.html
        public double Volume() => 4 / 3 * Math.PI * Math.Pow(_radius, 3);

        // масса Источник: https://znaika.ru/catalog/7-klass/physics/Raschet-massy-i-obema-veschestva-po-ego-plotnosti.html
        public double Weight() => Volume() * _density;

        #endregion
    }
}