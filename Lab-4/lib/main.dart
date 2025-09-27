// main.dart

class Student {
  final String name;
  final int age;

  // Default Constructor
  Student()
      : name = 'Unknown',
        age = 0;

  // Parameterized Constructor
  Student.parameterized(this.name, this.age);

  // Named Constructor
  Student.named({required String studentName, required int studentAge})
      : name = studentName,
        age = studentAge;

  // Redirecting Constructor
  Student.young(String studentName) : this.parameterized(studentName, 18);

  // Constant Constructor
  const Student.constant(this.name, this.age);

  // Method to display student info
  void display() {
    print('Name: $name, Age: $age');
  }
}

void main() {
  // Using default constructor
  var s1 = Student();
  s1.display();

  // Using parameterized constructor
  var s2 = Student.parameterized('Ali', 22);
  s2.display();

  // Using named constructor
  var s3 = Student.named(studentName: 'Saad', studentAge: 22);
  s3.display();

  // Using redirecting constructor
  var s4 = Student.young('Hassan');
  s4.display();

  // Using constant constructor
  const s5 = Student.constant('Bilal', 30);
  s5.display();
}



// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(body: Center(child: Text('Hello World!'))),
//     );
//   }
// }
