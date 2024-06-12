final tableData = 'data';

class ResultField {
  static final List<String> values = [
    id,
    title,
    description,
    hour,
    minute,
    day,
    date,
    month,
    year,
    location
  ];
  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String hour = 'hour';
  static final String minute = 'minute';
  static final String date = 'date';
  static final String day = 'day';
  static final String month = 'month';
  static final String year = 'year';
  static final String location = 'location';
}

class NoteModel {
  int? id;
  String? title;
  String? description;
  String? hour;
  String? minute;
  int? date;
  String? day;
  String? month;
  String? year;
  String? location;

  NoteModel(
      {this.id,
      this.title,
      this.description,
      this.hour,
      this.minute,
      this.date,
      this.day,
      this.month,
      this.year,this.location});

  NoteModel copy({
    int? id,
    String? title,
    String? description,
    String? hour,
    String? minute,
    int? date,
    String? day,
    String? month,
    String? year,
    String? location,
  }) =>
      NoteModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        date: date ?? this.date,
        day: day ?? this.day,
        month: month ?? this.month,
        year: year ?? this.year,
        location: location ?? this.location,
      );

  static NoteModel fromJson(Map<String, Object?> json) => NoteModel(
        id: json[ResultField.id] as int,
        title: json[ResultField.title] as String,
        description: json[ResultField.description] as String,
        hour: json[ResultField.hour] as String,
        minute: json[ResultField.minute] as String,
        date: json[ResultField.date] as int,
        day: json[ResultField.day] as String,
        month: json[ResultField.month] as String,
        year: json[ResultField.year] as String,
        location: json[ResultField.location] as String,
      );
  Map<String, Object?> toJson() => {
        ResultField.id: id,
        ResultField.title: title,
        ResultField.description: description,
        ResultField.hour: hour,
        ResultField.minute: minute,
        ResultField.date: date,
        ResultField.day: day,
        ResultField.month: month,
        ResultField.year: year,
        ResultField.location: location,
      };
}
