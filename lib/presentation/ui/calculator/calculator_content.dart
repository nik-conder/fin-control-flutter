import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Для inputFormatters

class CalculatorContent extends StatelessWidget {
  const CalculatorContent({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Процент от числа',
                style: textTheme.titleMedium,
              )
            ],
          ),
          const CalculatorPercentageOfNum(),
          const Divider(height: 40),
          Row(
            children: [
              Text(
                'Процентное соотношение',
                style: textTheme.titleMedium,
              )
            ],
          ),
          const CalculatorPrecentNumOfNum(),
          const Divider(height: 40),
          Row(
            children: [
              Text(
                'Прибавить процент к числу',
                style: textTheme.titleMedium,
              )
            ],
          ),
          const CalculatorAddPrecentToNum(),
          const Divider(height: 40),
          Row(
            children: [
              Text(
                'Вычесть процент от числа',
                style: textTheme.titleMedium,
              )
            ],
          ),
          const CalculatorSubtractPrecentToNum()
        ],
      ),
    );
  }
}

class CalculatorPercentageOfNum extends StatefulWidget {
  const CalculatorPercentageOfNum({super.key});

  @override
  State<CalculatorPercentageOfNum> createState() =>
      _CalculatorPercentageOfNumState();
}

class _CalculatorPercentageOfNumState extends State<CalculatorPercentageOfNum> {
  int num1 = 0;
  int num2 = 0;
  double result = 0.0;

  void _onChange(int num_1, int num_2) {
    setState(() {
      num1 = num_1;
      num2 = num_2;
      result = (num1 > 0 && num2 > 0) ? num1 * (num2 / 100) : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(children: [
      SizedBox(
        width: 80,
        child: NumberInputField(
          maxLength: 6,
          onChanged: (value) => _onChange(int.tryParse(value) ?? 0, num2),
        ),
      ),
      Text(
        '% от числа ',
        style: textTheme.bodyLarge,
      ),
      SizedBox(
          width: 80,
          child: NumberInputField(
            maxLength: 18,
            onChanged: (value) => _onChange(num1, int.tryParse(value) ?? 0),
          )),
      Text(
        ' = ',
        style: textTheme.bodyLarge,
      ),
      Text(
        result.toStringAsFixed(2),
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.primary,
        ),
      )
    ]);
  }
}

class CalculatorPrecentNumOfNum extends StatefulWidget {
  const CalculatorPrecentNumOfNum({super.key});

  @override
  State<CalculatorPrecentNumOfNum> createState() =>
      _CalculatorPrecentNumOfNumState();
}

class _CalculatorPrecentNumOfNumState extends State<CalculatorPrecentNumOfNum> {
  int num1 = 0;
  int num2 = 0;
  double result = 0.0;

  void _onChange(int num_1, int num_2) {
    setState(() {
      num1 = num_1;
      num2 = num_2;
      result = (num1 > 0 && num2 > 0) ? (num1 / num2) * 100 : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(children: [
      SizedBox(
        width: 80,
        child: Text(
          result.toStringAsFixed(2),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      SizedBox(
        width: 80,
        child: Text(
          '% число ',
          style: textTheme.bodyLarge,
        ),
      ),
      SizedBox(
        width: 80,
        child: NumberInputField(
          maxLength: 6,
          onChanged: (value) => _onChange(int.tryParse(value) ?? 0, num2),
        ),
      ),
      Text(
        ' от числа ',
        style: textTheme.bodyLarge,
      ),
      SizedBox(
        width: 80,
        child: NumberInputField(
          maxLength: 18,
          onChanged: (value) => _onChange(num1, int.tryParse(value) ?? 0),
        ),
      ),
    ]);
  }
}

class CalculatorAddPrecentToNum extends StatefulWidget {
  const CalculatorAddPrecentToNum({super.key});

  @override
  State<CalculatorAddPrecentToNum> createState() =>
      _CalculatorAddPrecentToNumState();
}

class _CalculatorAddPrecentToNumState extends State<CalculatorAddPrecentToNum> {
  int num1 = 0;
  int num2 = 0;
  double result = 0.0;

  void _onChange(int num_1, int num_2) {
    setState(() {
      num1 = num_1;
      num2 = num_2;
      result = (num1 > 0 && num2 > 0) ? ((num2 / 100) * num1) + num2 : 0.0;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(children: [
      SizedBox(
        width: 80,
        child: NumberInputField(
          maxLength: 6,
          onChanged: (value) => _onChange(int.tryParse(value) ?? 0, num2),
        ),
      ),
      Text(
        '% к числу ',
        style: textTheme.bodyLarge,
      ),
      SizedBox(
        width: 80,
        child: NumberInputField(
          maxLength: 18,
          onChanged: (value) => _onChange(num1, int.tryParse(value) ?? 0),
        ),
      ),
      Text(
        ' = ',
        style: textTheme.bodyLarge,
      ),
      Text(
        result.toStringAsFixed(2),
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.primary,
        ),
      )
    ]);
  }
}

class CalculatorSubtractPrecentToNum extends StatefulWidget {
  const CalculatorSubtractPrecentToNum({super.key});

  @override
  State<CalculatorSubtractPrecentToNum> createState() =>
      _CalculatorSubtractPrecentToNumState();
}

class _CalculatorSubtractPrecentToNumState
    extends State<CalculatorSubtractPrecentToNum> {
  int num1 = 0;
  int num2 = 0;
  double result = 0.0;

  void _onChange(int num_1, int num_2) {
    setState(() {
      num1 = num_1;
      num2 = num_2;
      result = (num1 > 0 && num2 > 0) ? num2 * (1 - num1 / 100) : 0.0;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(children: [
      SizedBox(
        width: 80,
        child: NumberInputField(
          maxLength: 6,
          onChanged: (value) => _onChange(int.tryParse(value) ?? 0, num2),
        ),
      ),
      Text(
        '% от числа ',
        style: textTheme.bodyLarge,
      ),
      SizedBox(
        width: 80,
        child: NumberInputField(
          maxLength: 18,
          onChanged: (value) => _onChange(num1, int.tryParse(value) ?? 0),
        ),
      ),
      Text(
        ' = ',
        style: textTheme.bodyLarge,
      ),
      Text(
        result.toStringAsFixed(2),
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.primary,
        ),
      )
    ]);
  }
}

class NumberInputField extends StatelessWidget {
  final void Function(String) onChanged;
  final int maxLength;
  final TextStyle? style;

  const NumberInputField({
    super.key,
    required this.onChanged,
    required this.maxLength,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final defaultStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: color,
    );

    return SizedBox(
      width: 80,
      child: TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: style ?? defaultStyle,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: '0',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(maxLength),
        ],
        onChanged: onChanged,
      ),
    );
  }
}
