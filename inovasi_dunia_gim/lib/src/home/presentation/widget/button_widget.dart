import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/notification_api.dart';
import '../../data/models/note_model.dart';
import '../bloc/schedules/schedules_bloc.dart';
import '../view/list_schedule_page.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget(
      {super.key,
      this.noteModel,
      required this.titleController,
      required this.descriptionController,
      required this.editDateController,
      required this.editDayController,
      required this.editDescriptionController,
      required this.editHourController,
      required this.editMinuteController,
      required this.editMonthController,
      required this.editTitleController,
      required this.editYearController});
  NoteModel? noteModel;
  TextEditingController titleController;
  TextEditingController descriptionController;
  TextEditingController editTitleController;
  TextEditingController editDescriptionController;
  TextEditingController editDayController;
  TextEditingController editDateController;
  TextEditingController editMonthController;
  TextEditingController editYearController;
  TextEditingController editHourController;
  TextEditingController editMinuteController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SchedulesBloc, SchedulesState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50)),
          onPressed: () {
            int uniqueID = UniqueKey().hashCode;

            String dayName = DateFormat('EEEE', 'id').format(state.initialDate);
            String yearsName =
                DateFormat('yyyy', 'id').format(state.initialDate);
            String monthName =
                DateFormat('MMMM', 'id').format(state.initialDate);

            if (state.selectTime == null && editDateController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Pilih Jadwal Kegiatan Dulu yaa'),
                duration: Duration(seconds: 3),
                backgroundColor: Colors.red,
              ));
            } else if (state.chooseDate == null &&
                editHourController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Pilih Tanggal Kegiatan Dulu yaa'),
                duration: Duration(seconds: 3),
                backgroundColor: Colors.red,
              ));
            }

            if (noteModel?.id != null) {
              if (editTitleController.text.isNotEmpty ||
                  titleController.text.isNotEmpty) {
                NotificationApi.showScheduledNotification(
                    id: noteModel?.id ?? uniqueID,
                    title: editTitleController.text.isNotEmpty
                        ? editTitleController.text
                        : titleController.text,
                    body: editDescriptionController.text,
                    payload:
                        '${editTitleController.text} ${editDateController.text}',
                    hour: state.selectTime != null
                        ? int.parse(
                            state.selectTime!.format(context).split(":")[0])
                        : int.parse(editHourController.text),
                    minutes: state.selectTime != null
                        ? int.parse(state.selectTime!
                            .format(context)
                            .split(":")[1]
                            .split(" ")[0])
                        : int.parse(editMinuteController.text),
                    date: state.chooseDate?.day ??
                        int.parse(editDateController.text),
                    month: state.chooseDate?.month ??
                        DateFormat('MMMM', 'id')
                            .parse(editMonthController.text)
                            .month,
                    year: state.chooseDate?.year ??
                        int.parse(editYearController.text));

                final note = NoteModel(
                    id: noteModel?.id ?? uniqueID,
                    title: editTitleController.text.trim(),
                    description: editDescriptionController.text.trim(),
                    hour: state.selectTime != null
                        ? state.selectTime!.format(context).split(":")[0]
                        : editHourController.text,
                    minute: state.selectTime != null
                        ? state.selectTime!
                            .format(context)
                            .split(":")[1]
                            .split(" ")[0]
                        : editMinuteController.text,
                    date: state.chooseDate?.day ??
                        int.parse(editDateController.text),
                    day: state.chooseDate != null
                        ? DateFormat('EEEE', 'id').format(state.chooseDate!)
                        : editDayController.text,
                    month: state.chooseDate != null
                        ? DateFormat('MMMM', 'id').format(state.chooseDate!)
                        : editMonthController.text,
                    year: state.chooseDate != null
                        ? DateFormat('yyyy', 'id').format(state.chooseDate!)
                        : editYearController.text,
                    location: state.location ?? "");
                state.chooseDate = null;
                state.selectTime = null;
                context
                    .read<SchedulesBloc>()
                    .add(EventUpdateNotes(noteModel: note));
                log(note.toJson().toString());
                context.read<SchedulesBloc>().add(EventReadAllNotes());
                AwesomeDialog(
                  autoHide: const Duration(seconds: 2),
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.bottomSlide,
                  title: 'Berhasil Diubah',
                ).show().then((value) => Navigator.pushNamedAndRemoveUntil(
                    context, ListNote.list, (route) => false));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Judul Kegiatan Tidak Boleh Kosong'),
                  duration: Duration(seconds: 3),
                  backgroundColor: Colors.red,
                ));
              }
            } else {
              if (titleController.text.isNotEmpty) {
                NotificationApi.showScheduledNotification(
                    id: uniqueID,
                    title: titleController.text,
                    body: descriptionController.text,
                    payload: uniqueID.toString(),
                    hour: int.parse(
                        state.selectTime!.format(context).split(":")[0]),
                    minutes: int.parse(state.selectTime!
                        .format(context)
                        .split(":")[1]
                        .split(" ")[0]),
                    date: state.chooseDate?.day,
                    month: state.chooseDate?.month,
                    year: state.chooseDate?.year);
                final note = NoteModel(
                    id: uniqueID,
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                    hour: state.selectTime!.format(context).split(":")[0],
                    minute: state.selectTime!
                        .format(context)
                        .split(":")[1]
                        .split(" ")[0],
                    date: state.chooseDate?.day,
                    day: DateFormat('EEEE', 'id').format(state.chooseDate!),
                    month: DateFormat('MMMM', 'id').format(state.chooseDate!),
                    year: DateFormat('yyyy', 'id').format(state.chooseDate!),
                    location: state.location);
                context
                    .read<SchedulesBloc>()
                    .add(EventCreateNotes(noteModel: note));
                context.read<SchedulesBloc>().add(EventReadAllNotes());
                state.chooseDate = null;
                state.selectTime = null;
                AwesomeDialog(
                  autoHide: const Duration(seconds: 2),
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.bottomSlide,
                  title: 'Berhasil Disimpan',
                ).show().then((value) => Navigator.pushNamedAndRemoveUntil(
                    context, ListNote.list, (route) => false));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Judul Kegiatan Tidak Boleh Kosong'),
                  duration: Duration(seconds: 3),
                  backgroundColor: Colors.red,
                ));
              }
            }
          },
          child: Text(
            noteModel?.id != null ? 'Ubah' : 'Simpan',
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
        );
      },
    );
  }
}
