
import '../../data/models/notes_model.dart';

abstract class NotesEvent {}

class GetNotesEvent extends NotesEvent {}
class GetSearchNotesEvent extends NotesEvent {}

class InsertNotesEvent extends NotesEvent {
  final NotesModel noteModel;

  InsertNotesEvent({required this.noteModel});
}

class DeleteNotesEvent extends NotesEvent {
  final NotesModel notesModel;

  DeleteNotesEvent({required this.notesModel});
}
class SearchNotesEvent extends NotesEvent {
  final String text;

  SearchNotesEvent({required this.text});
}
