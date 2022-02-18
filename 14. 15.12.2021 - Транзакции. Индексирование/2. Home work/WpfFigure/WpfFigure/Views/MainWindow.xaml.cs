using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

/* 
 * Задача 1. Разработайте приложение WPF для вычислений параметров объемных геометрических 
 * фигур по выбору пользователя. Каждый расчет выполняется в отдельном окне, открываемом в 
 * модальном режиме. Выбор окна – при помощи кнопочного меню.
 * 
 * По команде О программе кнопочного меню в отдельной форме выводить в TextBlock сведения 
 * о приложении и разработчике (фамилия, имя, группа). 
 * 
 * В формах фигур разместить строки ввода для параметров фигур, собственно вычисление 
 * выполнять при клике на кнопку "Вычислить". Необходимо контролировать правильность ввода 
 * параметров. Используйте модели для вычислений.
 * 
 * Что именно вычислять для каждой фигуры:
 * •	площадь поверхности 
 * •	объем
 * •	масса 
 * Типы фигур для расчетов:
 * •	усеченный конус
 * •	сфера
 * •	цилиндр
 * •	прямоугольный параллелепипед
*/

namespace WpfFigure.Views
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }


        // выход из приложения
        private void Exit_Click(object sender, RoutedEventArgs e) => Application.Current.Shutdown();


        // запуск формы усечённого конуса
        private void Conoid_Click(object sender, RoutedEventArgs e) => new ConoidWindow().ShowDialog();


        // запуск формы сферы
        private void Sphere_Click(object sender, RoutedEventArgs e) => new SphereWindow().ShowDialog();


        // запуск формы цилиндра
        private void Cylinder_Click(object sender, RoutedEventArgs e) => new CylinderWindow().ShowDialog();


        // запуск формы параллелепипеда
        private void Parallelepiped_Click(object sender, RoutedEventArgs e) => new ParallelepipedWindow().ShowDialog();


        // запуск формы с информацией о программе
        private void ProgramInfo_Click(object sender, RoutedEventArgs e) => new ProgramInfoWindow().ShowDialog();
    }
}
