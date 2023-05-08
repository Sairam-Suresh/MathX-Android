// Tools View

double PADDING_BETWEEN_SQUARES = 10;

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
