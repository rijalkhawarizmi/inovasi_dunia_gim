import 'package:flutter/material.dart';
import 'package:inovasi_dunia_gim/src/home/data/models/note_model.dart';
import 'package:inovasi_dunia_gim/src/home/presentation/view/list_schedule_page.dart';
import '../../src/home/presentation/view/add_edit_page.dart';
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
     case ListNote.list:
      return MaterialPageRoute(
        builder: (_) => const ListNote(),
      );
       case AddEditNote.addEdit:
      return MaterialPageRoute(
        builder: (_) => AddEditNote(noteModel: settings.arguments as NoteModel?,),
      );
    default:
      return MaterialPageRoute(builder: (_) => Container());
  }
}