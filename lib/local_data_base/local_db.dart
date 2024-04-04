import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:note_app/local_data_base/notes_model_constants.dart';
import 'package:sqflite/sqflite.dart';
import '../data/models/notes_model.dart';

class LocalDatabase {
  static final databaseInstance = LocalDatabase._();

  LocalDatabase._();

  factory LocalDatabase() {
    return databaseInstance;
  }

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _init("note_app.db");
      return _database!;
    }
  }

  Future<Database> _init(String databaseName) async {
    String internalPath = await getDatabasesPath();
    String path = join(internalPath, databaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";

    await db.execute('''CREATE TABLE ${NotesModelConstants.tableName} (
    ${NotesModelConstants.id} $idType,
    ${NotesModelConstants.title} $textType,
    ${NotesModelConstants.color} $textType,
    ${NotesModelConstants.date} $textType
  )''');
  }

  static Future<NotesModel> insertNote(NotesModel noteModel) async {
    debugPrint("INITIAL ID:${noteModel.id}");

    final db = await databaseInstance.database;
    int savedNoteID =
        await db.insert(NotesModelConstants.tableName, noteModel.toJson());

    debugPrint("SAVED ID:$savedNoteID");

    return noteModel.copyWith(id: savedNoteID);
  }

  static Future<int> updateNote(
      NotesModel notesModel,
      int id,
      ) async {
    debugPrint("UPDATE: ${notesModel.toJson()} ${notesModel.id}");

    final db = await databaseInstance.database;
    int updatedTaskId = await db.update(
      NotesModelConstants.tableName,
      notesModel.toJson(),
      where: "${NotesModelConstants.id} = ?",
      whereArgs: [id],
    );
    return updatedTaskId;
  }

  static Future<List<NotesModel>> getAllNote() async {
    final db = await databaseInstance.database;
    String orderBy = "${NotesModelConstants.id} DESC";
    List json = await db.query(NotesModelConstants.tableName, orderBy: orderBy);
    return json.map((e) => NotesModel.fromJson(e)).toList();
  }

  static Future<int> deleteNote(int id) async {
    final db = await databaseInstance.database;
    int deletedId = await db.delete(
      NotesModelConstants.tableName,
      where: "${NotesModelConstants.id} = ?",
      whereArgs: [id],
    );
    return deletedId;
  }

  static Future<List<NotesModel>> searchNote(String query) async {
    final db = await databaseInstance.database;
    var json = await db.query(
      NotesModelConstants.tableName,
      where: "${NotesModelConstants.title} LIKE ?",
      whereArgs: ["$query%"],
    );
    return json.map((e) => NotesModel.fromJson(e)).toList();
  }
}
