// import 'package:block_projects/data/models/notes_model.dart';
//
// abstract class NotesState {}
//
// class NotesInitialState extends NotesState {}
//
// class NotesLoadingState extends NotesState {}
//
// class NotesErrorState extends NotesState {
//   final String errorText;
//
//   NotesErrorState({required this.errorText});
// }
//
// class NotesSuccessState extends NotesState {
//   NotesSuccessState({required this.notes});
//
//   final List<NotesModel> notes;
// }
//
// class NotesDeleteState extends NotesState {}


import '../../data/models/notes_model.dart';

abstract class NotesState {}

class NotesInitialState extends NotesState {}

class NotesLoadingState extends NotesState {}

class NotesSuccessState extends NotesState {
  NotesSuccessState({required this.notesList});

  final List<NotesModel> notesList;
}

class NoteSearch extends NotesState {
  NoteSearch({required this.text});

  final String text;
}

class NoteSearchSuccess extends NotesState {
  NoteSearchSuccess({required this.list});

  final List<NotesModel> list;
}


class NotesErrorState extends NotesState {
  NotesErrorState({required this.errorText});

  final String errorText;
}
