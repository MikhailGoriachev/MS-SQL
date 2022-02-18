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
using WpfFigure.Models;         // модели
using WpfFigure.Utilities;      // утилиты

namespace WpfFigure.Views
{
    /// <summary>
    /// Interaction logic for SphereWindow.xaml
    /// </summary>
    public partial class SphereWindow : Window
    {
        // фигура для обработки
        private Sphere _sphere;

        #region Конструктор по умолчанию

        // конструктор по умолчанию
        public SphereWindow() : this(Utils.GetSphere()) { }

        // конструктор инициализирующий
        public SphereWindow(Sphere sphere)
        {
            InitializeComponent();

            // установка значений
            _sphere = sphere;
        }

        #endregion

        #region Методы

        // загрузка формы
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            // заполнение полей формы
            TbxRadius.Text = $"{_sphere.Radius:n5}";
            TbxDensity.Text = $"{_sphere.Density:n5}";

        } // Window_Loaded


        // проверка текста в текст-боксах
        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            double n = 0;

            // если один из объектов еще не инициализирован
            if (TbxRadius == null || TbxDensity == null || BtnResult == null)
                return;

            // включить/включить кнопку, если данные некорректны
            BtnResult.IsEnabled = double.TryParse(TbxRadius.Text, out n)
                && double.TryParse(TbxDensity.Text, out n);

            // устнановка значения по умолчанию для полей вывода результата
            SetDefultResult();

        } // TextBox_TextChanged


        // обработка нажатия клавиш при вводе в текст-боксы
        private void TextBox_KeyDown(object sender, KeyEventArgs e)
        {
            e.Handled = !(e.Key >= Key.D0 && e.Key <= Key.D9 ||
                         e.Key >= Key.NumPad0 && e.Key <= Key.NumPad9 ||
                         e.Key == Key.Tab ||
                         e.Key == Key.OemMinus ||
                         e.Key == Key.Subtract ||
                         e.Key == Key.OemComma);
        } // TbxHeight_KeyDown


        // вычисление 
        private void BtnResult_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // получение значений полей
                _sphere.Radius = double.Parse(TbxRadius.Text);
                _sphere.Density = double.Parse(TbxDensity.Text);

                // получение результата и вывод результата
                TbxArea.Text = CkbArea.IsChecked == true ? $"{_sphere.Area():n5}" : TbxArea.Text;
                TbxMass.Text = CkbMass.IsChecked == true ? $"{_sphere.Weight():n5}" : TbxMass.Text;
                TbxVolume.Text = CkbVolume.IsChecked == true ? $"{_sphere.Volume():n5}" : TbxVolume.Text;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Ошибка!", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        } // BtnResult_Click


        // закрытие формы
        private void Exit_Click(object sender, RoutedEventArgs e) => Close();


        // изменение состояния чек-бокса
        private void CheckBox_Click(object sender, RoutedEventArgs e) => SetDefultResult();


        // устнановка значения по умолчанию для полей вывода результата
        public void SetDefultResult() =>
            TbxArea.Text = TbxVolume.Text = TbxMass.Text = "────────────";

        #endregion
    }
}
