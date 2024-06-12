import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../core/utils/database.dart';
import '../../../data/models/note_model.dart';
import '../../widget/date_widget.dart';

part 'schedules_event.dart';
part 'schedules_state.dart';

class SchedulesBloc extends Bloc<SchedulesEvent, SchedulesState> {
  SchedulesBloc() : super(SchedulesState()) {
    on<EventGetDateFromUser>(getDateFromUser);
    on<EventSelectTimes>(selectTimes);
    on<EventReadAllNotes>(readAllNotes);
    on<EventCreateNotes>(createNotes);
    on<EventUpdateNotes>(updateNotes);
    on<EventDeleteNotes>(deleteNotes);
    on<EventGetLocation>(getAddress);
  }

  void getDateFromUser(
      EventGetDateFromUser event, Emitter<SchedulesState> emit) async {
    DateTime? date = await showDatePicker(
      context: event.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2026),
    );
    if (date != null) {
      emit(state.copyWith(chooseDate: date));
    }
  }

  Future<void> selectTimes(
      EventSelectTimes event, Emitter<SchedulesState> emit) async {
    TimeOfDay selectedTime = TimeOfDay.now();
    final TimeOfDay? pickedTime = await showCupertinoModalPopup<TimeOfDay>(
      context: event.context,
      builder: (BuildContext context) {
        return TimeWidget(
          initialTime: selectedTime,
          onTimeSelected: (TimeOfDay time) {
            selectedTime = time;
            emit(state.copyWith(selectTime: selectedTime));
          },
        );
      },
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      selectedTime = pickedTime;

      emit(state.copyWith(selectTime: selectedTime));
    }
  }

  void readAllNotes(
      EventReadAllNotes event, Emitter<SchedulesState> emit) async {
    final note = await NotesDatabase.instance.readAllNotes();
    emit(state.copyWith(noteModel: note));
  }

  void createNotes(EventCreateNotes event, Emitter<SchedulesState> emit) async {
    await NotesDatabase.instance.create(event.noteModel);
  }

  void updateNotes(EventUpdateNotes event, Emitter<SchedulesState> emit) async {
    await NotesDatabase.instance.update(event.noteModel);
  }

  void deleteNotes(EventDeleteNotes event, Emitter<SchedulesState> emit) async {
    await NotesDatabase.instance.delete(event.id);
  }

  Future<void> getAddress(
      EventGetLocation event, Emitter<SchedulesState> emit) async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        AwesomeDialog(
          dismissOnTouchOutside: false,
          context: event.context,
          dialogType: DialogType.warning,
          animType: AnimType.bottomSlide,
          btnOkText: 'Pengaturan',
          btnCancelText: 'Batal',
          btnCancelColor: Colors.red,
          btnOkColor: Colors.greenAccent,
          title: 'Lokasi kamu belum aktif',
          btnCancelOnPress: () {
            Navigator.pop(event.context);
          },
          btnOkOnPress: () {
            openAppSettings();
          },
        ).show();
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks.first;
      String resolvedAddress =
          "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      emit(state.copyWith(location: resolvedAddress));
    } catch (e) {
      String addressNotFound = "Lokasi tidak ditemukan";
      emit(state.copyWith(location: addressNotFound));
    }
  }
}
