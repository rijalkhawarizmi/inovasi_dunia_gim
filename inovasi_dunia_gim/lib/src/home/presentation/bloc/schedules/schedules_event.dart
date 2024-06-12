// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'schedules_bloc.dart';

sealed class SchedulesEvent extends Equatable {
  const SchedulesEvent();

  @override
  List<Object> get props => [];
}

class EventGetDateFromUser extends SchedulesEvent {
  final BuildContext context;
  const EventGetDateFromUser({required this.context});

  @override
  List<Object> get props => [context];
}

class EventSelectTimes extends SchedulesEvent {
  final BuildContext context;
  const EventSelectTimes({required this.context});

  @override
  List<Object> get props => [context];
}

class EventReadAllNotes extends SchedulesEvent {
  @override
  List<Object> get props => [];
}

class EventCreateNotes extends SchedulesEvent {
  final NoteModel noteModel;
  const EventCreateNotes({
    required this.noteModel,
  });

  @override
  List<Object> get props => [noteModel];
}

class EventUpdateNotes extends SchedulesEvent {
  final NoteModel noteModel;
  const EventUpdateNotes({
    required this.noteModel,
  });

  @override
  List<Object> get props => [noteModel];
}

class EventDeleteNotes extends SchedulesEvent {
  final int id;
  const EventDeleteNotes({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class EventGetLocation extends SchedulesEvent {
  final BuildContext context;
  const EventGetLocation({required this.context});
  @override
  List<Object> get props => [];
}
