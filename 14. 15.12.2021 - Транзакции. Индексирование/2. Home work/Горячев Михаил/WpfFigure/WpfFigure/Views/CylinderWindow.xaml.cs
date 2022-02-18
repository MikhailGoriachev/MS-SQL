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
    /// Interaction logic for CylinderWindow.xaml
    /// </summary>
    public partial class CylinderWindow : Window
    {
        // фигура для обработки
        private Cylinder _cylinder;

        #region Конструктор по умолчанию

        // конструктор по умолчанию
        public CylinderWindow() : this(Utils.GetCylinder()) { }

        // конструктор инициализирующий
        public CylinderWindow(Cylinder cylinder)
        {
            InitializeComponent();

            // установка значений
            _cylinder = cylinder;
        }

        #endregion

        #region Методы

        // загрузка формы
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            // заполнение полей формы
            TbxHeight.Text = $"{_cylinder.Height:n5}";
            TbxRadius.Text = $"{_cylinder.Radius:n5}";
            TbxDensity.Text = $"{_cylinder.Density:n5}";

        } // Window_Loaded


        // проверка текста в текст-боксах
        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            double n = 0;

            // если один из объектов еще не инициализирован
            if (TbxHeight == null || TbxRadius == null || TbxDensity == null || BtnResult == null)
                return;

            // включить/включить кнопку, если данные некорректны
            BtnResult.IsEnabled = double.TryParse(TbxHeight.Text, out n)
                && double.TryParse(TbxRadius.Text, out n)
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
                _cylinder.Height = double.Parse(TbxHeight.Text);
                _cylinder.Radius = double.Parse(TbxRadius.Text);
                _cylinder.Density = double.Parse(TbxDensity.Text);

                // получение результата и вывод результата
                TbxArea.Text = CkbArea.IsChecked == true ? $"{_cylinder.Area():n5}" : TbxArea.Text;
                TbxMass.Text = CkbMass.IsChecked == true ? $"{_cylinder.Weight():n5}" : TbxMass.Text;
                TbxVolume.Text = CkbVolume.IsChecked == true ? $"{_cylinder.Volume():n5}" : TbxVolume.Text;
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
