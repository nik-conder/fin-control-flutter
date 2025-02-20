import 'dart:ffi';

import 'package:flutter/material.dart';

class CalculatorContent extends StatefulWidget {
  const CalculatorContent({super.key});

  @override
  State<CalculatorContent> createState() => _CalculatorContentState();
}

class _CalculatorContentState extends State<CalculatorContent> {
  int num1 = 0;
  int num2 = 0;
  double result = 0.0;

  @override
  _initState() {
    setState(() {});
  }

  void _calculate() {
    setState(() {
      result = num1 * (num2 / 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Сколько составляет '),
            SizedBox(
              width: 100,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    num1 = int.parse(value);
                  });
                },
              ),
            ),
            Text('% от числа'),
            SizedBox(
              width: 100,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    num2 = int.parse(value);
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          children: [Text("$num1% от числа $num2 = $result")],
        ),
        Row(
          children: [
            TextButton(onPressed: _calculate, child: Text('calculate'))
          ],
        )
      ],
    );
  }
}
