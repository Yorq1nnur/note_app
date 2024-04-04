import 'dart:math';
import 'dart:ui';

import '../../local_data_base/notes_model_constants.dart';

class NotesModel {
  final int? id;
  final String noteText;
  final String createdDate;
  final String noteColor;

  NotesModel({
    this.id,
    required this.noteText,
    required this.createdDate,
    required this.noteColor,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      noteText: json[NotesModelConstants.title] as String? ??"IT'S NULL VALUE",
      createdDate: json[NotesModelConstants.date] as String? ??"IT'S NULL VALUE",
      noteColor: json[NotesModelConstants.color] as String? ??"IT'S NULL VALUE",
      id: json[NotesModelConstants.id] as int? ?? 0,
    );
  }

  NotesModel copyWith({
    int? id,
    String? noteText,
    String? noteColor,
    String? createdDate,
  }) {
    return NotesModel(
      noteText: noteText ?? this.noteText,
      noteColor: _getRandomColor().value.toString(),
      createdDate: createdDate ?? this.createdDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NotesModelConstants.title: noteText,
      NotesModelConstants.color: _getRandomColor().value.toString(),
      NotesModelConstants.date: createdDate.toString(),
    };
  }
}

Color _getRandomColor() {
  // Ranglar o'rtacha boshlang'ich qiymatlari
  int red = Random().nextInt(255);
  int green = Random().nextInt(255);
  int blue = Random().nextInt(255);

  // Black va grey ranglarni tekshiramiz
  if (red == 0 && green == 0 && blue == 0) {
    // Agar rang oq bo'lsa, 1 qo'shamiz
    red++;
  }
  if (red == 128 && green == 128 && blue == 128) {
    // Agar rang kulrang bo'lsa, 1 qo'shamiz
    red++;
  }

  // Yangi rangni qaytarish
  return Color.fromRGBO(red, green, blue, 1.0);
}
