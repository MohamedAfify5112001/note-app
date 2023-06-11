import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/bloc/note_bloc.dart';

import '../model/note_model.dart';
import '../utils/boxes.dart';
import '../utils/component/navigator.dart';
import '../utils/component/sizedbox_comp.dart';
import '../utils/component/snackbar_widget.dart';
import '../utils/component/text_component.dart';

class EditNoteScreen extends StatefulWidget {
  final Note note;

  const EditNoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController noteEditingController = TextEditingController();

  @override
  void initState() {
    titleEditingController.text = widget.note.title;
    noteEditingController.text = widget.note.content;
    super.initState();
  }

  @override
  void dispose() {
    noteEditingController.dispose();
    titleEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 14.h),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                          onTap: () {
                            popToPreviousScreen(context);
                          },
                          child: Container(
                            height: 35.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                              color: (BlocProvider.of<NoteBloc>(context).isDark)
                                  ? Colors.grey.shade800
                                  : Colors.transparent,
                              borderRadius: BorderRadiusDirectional.all(
                                  Radius.circular(8.r)),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 22,
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                          onTap: () async {
                            if (titleEditingController.text !=
                                    widget.note.title ||
                                noteEditingController.text !=
                                    widget.note.content) {
                              await NoQueriesFunction.editNote(
                                  widget.note,
                                  titleEditingController.text,
                                  noteEditingController.text);
                              if (!mounted) return;
                              await showSnackBarComponent(
                                  context,
                                  TextComponent(
                                      text: "Note is Edited Successfully",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                            fontSize: 14.sp,
                                            color: (BlocProvider.of<NoteBloc>(
                                                        context)
                                                    .isDark)
                                                ? Colors.white
                                                : Colors.grey[300],
                                          )));
                            }
                            if (!mounted) return;
                            popToPreviousScreen(context);
                          },
                          child: Container(
                              height: 35.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                color:
                                    (BlocProvider.of<NoteBloc>(context).isDark)
                                        ? Colors.grey.shade800
                                        : Colors.transparent,
                                borderRadius: BorderRadiusDirectional.all(
                                    Radius.circular(8.r)),
                              ),
                              child: Center(
                                child: TextComponent(
                                  text: "Edit",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700),
                                ),
                              )),
                        )
                      ],
                    ),
                    SizedBoxComponentHeight(height: 14.h),
                    TextFormField(
                      controller: titleEditingController,
                      cursorColor: (BlocProvider.of<NoteBloc>(context).isDark)
                          ? Colors.white24
                          : Colors.grey[700],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Title",
                        hintStyle:
                            Theme.of(context).textTheme.headline3!.copyWith(
                                  fontSize: 30.sp,
                                  color: Colors.grey[400],
                                ),
                      ),
                    ),
                    SizedBoxComponentHeight(height: 10.h),
                    TextFormField(
                      controller: noteEditingController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      cursorColor: (BlocProvider.of<NoteBloc>(context).isDark)
                          ? Colors.white24
                          : Colors.grey[700],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type Something.....",
                        hintStyle:
                            Theme.of(context).textTheme.headline3!.copyWith(
                                  fontSize: 16.sp,
                                  color: Colors.grey[400],
                                ),
                      ),
                    ),
                    SizedBoxComponentHeight(height: 400.h),
                    SizedBoxComponentHeight(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
