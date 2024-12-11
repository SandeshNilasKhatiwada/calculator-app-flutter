import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Calculator(),
  ));
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String display = ""; // Current display value
  double? firstOperand; // First number
  String? operator; // Operator
  double? secondOperand; // Second number

  void buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        // Clear all
        display = "";
        firstOperand = null;
        operator = null;
        secondOperand = null;
      } else if (value == "=") {
        // Calculate result
        if (firstOperand != null && operator != null && secondOperand == null) {
          secondOperand = double.tryParse(display);
          if (secondOperand != null) {
            switch (operator) {
              case "+":
                display = (firstOperand! + secondOperand!).toString();
                break;
              case "-":
                display = (firstOperand! - secondOperand!).toString();
                break;
              case "*":
                display = (firstOperand! * secondOperand!).toString();
                break;
              case "/":
                if (secondOperand != 0) {
                  display = (firstOperand! / secondOperand!).toString();
                } else {
                  display = "Error";
                }
                break;
            }
            firstOperand = double.tryParse(
                display); // Save the result for further calculations
            secondOperand = null;
            operator = null;
          }
        }
      } else if (["+", "-", "*", "/"].contains(value)) {
        // Handle operators
        if (firstOperand == null) {
          firstOperand = double.tryParse(display);
          operator = value;
          display = ""; // Clear display for next operand
        }
      } else {
        // Append number or decimal point
        display += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sandesh Calculator"),
      ),
      body: Column(
        children: [
          // Display for results and input
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                display,
                style:
                    const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Buttons
          Expanded(
            flex: 2,
            child: GridView.count(
              crossAxisCount: 4,
              children: [
                // Button List
                ...["7", "8", "9", "/"].map((e) => _buildButton(e)),
                ...["4", "5", "6", "*"].map((e) => _buildButton(e)),
                ...["1", "2", "3", "-"].map((e) => _buildButton(e)),
                ...["C", "0", "=", "+"].map((e) => _buildButton(e)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String value) {
    return ElevatedButton(
      onPressed: () => buttonPressed(value),
      child: Text(
        value,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
