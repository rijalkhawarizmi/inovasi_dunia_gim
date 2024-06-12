import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovasi_dunia_gim/core/style/sized_box.dart';
import 'package:inovasi_dunia_gim/src/home/presentation/bloc/schedules/schedules_bloc.dart';
import '../../../../core/utils/notification_api.dart';
import 'add_edit_page.dart';

class ListNote extends StatelessWidget {
  static const String list = "/";
  const ListNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SchedulesBloc>(context).add(EventReadAllNotes());
    return Scaffold(
        appBar: AppBar(
            title: Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            const Text(
              'Reminder',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            BlocProvider.of<SchedulesBloc>(context)
                .add(EventGetLocation(context: context));
            Navigator.pushNamed(context, AddEditNote.addEdit);
          },
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<SchedulesBloc, SchedulesState>(
          builder: (context, state) {
            return state.noteModel == null || state.noteModel!.isEmpty
                ? const Center(
                    child: Text(
                      'Belum Ada Catatan',
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.noteModel?.length,
                    itemBuilder: (c, index) {
                      final item = state.noteModel?[index];
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          title: Text(item?.title ?? ""),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item?.description ?? ""),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("${item?.day},"),
                                  const SizedBox(width: 3),
                                  Text('${item?.date}'),
                                  const SizedBox(width: 3),
                                  Text('${item?.month}'),
                                  const SizedBox(width: 3),
                                  Text('${item?.year}'),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Jam'),
                                  const SizedBox(width: 3),
                                  Text('${item?.hour}:'),
                                  Text("${item?.minute}"),
                                ],
                              ),
                              Text(item?.location ?? "")
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AddEditNote.addEdit,
                                          arguments: item);
                                      state.chooseDate = null;
                                      state.selectTime = null;
                                    },
                                    child: Icon(Icons.edit)),
                              ),
                              VerticalSizedBox(height: 20),
                              Expanded(
                                child: InkWell(
                                    onTap: () {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.warning,
                                        animType: AnimType.bottomSlide,
                                        btnOkText: 'Ya',
                                        btnCancelText: 'Tidak',
                                        btnCancelColor: Colors.greenAccent,
                                        btnOkColor: Colors.red,
                                        title:
                                            'Apakah Anda Yakin Ingin Menghapus Catatan ini',
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () {
                                          NotificationApi.cancelNotification(
                                              item!.id!);
                                          context.read<SchedulesBloc>().add(
                                              EventDeleteNotes(id: item.id!));
                                          context
                                              .read<SchedulesBloc>()
                                              .add(EventReadAllNotes());

                                          // cancel the notification with id value of zero
                                          AwesomeDialog(
                                            autoHide:
                                                const Duration(seconds: 2),
                                            context: context,
                                            dialogType: DialogType.success,
                                            animType: AnimType.bottomSlide,
                                            title: 'Berhasil Dihapus',
                                          ).show();
                                        },
                                      ).show();
                                    },
                                    child: Icon(Icons.delete)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ));
  }
}
