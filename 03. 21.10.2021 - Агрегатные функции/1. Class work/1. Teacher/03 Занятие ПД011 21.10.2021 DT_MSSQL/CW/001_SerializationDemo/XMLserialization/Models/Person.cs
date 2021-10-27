using System;

namespace XMLserialization.Models
{
    // класс и его члены объявлены как public
    [Serializable]
    public class Person
    {
        // только public-члены сериализуются
        public string FirstName { get; set; }
        public string LastName  { get; set; }
        public int    Age       { get; set; }

        // обязателен стандартный конструктор без параметров
        public Person() { }

        public Person(string lastName, string firstName, int age) {
            LastName = lastName;
            FirstName = firstName;
            Age = age;
        } // Person

        public override string ToString() => $"{FirstName, -10} {LastName, -10} Возраст, лет: {Age}";
    } // class Person
}
