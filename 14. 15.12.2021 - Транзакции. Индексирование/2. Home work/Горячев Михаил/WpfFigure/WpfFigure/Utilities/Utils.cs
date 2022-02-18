using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WpfFigure.Models;     // модели

namespace WpfFigure.Utilities
{
    // Класс Утилиты
    internal class Utils
    {
        // объект для генерации случайных значений
        public static Random rand = new Random();

        // генерация вещественного числа (min, max]
        public static double GetRand(double min, double max)
        {
            // если диапазон не корректен
            if (min.CompareTo(max) > 0 || max.CompareTo(min) < 0)
                throw new Exception("Utils.GetRand(double min, double max): минимум не может быть больше максимума");

            // число
            double num;

            // генерация числа
            do
            {
                num = rand.Next((int)min, (int)max - 1) + rand.NextDouble();
            } while (num.CompareTo(min) < 0 || num.CompareTo(max) > 0);

            return num;
        }

        // генерация целого числа (min, max]
        public static int GetRand(int min, int max)
        {
            // если диапазон не корректен
            if (min.CompareTo(max) > 0 || max.CompareTo(min) < 0)
                throw new Exception("Utils.GetRand(int min, int max): минимум не может быть больше максимума");

            return rand.Next(min, max);
        }

        // генерация номера поезда
        public static string GenerateNumberTrain() => $"{GetRand(301, 451)}";

        // генерация усеченого конуса
        public static Conoid GetConoid() => 
            new Conoid { Radius = (GetRand(5d, 10d), GetRand(15d, 20d)), Height = GetRand(5, 10), Density = GetRand(100d, 1000d) };

        // генерация параллелепипеда
        public static RectangularParallelepiped GetParallelepiped() =>
            new RectangularParallelepiped { A = GetRand(10d, 15d), B = GetRand(10d, 15d), C = GetRand(10d, 15d), Density = GetRand(100d, 1000d) };

        // генерация сферы
        public static Sphere GetSphere() =>
            new Sphere { Radius = GetRand(10d, 15d), Density = GetRand(100d, 1000d) };

        // генерация цилиндра
        public static Cylinder GetCylinder() =>
            new Cylinder { Height = GetRand(10d, 15d), Radius = GetRand(10d, 15d), Density = GetRand(100d, 1000d) };
    }
}