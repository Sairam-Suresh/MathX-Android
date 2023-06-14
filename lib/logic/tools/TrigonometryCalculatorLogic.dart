import 'dart:math';

enum AngleUnit {
  degrees,
  radians,
}

enum TrigonometryResultKey {
  equation,
  answer,
}

Map<TrigonometryResultKey, String> calculateAngleX({
  required double sideA,
  required double sideB,
  required double sideC,
  required AngleUnit angleUnitSelection,
}) {
  final Map<TrigonometryResultKey, String> result = {
    TrigonometryResultKey.equation: '',
    TrigonometryResultKey.answer: '',
  };

  double h = sideC;
  double a = sideB;
  double o = sideA;

  if (o <= 0 && a <= 0 && h <= 0) {
    return result;
  }

  if (o > 0 && h > 0) {
    result[TrigonometryResultKey.equation] =
        'sin^{-1}\\frac{${o.formatted()}}{${h.formatted()}}';
    if (angleUnitSelection == AngleUnit.degrees) {
      result[TrigonometryResultKey.answer] =
          (asin(o / h) * 180 / pi).formatted();
    } else {
      result[TrigonometryResultKey.answer] = (asin(o / h)).formatted();
    }
  } else if (a > 0 && h > 0) {
    result[TrigonometryResultKey.equation] =
        'cos^{-1}\\frac{${a.formatted()}}{${h.formatted()}}';
    if (angleUnitSelection == AngleUnit.degrees) {
      result[TrigonometryResultKey.answer] =
          (acos(a / h) * 180 / pi).formatted();
    } else {
      result[TrigonometryResultKey.answer] = (acos(a / h)).formatted();
    }
  } else if (o > 0 && a > 0) {
    result[TrigonometryResultKey.equation] =
        'tan^{-1}\\frac{${o.formatted()}}{${a.formatted()}}';
    if (angleUnitSelection == AngleUnit.degrees) {
      result[TrigonometryResultKey.answer] =
          (atan(o / a) * 180 / pi).formatted();
    } else {
      result[TrigonometryResultKey.answer] = (atan(o / a)).formatted();
    }
  }

  return result;
}

extension DoubleFormatter on double {
  String formatted() {
    return toStringAsFixed(2);
  }
}
