List<int> findFactors(int number) {
  List<int> factors = [];

  for (int i = 1; i <= number; i++) {
    if (number % i == 0) {
      factors.add(i);
    }
  }

  return factors;
}

int calculateHCF(int a, int b) {
  while (b != 0) {
    int remainder = a % b;
    a = b;
    b = remainder;
  }

  return a;
}

int calculateLCM(int a, int b) {
  int hcf = calculateHCF(a, b);
  int lcm = (a * b) ~/ hcf;

  return lcm;
}

int calculateLCMOfMultiple(List<int> numbers) {
  int lcm = numbers[0];

  for (int i = 1; i < numbers.length; i++) {
    lcm = calculateLCM(lcm, numbers[i]);
  }

  return lcm;
}
