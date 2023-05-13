// Tools View

const double PADDING_BETWEEN_SQUARES = 10;

const double PADDING_FOR_MODAL_BOTTOM_SHEET = 15;

class Note {
  Note(
      {required this.name,
      required this.description,
      required this.date,
      required this.content});
  late String name;
  late String description;
  late DateTime date;
  late String content;
}

enum ToolCategory {
  Calculators,
  Graphers,
  Randomise,
  Unit_Converter;
}

enum HCFLCM { HCF, LCM }

enum HCFOptions { primeNumberOnly }

enum Averages { mean, median, mode, standardDeviation }
