// task3.dart
import 'dart:io';

void main() {
  stdout.write("Enter n: ");
  int n = int.parse(stdin.readLineSync()!);

  // Nested loops for pyramid
  for (int i = 1; i <= n; i++) {
    for (int j = 1; j <= i; j++) {
      stdout.write("$j ");
    }
    print(""); // new line
  }
}
