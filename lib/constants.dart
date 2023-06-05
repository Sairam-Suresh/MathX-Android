// Tools View

const double PADDING_BETWEEN_SQUARES = 10;

const double PADDING_FOR_MODAL_BOTTOM_SHEET = 15;

class Note {
  Note({
    required this.name,
    required this.date,
    required this.content,
    this.renderMath,
  });

  late String name;
  late DateTime date;
  late String content;
  late bool? renderMath;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date.toIso8601String(),
      'content': content,
      'renderMath': renderMath == true ? 1 : 0,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      name: map['name'],
      date: DateTime.parse(map['date']),
      content: map['content'],
      renderMath: map['renderMath'] == 1 ? true : false,
    );
  }
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

enum RandomiserPages { recent, occurences }
