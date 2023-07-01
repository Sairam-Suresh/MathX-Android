import 'dart:convert';

import 'package:math_parser/math_parser.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/logic/CalculationsDatabaseHelper.dart';
import 'package:mathx_android/screens/root/tabs/Tools/tools/calculator/inline_equation_sharing_view.dart';
import 'package:sqflite/sqflite.dart';

class Calculation {
  String expression;
  double result;
  num? answerBefore;

  Calculation(this.expression, this.result, this.answerBefore);

  String get base64EncodedLink =>
      calculatorURLAccessor +
      base64Encode(utf8.encode(
          "ET:${expression.replaceAll("*", "×").replaceAll("/", "÷").replaceAll("Ans", (answerBefore == null) ? "Ans" : (answerBefore!.isIntValue()) ? answerBefore!.toInt().toString() : answerBefore!.toString())} -,- RT:${result.isIntValue() ? result.toInt() : result}"));
  Map<String, dynamic> toMap() {
    return {
      'expression': expression,
      'result': result,
      'answerBefore': answerBefore,
    };
  }

  factory Calculation.fromMap(Map<String, dynamic> map) {
    return Calculation(
      map['expression'],
      map['result'],
      map['answerBefore'],
    );
  }
}

class Calculator {
  List<Calculation> history = [];
  double ans = 0.0;
  CalculationDatabaseHelper instance = CalculationDatabaseHelper.instance;

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
          Calculation(expression, 0, ans.isIntValue() ? ans.toInt() : ans);
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

  void clearHistory() {
    history = [];
  }

  Future<void> saveHistoryToPersistence() async {
    final Database db = await instance.database;
    await db.transaction((txn) async {
      await txn.delete("calculations"); // Clear the table
      for (final calculation in history) {
        await txn.insert(
          "calculations",
          calculation.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<void> loadHistoryFromPersistence() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query("calculations");
    history = [
      ...(maps.map((map) => Calculation.fromMap(map)).toList()),
      ...history
    ];
  }
}
