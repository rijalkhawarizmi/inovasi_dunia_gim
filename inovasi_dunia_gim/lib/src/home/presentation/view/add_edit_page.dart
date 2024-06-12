import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovasi_dunia_gim/core/style/sized_box.dart';
import 'package:inovasi_dunia_gim/src/home/presentation/bloc/schedules/schedules_bloc.dart';
import 'package:inovasi_dunia_gim/src/home/presentation/widget/button_widget.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../../data/models/note_model.dart';

class AddEditNote extends StatefulWidget {
  final NoteModel? noteModel;
  static const String addEdit = "addedit";
  const AddEditNote({Key? key, this.noteModel}) : super(key: key);

  @override
  State<AddEditNote> createState() => _AddEditNoteState();
}

class _AddEditNoteState extends State<AddEditNote> {
  final _globalKey = GlobalKey<ScaffoldMessengerState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late TextEditingController editTitleController;
  late TextEditingController editDescriptionController;
  late TextEditingController editDayController;
  late TextEditingController editDateController;
  late TextEditingController editMonthController;
  late TextEditingController editYearController;
  late TextEditingController editHourController;
  late TextEditingController editMinuteController;

  @override
  void initState() {
    editTitleController =
        TextEditingController(text: widget.noteModel?.title ?? '');
    editDescriptionController =
        TextEditingController(text: widget.noteModel?.description ?? '');
    editDayController = TextEditingController(text: widget.noteModel?.day);
    editDateController =
        TextEditingController(text: widget.noteModel?.date.toString());
    editMonthController = TextEditingController(text: widget.noteModel?.month);
    editYearController = TextEditingController(text: widget.noteModel?.year);
    editMinuteController =
        TextEditingController(text: widget.noteModel?.minute.toString());
    editHourController =
        TextEditingController(text: widget.noteModel?.hour.toString());
    super.initState();
    initializeDateFormatting('id', null);
  }

  @override
  void dispose() {
    super.dispose();
    editTitleController.dispose();
    editDescriptionController.dispose();
    editDayController.dispose();
    editDateController.dispose();
    editMonthController.dispose();
    editYearController.dispose();
    editMinuteController.dispose();
    editHourController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(backgroundColor: Colors.blue),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Hari ini Tanggal :'),
                    BlocBuilder<SchedulesBloc, SchedulesState>(
                      builder: (context, state) {
                        return Text(
                          DateFormat('dd MMMM yyyy', 'id')
                              .format(state.initialDate),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        );
                      },
                    ),
                  ],
                ),
                const Text('Lokasi Kamu :'),
                BlocBuilder<SchedulesBloc, SchedulesState>(
                  builder: (context, state) {
                    return Text(
                      state.location ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    );
                  },
                ),
                const VerticalSizedBox(height: 20),
                TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(45),
                    ],
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(fontSize: 12),
                      hintText: 'Masukkan Judul Kegiatan',
                      contentPadding: const EdgeInsets.only(left: 10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    controller: editTitleController.text.isNotEmpty
                        ? editTitleController
                        : titleController),
                const VerticalSizedBox(height: 10),
                TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(fontSize: 12),
                      hintText:
                          'Masukkan Deskripsi Kegiatan \n(Boleh dikosongkan)',
                      contentPadding: const EdgeInsets.only(left: 10, top: 5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    controller: editDescriptionController.text.isNotEmpty
                        ? editDescriptionController
                        : descriptionController),
                const VerticalSizedBox(height: 10),
                BlocBuilder<SchedulesBloc, SchedulesState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              context
                                  .read<SchedulesBloc>()
                                  .add(EventGetDateFromUser(context: context));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blue),
                              child: Center(
                                child: state.chooseDate == null
                                    ? editDateController.text.isNotEmpty
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                editDayController.text,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '${editDateController.text} ${editMonthController.text} ${editYearController.text}',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 1),
                                                ),
                                              ),
                                            ],
                                          )
                                        : const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              // Image(image: AssetImage(NoteImage.icon_date),height: 30,width: 30,),
                                              Text(
                                                'Pilih Tanggal',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1),
                                              ),
                                            ],
                                          )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            DateFormat('EEEE', 'id')
                                                .format(state.chooseDate!),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1),
                                          ),
                                          Expanded(
                                            child: Text(
                                              DateFormat('dd MMMM yyyy', 'id')
                                                  .format(state.chooseDate!),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              context
                                  .read<SchedulesBloc>()
                                  .add(EventSelectTimes(context: context));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Image(image: AssetImage(NoteImage.icon_clock),height: 30,width: 30,),
                                  Text(
                                    state.selectTime == null
                                        ? editHourController.text.isNotEmpty
                                            ? "Jam ${editHourController.text}:${editMinuteController.text}"
                                            : 'Pilih Jadwal'
                                        : 'Jam ${state.selectTime!.format(context).substring(0, 5)}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
                const VerticalSizedBox(height: 10),
                ButtonWidget(
                    noteModel: widget.noteModel,
                    titleController: titleController,
                    descriptionController: descriptionController,
                    editDateController: editDateController,
                    editDayController: editDayController,
                    editDescriptionController: editDescriptionController,
                    editHourController: editHourController,
                    editMinuteController: editMinuteController,
                    editMonthController: editMonthController,
                    editTitleController: editTitleController,
                    editYearController: editYearController)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
