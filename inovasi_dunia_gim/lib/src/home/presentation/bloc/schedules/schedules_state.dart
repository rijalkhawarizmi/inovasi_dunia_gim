part of 'schedules_bloc.dart';

class SchedulesState extends Equatable {
  final DateTime initialDate;
  DateTime? chooseDate;
  final String initialTime;
  TimeOfDay? selectTime;
  final List<NoteModel>? noteModel;
  final String? location;

  SchedulesState(
      {DateTime? initialDate,
      this.chooseDate,
      String? initialTime,
      this.selectTime,
      this.noteModel,
      this.location})
      : initialDate = initialDate ?? DateTime.now(),
        initialTime = initialTime ??
            DateFormat("hh:mm a").format(DateTime.now()).toString();

  SchedulesState copyWith(
      {DateTime? initialDate,
      DateTime? chooseDate,
      String? initialTime,
      TimeOfDay? selectTime,
      List<NoteModel>? noteModel,
      String? location}) {
    return SchedulesState(
      initialDate: initialDate ?? this.initialDate,
      chooseDate: chooseDate ?? this.chooseDate,
      initialTime: initialTime ?? this.initialTime,
      selectTime: selectTime ?? this.selectTime,
      noteModel: noteModel ?? this.noteModel,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props {
    return [
      initialDate,
      chooseDate,
      initialTime,
      selectTime,
      noteModel,
      location
    ];
  }
}
