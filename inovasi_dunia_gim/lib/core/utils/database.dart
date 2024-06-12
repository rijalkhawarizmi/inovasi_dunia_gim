import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../src/home/data/models/note_model.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');

    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final textType = 'TEXT NOT NULL';
    final intType = 'INT NOT NULL';

    await db.execute('''CREATE TABLE  $tableData (
      ${ResultField.id} $intType,
      ${ResultField.title} $textType,
      ${ResultField.description} $textType,
      ${ResultField.hour} $textType,
      ${ResultField.minute} $textType,
      ${ResultField.date} $intType,
      ${ResultField.day} $textType,
      ${ResultField.month} $textType,
      ${ResultField.year} $textType,
      ${ResultField.location} $textType
    )''');
  }

  Future<NoteModel> create(NoteModel note) async {
    final db = await instance.database;
    final id = await db.insert(tableData, note.toJson());

    return note.copy(id: id);
  }

  Future<NoteModel> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableData,
        columns: ResultField.values,
        where: '${ResultField.id}=?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return NoteModel.fromJson(maps.first);
    } else {
      throw Exception(' $id not found');
    }
  }

  Future<List<NoteModel>> readAllNotes() async {
    final db = await instance.database;

    final result = await db.query(tableData);

    return result.map((e) => NoteModel.fromJson(e)).toList();
  }

  Future<bool> update(NoteModel resultOffline) async {
    final db = await instance.database;

    await db.update(tableData, resultOffline.toJson(),
        where: '${ResultField.id}= ?', whereArgs: [resultOffline.id]);

    return Future.value(true);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    int result = await db
        .delete(tableData, where: '${ResultField.id} = ?', whereArgs: [id]);
    return result;
  }

}
