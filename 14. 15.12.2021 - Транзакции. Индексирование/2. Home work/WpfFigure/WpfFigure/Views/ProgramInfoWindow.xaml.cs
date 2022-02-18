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
using System.Windows.Shapes;

namespace WpfFigure.Views
{
    /// <summary>
    /// Interaction logic for ProgramInfoWindow.xaml
    /// </summary>
    public partial class ProgramInfoWindow : Window
    {
        public ProgramInfoWindow()
        {
            InitializeComponent();
        }


        // загрузка формы
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            // заполнение текст-блока информацией о программе
            TblInfo.Text = 
            "Задача 1. Разработайте приложение WPF для вычислений параметров объемных геометрических фигур по выбору пользователя. Каждый расчет выполняется в отдельном окне, открываемом в модальном режиме. Выбор окна – при помощи кнопочного меню.\n" +
            "По команде О программе кнопочного меню в отдельной форме выводить в TextBlock сведения о приложении и разработчике (фамилия, имя, группа). \n" +
            "В формах фигур разместить строки ввода для параметров фигур, собственно вычисление выполнять при клике на кнопку \"Вычислить\". Необходимо контролировать правильность ввода параметров. Используйте модели для вычислений.\n" +
            "Что именно вычислять для каждой фигуры:\n" +
            "•	площадь поверхности\n" +
            "•	объем\n" +
            "•	масса\n" +
            "Типы фигур для расчетов:\n" +
            "•	усеченный конус\n" +
            "•	сфера\n" +
            "•	цилиндр\n" +
            "•	прямоугольный параллелепипед\n";
        }


        // закрытие окна
        private void Exit_Click(object sender, RoutedEventArgs e) => Close();
    }
}
