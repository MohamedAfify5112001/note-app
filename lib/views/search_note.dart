import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/note_model.dart';
import '../utils/component/navigator.dart';
import '../utils/component/note_card.dart';
import '../utils/component/sizedbox_comp.dart';
import 'note_details_screen.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Note> notes;

  CustomSearchDelegate(this.notes);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Note> matches = [];

    matches = notes
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                navigateToPush(
                    context,
                    NoteDetailsScreen(
                      noteIndex: notes.indexOf(matches[index]),
                    ));
              },
              child: NoteItem(note: matches[index])),
          separatorBuilder: (context, index) =>
              SizedBoxComponentWidth(width: 10.w),
          itemCount: matches.length),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Note> matches = [];
    matches = notes
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                navigateToPush(
                    context,
                    NoteDetailsScreen(
                      noteIndex: notes.indexOf(matches[index]),
                    ));
              },
              child: NoteItem(note: matches[index])),
          separatorBuilder: (context, index) =>
              SizedBoxComponentWidth(width: 10.w),
          itemCount: matches.length),
    );
  }
}
