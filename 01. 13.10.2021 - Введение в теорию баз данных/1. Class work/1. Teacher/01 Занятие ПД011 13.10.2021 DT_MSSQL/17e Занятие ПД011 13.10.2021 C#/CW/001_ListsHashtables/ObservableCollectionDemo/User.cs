using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ObservableCollectionDemo
{
    // класс для демонстрации работы с ObservableCollection
    class User
    {
        public string Name { get; set; }
        public int    Age  { get; set; }

        public override string ToString()=>
            $"[Name: {Name}; Age: {Age}]";
    } // User
}
