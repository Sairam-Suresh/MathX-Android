import 'dart:convert';

import 'package:math_parser/math_parser.dart';

class Calculation {
  String expression;
  double result;
  String base64Encoded;

  Calculation(this.expression, this.result, this.base64Encoded);
}

class Calculator {
  List<Calculation> history = [];
  double ans = 0.0;

  String sqrt(String expression) {
    return 'sqrt($expression)';
  }

  String backspaceExpression(String expression) {
    if (expression.isEmpty) return '';
    if (expression.endsWith('Ans')) {
      expression = expression.substring(0, expression.length - 3);
    } else {
      final lastChar = expression.substring(expression.length - 1);
      if (lastChar == ' ') {
        expression = expression.substring(0, expression.length - 3);
      } else {
        expression = expression.substring(0, expression.length - 1);
      }
    }

    return expression;
  }

  double evaluate(String expression) {
    try {
      final calculation =
          Calculation(expression, 0, base64.encode(utf8.encode(expression)));
      calculation.result = evaluateExpression(expression);
      ans = calculation.result;
      history.add(calculation);
      return ans;
    } catch (e) {
      print('Error: $e');
      return double.nan;
    }
  }

  double evaluateExpression(String expression) {
    // Remove any whitespace from the expression
    expression = expression.replaceAll(' ', '');

    // Replace the 'Ans' variable with its stored value
    expression = expression.replaceAll('Ans', ans.toString());

    // Evaluate the expression using the 'dart:math' library's 'evaluate' function
    return MathNodeExpression.fromString(
            (expression.replaceAll("×", "*").replaceAll("÷", "/")),
            isImplicitMultiplication: true)
        .calc(const MathVariableValues({}))
        .toDouble();
  }
}
