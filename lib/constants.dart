// Tools View

const double PADDING_BETWEEN_SQUARES = 10;

const double PADDING_FOR_MODAL_BOTTOM_SHEET = 15;

extension Capitalise on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

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

enum HCFLCM { HCF, LCM }

enum HCFOptions { primeNumberOnly }

enum Averages { mean, median, mode, standardDeviation }

enum RandomiserPages { recent, occurences }

enum setEvalType { union, intersection }

class CheatsheetDetails {
  String title;
  SecondaryLevel secondaryLevel;
  bool isComingSoon;
  bool isStarred;

  CheatsheetDetails(
    this.title,
    this.secondaryLevel, [
    this.isComingSoon = false,
    this.isStarred = false,
  ]);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'secondaryLevel': secondaryLevel.toString(),
      'isComingSoon': isComingSoon ? 1 : 0,
      'isStarred': isStarred ? 1 : 0,
    };
  }

  factory CheatsheetDetails.fromMap(Map<String, dynamic> map) {
    return CheatsheetDetails(
      map['title'],
      _parseSecondaryLevel(map['secondaryLevel']),
      map['isComingSoon'] == 1,
      map['isStarred'] == 1,
    );
  }

  static SecondaryLevel _parseSecondaryLevel(String level) {
    switch (level) {
      case 'SecondaryLevel.one':
        return SecondaryLevel.one;
      case 'SecondaryLevel.two':
        return SecondaryLevel.two;
      case 'SecondaryLevel.three':
        return SecondaryLevel.three;
      case 'SecondaryLevel.four':
        return SecondaryLevel.four;
      default:
        throw ArgumentError('Invalid secondary level: $level');
    }
  }
}

enum SecondaryLevel { one, two, three, four }
