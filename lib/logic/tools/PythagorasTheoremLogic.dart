import 'dart:math';

// Function to calculate the hypotenuse using Pythagorean theorem with 'num' values
num calculateHypotenuse(num a, num b) {
  return sqrt(pow(a.toDouble(), 2) + pow(b.toDouble(), 2));
}

// Function to calculate one of the sides using Pythagorean theorem with 'num' values
num calculateSide(num c, num a) {
  return sqrt(pow(c.toDouble(), 2) - pow(a.toDouble(), 2));
}
