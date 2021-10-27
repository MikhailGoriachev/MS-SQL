using System;

namespace XMLserialization.Models
{
    [Serializable]
    public class Worker
    {
        // только public-члены сериализуются
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int Age { get; set; }
        public Company Company { get; set; }

        // обязателен стандартный конструктор без параметров
        public Worker() { }

        public Worker(string lastName, string firstName, int age, Company company) {
            LastName = lastName;
            FirstName = firstName;
            Age = age;
            Company = company;
        } // Worker

        public override string ToString() => $"{FirstName, -10} {LastName, -10} Возраст, лет: {Age, 3}. {Company}";
    } // class Worker
}
