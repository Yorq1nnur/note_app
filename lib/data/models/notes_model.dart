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
      noteColor: noteColor ?? this.noteColor,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NotesModelConstants.title: noteText,
      NotesModelConstants.color: noteColor,
      NotesModelConstants.date: createdDate.toString(),
    };
  }
}
