import 'dart:math';

class Calculation {
  String expression;
  double result;

  Calculation(this.expression, this.result);
}

class Calculator {
  List<Calculation> history = [];
  double ans = 0.0;

  double evaluate(String expression) {
    // Save the expression and result to history
    final calculation = Calculation(expression, 0);
    history.add(calculation);

    try {
      // Evaluate the expression using the 'dart:math' library's 'evaluate' function
      calculation.result = evaluateExpression(expression);
      ans = calculation.result;
      return ans;
    } catch (e) {
      // Handle any errors during evaluation
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
    return double.parse(evaluateWithBrackets(expression));
  }

  String evaluateWithBrackets(String expression) {
    // Handle brackets recursively
    while (expression.contains('(')) {
      final startIndex = expression.lastIndexOf('(');
      final endIndex = expression.indexOf(')', startIndex);

      if (startIndex == -1 || endIndex == -1) {
        throw Exception('Invalid expression: Missing brackets');
      }

      final expressionInBrackets =
          expression.substring(startIndex + 1, endIndex);
      final result = evaluateExpression(expressionInBrackets);

      expression =
          expression.replaceRange(startIndex, endIndex + 1, result.toString());
    }

    return evaluateWithoutBrackets(expression);
  }

  String evaluateWithoutBrackets(String expression) {
    // Evaluate the expression without brackets

    // Handle square root operation
    while (expression.contains('sqrt')) {
      final sqrtIndex = expression.lastIndexOf('sqrt');
      final startIndex = expression.indexOf('(', sqrtIndex);
      final endIndex = expression.indexOf(')', sqrtIndex);

      if (startIndex == -1 || endIndex == -1) {
        throw Exception('Invalid expression: Missing brackets for square root');
      }

      final expressionInSqrt = expression.substring(startIndex + 1, endIndex);
      final result = sqrt(evaluateExpression(expressionInSqrt));

      expression =
          expression.replaceRange(sqrtIndex, endIndex + 1, result.toString());
    }

    // Handle the remaining operations: *, /, +, -
    final operators = {'*', '/', '+', '-'};

    for (final operator in operators) {
      while (expression.contains(operator)) {
        final operatorIndex = expression.indexOf(operator);

        // Find the left operand
        var leftIndex = operatorIndex - 1;
        while (leftIndex >= 0 && isDigit(expression[leftIndex])) {
          leftIndex--;
        }
        leftIndex++;

        // Find the right operand
        var rightIndex = operatorIndex + 1;
        while (
            rightIndex < expression.length && isDigit(expression[rightIndex])) {
          rightIndex++;
        }
        rightIndex--;

        // Extract the operands and perform the operation
        final leftOperand =
            double.parse(expression.substring(leftIndex, operatorIndex));
        final rightOperand = double.parse(
            expression.substring(operatorIndex + 1, rightIndex + 1));
        final result = performOperation(leftOperand, rightOperand, operator);

        // Replace the expression with the result
        expression = expression.replaceRange(
            leftIndex, rightIndex + 1, result.toString());
      }
    }

    return expression;
  }

  double performOperation(
      double leftOperand, double rightOperand, String operator) {
    // Perform the arithmetic operation
    switch (operator) {
      case '*':
        return leftOperand * rightOperand;
      case '/':
        return leftOperand / rightOperand;
      case '+':
        return leftOperand + rightOperand;
      case '-':
        return leftOperand - rightOperand;
      default:
        throw Exception('Invalid operator: $operator');
    }
  }

  bool isDigit(String value) {
    // Check if the given value is a digit
    return double.tryParse(value) != null;
  }
}
