import 'dart:math';

class QuadraticEquation {
  double a;
  double b;
  double c;

  QuadraticEquation(this.a, this.b, this.c);

  double calculateDiscriminant() {
    return b * b - 4 * a * c;
  }

  int getNumberOfRoots() {
    double discriminant = calculateDiscriminant();
    if (discriminant > 0) {
      return 2;
    } else if (discriminant == 0) {
      return 1;
    } else {
      return 0;
    }
  }

  List<double> getXIntercepts() {
    double discriminant = calculateDiscriminant();
    if (discriminant >= 0) {
      double x1 = (-b + sqrt(discriminant)) / (2 * a);
      double x2 = (-b - sqrt(discriminant)) / (2 * a);
      return [x1, x2];
    } else {
      return [];
    }
  }

  double getTurningPointX() {
    return -b / (2 * a);
  }

  double getTurningPointY() {
    double turningPointX = getTurningPointX();
    return a * turningPointX * turningPointX + b * turningPointX + c;
  }

  double getLineOfSymmetry() {
    return -b / (2 * a);
  }

  double getYIntercept() {
    return c;
  }
}
