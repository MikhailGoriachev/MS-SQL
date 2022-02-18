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
using WpfFigure.Models;             // модели
using WpfFigure.Utilities;          // утилиты

namespace WpfFigure.Views
{
    /// <summary>
    /// Interaction logic for Conoid.xaml
    /// </summary>
    public partial class ConoidWindow : Window
    {
        // фигура для обработки
        private Conoid _conoid;

        #region Конструктор по умолчанию

        // конструктор по умолчанию
        public ConoidWindow() : this(Utils.GetConoid()) { }

        // конструктор инициализирующий
        public ConoidWindow(Conoid conoid)
        {
            InitializeComponent();

            // установка значений
            _conoid = conoid;
        }

        #endregion

        #region Методы

        // загрузка формы
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            // заполнение полей формы
            TbxHeight.Text      = $"{_conoid.Height:n5}";
            TbxTopRadius.Text   = $"{_conoid.Radius.top:n5}";
            TbxDownRadius.Text  = $"{_conoid.Radius.down:n5}";
            TbxDensity.Text     = $"{_conoid.Density:n5}";

        } // Window_Loaded


        // проверка текста в текст-боксах
        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            double n = 0;

            // если один из объектов еще не инициализирован
            if (TbxHeight == null || TbxTopRadius == null || TbxDownRadius == null || TbxDensity == null || BtnResult == null)
                return;

            // включить/включить кнопку, если данные некорректны
            BtnResult.IsEnabled = double.TryParse(TbxHeight.Text, out n)
                && double.TryParse(TbxTopRadius.Text, out n)
                && double.TryParse(TbxDownRadius.Text, out n)
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
                _conoid.Height = double.Parse(TbxHeight.Text);
                _conoid.Radius = (double.Parse(TbxTopRadius.Text), double.Parse(TbxDownRadius.Text));
                _conoid.Density = double.Parse(TbxDensity.Text);

                // получение результата и вывод результата
                TbxArea.Text = CkbArea.IsChecked == true ? $"{_conoid.Area():n5}" : TbxArea.Text; 
                TbxMass.Text = CkbMass.IsChecked == true ? $"{_conoid.Weight():n5}" : TbxMass.Text; 
                TbxVolume.Text = CkbVolume.IsChecked == true ? $"{_conoid.Volume():n5}" : TbxVolume.Text; 
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
