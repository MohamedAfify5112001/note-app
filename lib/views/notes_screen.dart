import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/bloc/note_bloc.dart';
import 'package:note_app/utils/boxes.dart';
import 'package:note_app/utils/component/sizedbox_comp.dart';
import 'package:note_app/views/add_note_screen.dart';
import 'package:note_app/views/note_details_screen.dart';
import 'package:note_app/views/search_note.dart';

import '../model/note_model.dart';
import '../utils/component/dissmissible_widget.dart';
import '../utils/component/navigator.dart';
import '../utils/component/note_card.dart';
import '../utils/component/snackbar_widget.dart';
import '../utils/component/text_component.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: Container(
            margin: EdgeInsets.only(bottom: 23.h, right: 8.w),
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
              foregroundColor: Theme.of(context).floatingActionButtonTheme.foregroundColor,
              onPressed: () {
                navigateToPush(context, const AddNoteScreen());
              },
              child: const Icon(Icons.add, size: 35),
            ),
          ),
          body: Builder(builder: (context) {
            Hive.openBox<Note>('notes');
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: ValueListenableBuilder(
                  valueListenable: BoxesNote.getNote().listenable(),
                  builder: (context, box, _) {
                    final List<Note> notes = box.values.toList().cast<Note>();
                    return SingleChildScrollView(
                      physics: notes.isNotEmpty
                          ? const BouncingScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextComponent(
                                text: "Notes",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 26.sp),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.read<NoteBloc>().changeTheme();
                                    },
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.r)),
                                    child: Container(
                                      height: 35.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                        color:
                                            (BlocProvider.of<NoteBloc>(context)
                                                    .isDark)
                                                ? Colors.grey.shade800
                                                : Colors.transparent,
                                        borderRadius:
                                            BorderRadiusDirectional.all(
                                                Radius.circular(8.r)),
                                      ),
                                      child: Icon(
                                        (context.watch<NoteBloc>().isDark)
                                            ? CupertinoIcons.sun_max_fill
                                            : CupertinoIcons.moon_stars,
                                        color:
                                            (context.watch<NoteBloc>().isDark)
                                                ? Colors.amber
                                                : Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBoxComponentWidth(width: 10.w),
                                  InkWell(
                                    onTap: () {
                                      showSearch(
                                          context: context,
                                          delegate:
                                              CustomSearchDelegate(notes));
                                    },
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.r)),
                                    child: Container(
                                      height: 35.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                        color:
                                            (BlocProvider.of<NoteBloc>(context)
                                                    .isDark)
                                                ? Colors.grey.shade800
                                                : Colors.transparent,
                                        borderRadius:
                                            BorderRadiusDirectional.all(
                                                Radius.circular(8.r)),
                                      ),
                                      child: const Icon(Icons.search),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          if (notes.isEmpty)
                            Container(
                              margin: EdgeInsets.only(top: 140.h, left: 23.w),
                              child: Lottie.asset(
                                  width: 310,
                                  "assets/json/shake-a-empty-box.json"),
                            )
                          else
                            Container(
                              margin: EdgeInsets.only(top: 13.h),
                              child: (notes.length > 2)
                                  ? BuildGridViewItems(notes: notes)
                                  : NotesItemList(notes: notes),
                            )
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class BuildGridViewItems extends StatelessWidget {
  const BuildGridViewItems({
    Key? key,
    required this.notes,
  }) : super(key: key);

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return MasonryGridView.builder(
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          shrinkWrap: true,
          itemCount: notes.length,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 2.w,
          mainAxisSpacing: 2.h,
          itemBuilder: (context, index) => DismissibleWidget(
              onDismissed: (onDelete) {
                NoQueriesFunction.deleteNote(notes[index]);
                showSnackBarComponent(
                  context,
                  TextComponent(
                    text: "Note is deleted Successfully",
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 14.sp,
                          color: (BlocProvider.of<NoteBloc>(context).isDark)
                              ? Colors.white
                              : Colors.white24,
                        ),
                  ),
                );
              },
              item: notes[index],
              child: GestureDetector(
                onTap: () {
                  navigateToPush(
                      context,
                      NoteDetailsScreen(
                        noteIndex: index,
                      ));
                },
                child: NoteItem(note: notes[index]),
              )),
        );
      },
    );
  }
}

class NotesItemList extends StatelessWidget {
  const NotesItemList({
    Key? key,
    required this.notes,
  }) : super(key: key);

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => DismissibleWidget(
                onDismissed: (direction) async {
                  NoQueriesFunction.deleteNote(notes[index]);
                  await showSnackBarComponent(
                    context,
                    TextComponent(
                      text: "Note is deleted Successfully",
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 14.sp,
                            color: (BlocProvider.of<NoteBloc>(context).isDark)
                                ? Colors.white
                                : Colors.white24,
                          ),
                    ),
                  );
                },
                item: notes[index],
                child: GestureDetector(
                    onTap: () {
                      navigateToPush(
                          context,
                          NoteDetailsScreen(
                            noteIndex: index,
                          ));
                    },
                    child: NoteItem(note: notes[index]))),
            separatorBuilder: (context, index) =>
                SizedBoxComponentWidth(width: 10.w),
            itemCount: notes.length);
      },
    );
  }
}
