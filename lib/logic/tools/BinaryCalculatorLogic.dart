enum NumberCases {
  decimal,
  binary,
  bcd,
}

String convertToDecimal(String inputString, NumberCases convertFrom) {
  switch (convertFrom) {
    case NumberCases.decimal:
      return inputString;
    case NumberCases.binary:
      return int.tryParse(inputString, radix: 2)?.toString() ?? "";
    case NumberCases.bcd:
      var decimalNumber = "";
      final splittedBCD = splitBCD(inputString);

      for (final fourChar in splittedBCD) {
        decimalNumber += convertToDecimal(fourChar, NumberCases.binary);
      }

      return decimalNumber;
  }
}

String convertToBinary(String inputString, NumberCases convertFrom) {
  switch (convertFrom) {
    case NumberCases.decimal:
      final intFromString = int.tryParse(inputString);
      return intFromString?.toRadixString(2) ?? "";
    case NumberCases.binary:
      return inputString;
    case NumberCases.bcd:
      final decimalNumber = convertToDecimal(inputString, NumberCases.bcd);
      return convertToBinary(decimalNumber, NumberCases.decimal);
  }
}

String convertToBCD(String inputString, NumberCases convertFrom) {
  switch (convertFrom) {
    case NumberCases.decimal:
      var bcdNumber = "";
      final decimalSplitted = inputString.split("");

      for (final decimal in decimalSplitted) {
        var holdingBCDNumber = convertToBinary(decimal, NumberCases.decimal);
        holdingBCDNumber = holdingBCDNumber.padLeft(4, '0');

        bcdNumber += "$holdingBCDNumber ";
      }

      return bcdNumber.trim();
    case NumberCases.binary:
      final decimalFromBinaryString =
          convertToDecimal(inputString, NumberCases.binary);
      return convertToBCD(decimalFromBinaryString, NumberCases.decimal);
    case NumberCases.bcd:
      return inputString;
  }
}

List<String> splitBCD(String inputString) {
  return inputString.split(" ");
}

String formatInputToBCD(String inputString) {
  inputString = inputString.replaceAll(" ", "");
  inputString = inputString.replaceAllMapped(
      RegExp(r".{4}"), (match) => "${match.group(0)} ");
  return inputString.trim();
}
