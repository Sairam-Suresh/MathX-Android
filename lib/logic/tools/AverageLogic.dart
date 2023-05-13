import 'dart:math';

double calculateMean(List<num> numbers) {
  if (numbers.isEmpty) return 0;

  num sum = numbers.reduce((value, element) => value + element);
  return sum / numbers.length;
}

num calculateMedian(List<num> numbers) {
  if (numbers.isEmpty) return 0;

  numbers.sort();
  int middleIndex = numbers.length ~/ 2;
  if (numbers.length % 2 == 0) {
    return (numbers[middleIndex - 1] + numbers[middleIndex]) / 2;
  } else {
    return numbers[middleIndex];
  }
}

Map<num, int> calculateMode(List<num> numbers) {
  if (numbers.isEmpty) return {};

  Map<num, int> frequencyMap = {};
  numbers.forEach((num) {
    frequencyMap[num] = (frequencyMap[num] ?? 0) + 1;
  });

  int maxFrequency = frequencyMap.values.reduce(max);
  Map<num, int> modeMap = {};
  frequencyMap.forEach((key, value) {
    if (value == maxFrequency) {
      modeMap[key] = value;
    }
  });

  return modeMap;
}

double calculateStandardDeviation(List<num> numbers) {
  if (numbers.isEmpty) return 0;

  double mean = calculateMean(numbers);
  double variance = numbers
          .map((num) => pow(num - mean, 2))
          .reduce((value, element) => value + element) /
      numbers.length;

  return sqrt(variance);
}
