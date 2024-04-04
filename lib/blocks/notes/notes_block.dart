import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../local_data_base/local_db.dart';
import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitialState()) {
    on<GetNotesEvent>(_getNotes);
    on<DeleteNotesEvent>(_deleteNote);
    on<InsertNotesEvent>(_insertNote);
  }

  Future<void> _deleteNote(
    DeleteNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoadingState());

    if (event.notesModel.id != null) {
      await LocalDatabase.deleteNote(event.notesModel.id!);
      debugPrint("SUCCESS");
    }
    add(GetNotesEvent());
  }

  Future<void> _insertNote(
    InsertNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoadingState());
    LocalDatabase.insertNote(event.noteModel);
    await Future.delayed(const Duration(seconds: 1));
    add(GetNotesEvent());
  }

  Future<void> _getNotes(
    GetNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoadingState());
    var response = await LocalDatabase.getAllNote();
    if (response.isEmpty) {
      debugPrint("LIST'S EMPTY!!!");

      emit(NotesErrorState(errorText: "ERROR!!! LIST'S EMPTY!!!"));
    } else {
      emit(NotesSuccessState(notesList: response));
    }
  }
}
