using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WpfFigure.Interface;     // интерфейсы

namespace WpfFigure.Models
{
    // Класс Усеченный конус
    public class Conoid : IFigure
    {
        // высота
        private double _height;

        // верхний радиус
        private double _radiusTop;
        
        // нижний радиус
        private double _radiusDown;

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
        public (double top, double down) Radius {  
            get => (_radiusTop, _radiusDown);
            set => (_radiusTop, _radiusDown) = (value.down <= 0d || value.top <= 0d) ?
                                throw new Exception("Значение должно быть больше 0!")
                                : (value.down < value.top)
                                ? throw new Exception("Нижний радиус должен быть больше верхнего!")
                                : value; 
        }

        // доступ к полю _density
        public double Density
        {
            get => _density;
            set => _density = value > 0d
                ? value : throw new Exception("Значение плотности должно быть больше 0!");
        }

        // образующая Источник: https://present5.com/usechyonnyj-konus-konusy-vokrug-nas/
        public double Generatrix =>
            Math.Sqrt(Math.Pow(Math.Abs(_radiusDown - _radiusTop), 2) + _height * _height);

        #endregion

        #region Методы

        // площадь поверхности Источник: https://www-formula.ru/2011-09-24-00-29-48
        public double Area() => 
            Math.PI * (Generatrix * _radiusDown + Generatrix * _radiusTop + _radiusDown * _radiusDown + _radiusTop * _radiusTop);

        // объем Источник: https://www-formula.ru/2011-09-21-10-55-40
        public double Volume() =>
            Math.PI / 3d * _height * (_radiusDown * _radiusDown + _radiusTop * _radiusTop);

        // масса Источник: https://znaika.ru/catalog/7-klass/physics/Raschet-massy-i-obema-veschestva-po-ego-plotnosti.html
        public double Weight() => Volume() * _density;

        #endregion
    }
}
