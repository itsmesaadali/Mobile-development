import 'dart:io';

void main() {
  // Task 2, Step 1
  print('\nTask 2, Step 1\n');

  // Enter the name
  stdout.write('Enter your name: ');

  String name = stdin.readLineSync()!;

  // Enter the age
  stdout.write('Enter your age: ');
  int age = int.parse(stdin.readLineSync()!);

  // Check the age
  if (age < 18) {
    print('Sorry! $name, you are not eligible to register.');
  } else {
    print('You are eligible to register.');
  }

  // Task 2, Step 2

  print('\nTask 2, Step 2\n');

  stdout.write('How many numbers do you want to enter? ');

  int n = int.parse(stdin.readLineSync()!);

  List<int> numbers = [];

  // Task 2, Step 3

  print('\nTask 2, Step 3\n');

  for (int i = 0; i < n; i++) {
    stdout.write('Enter number ${i + 1}: ');
    numbers.add(int.parse(stdin.readLineSync()!));
  }

  // Task 2, Step 4

  print('\nTask 2, Step 4\n');

  int evenSum = numbers.where((x) => x.isEven).fold(0, (a, b) => a + b);
  int oddSum = numbers.where((x) => x.isOdd).fold(0, (a, b) => a + b);
  int largest = numbers.reduce((a, b) => a > b ? a : b);
  int smallest = numbers.reduce((a, b) => a < b ? a : b);
  print("\n===== Calculation... =====");

  // Task 2, Step 5

  print('\nTask 2, Step 5\n');

  print("\n===== Results =====");
  print("Sum of even numbers: $evenSum");
  print("Sum of odd numbers: $oddSum");
  print("Largest number: $largest");
  print("Smallest number: $smallest");
}
