import 'dart:math';

class RandomiserData {
  final List<int> _history = [];
  final Map<int, int> _occurrences = {};
  bool _isReset = true;

  int generateNewNumber(int min, int max) {
    final random = Random();
    final number = min + random.nextInt(max - min + 1);

    _history.add(number);
    _updateOccurrences(number);

    return number;
  }

  List<int> getHistory() {
    return List.from(_history.reversed);
  }

  Map<int, double> getOccurrences() {
    final totalCount = _history.length;
    final occurrences = <int, double>{};

    _occurrences.forEach((number, count) {
      final percentage = (count / totalCount) * 100;
      occurrences[number] = percentage;
    });

    return occurrences;
  }

  void _updateOccurrences(int number) {
    if (_occurrences.containsKey(number)) {
      _occurrences[number] = _occurrences[number]! + 1;
    } else {
      _occurrences[number] = 1;
    }
    _isReset = false;
  }

  int getHistoryByIndex(int index) {
    final reversedIndex = _history.length - 1 - index;
    if (reversedIndex >= 0 && reversedIndex < _history.length) {
      return _history[reversedIndex];
    }
    throw RangeError.range(index, 0, _history.length - 1, 'Index out of range');
  }

  Map<String, dynamic> getOccurrencesByIndex(int index) {
    final reversedOccurrences = List.from(_occurrences.keys.toList().reversed);
    if (index >= 0 && index < reversedOccurrences.length) {
      final number = reversedOccurrences[index];
      final count = _occurrences[number]!;
      final totalCount = _history.length;
      final percentage = (count / totalCount) * 100;
      return {
        'number': number,
        'count': count,
        'percentage': percentage,
      };
    }
    throw RangeError.range(
        index, 0, reversedOccurrences.length - 1, 'Index out of range');
  }

  void reset() {
    _history.clear();
    _occurrences.clear();
    _isReset = true;
  }

  bool isResetToDefault() {
    return _isReset;
  }
}
