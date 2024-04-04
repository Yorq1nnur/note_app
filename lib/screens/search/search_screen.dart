import 'package:flutter/material.dart';
import 'package:note_app/data/models/notes_model.dart';
import 'package:note_app/screens/detail_screen/detail_screen.dart';
import 'package:note_app/utils/styles/app_text_style.dart';

class MySearchDelegate extends SearchDelegate<String> {
  final List<String> data;
  final List<NotesModel> notes;

  MySearchDelegate(
    this.data,
    this.notes,
  );

  // late NotesModel notesModel;
  int i = 0;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results =
        data.where((element) => element.contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(results[index]),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                notesModel: notes[index],
              ),
            ),
          );
          close(context, results[index]);
          debugPrint(
            notes[index].noteText,
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? data
        : data.where((element) => element.contains(query)).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(
          suggestionList[index],
          style: AppTextStyle.interBold.copyWith(color: Colors.white),
        ),
        onTap: () {
          i = index;
          // for (int i = 0; i < notes.length; i++) {
          //   if (notes[i].noteText == query) {
          //     notesModel = notes[i];
          //   }
          // }
          query = suggestionList[index];
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                notesModel: notes[i],
              ),
            ),
          );
        },
      ),
    );
  }
}
