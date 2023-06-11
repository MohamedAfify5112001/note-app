import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/bloc/note_bloc.dart';
import 'package:note_app/utils/component/navigator.dart';
import 'package:note_app/utils/component/sizedbox_comp.dart';
import 'package:note_app/utils/component/text_component.dart';
import 'package:note_app/views/edit_note_screen.dart';

import '../model/note_model.dart';
import '../utils/boxes.dart';

class NoteDetailsScreen extends StatelessWidget {
  final int noteIndex;

  const NoteDetailsScreen({Key? key, required this.noteIndex})
      : super(key: key);

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
                child: ValueListenableBuilder(
                  valueListenable: BoxesNote.getNote().listenable(),
                  builder: (context, box, _) {
                    final List<Note> notes = box.values.toList().cast<Note>();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.r)),
                              onTap: () {
                                popToPreviousScreen(context);
                              },
                              child: Container(
                                height: 35.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  color: (BlocProvider.of<NoteBloc>(context)
                                          .isDark)
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.r)),
                              onTap: () {
                                navigateToPush(
                                    context,
                                    EditNoteScreen(
                                      note: notes[noteIndex],
                                    ));
                              },
                              child: Container(
                                height: 35.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  color: (BlocProvider.of<NoteBloc>(context)
                                          .isDark)
                                      ? Colors.grey.shade800
                                      : Colors.transparent,
                                  borderRadius: BorderRadiusDirectional.all(
                                      Radius.circular(8.r)),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 22,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBoxComponentHeight(height: 16.h),
                        TextComponent(
                          text: notes[noteIndex].title,
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  fontSize: 20.sp, fontWeight: FontWeight.w600),
                        ),
                        SizedBoxComponentHeight(height: 12.h),
                        TextComponent(
                          text: notes[noteIndex].dateTime,
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[500]),
                        ),
                        SizedBoxComponentHeight(height: 16.h),
                        (notes[noteIndex].content.isNotEmpty)
                            ? TextComponent(
                                text: notes[noteIndex].content,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            (BlocProvider.of<NoteBloc>(context)
                                                    .isDark)
                                                ? Colors.grey[300]
                                                : Colors.grey[600]),
                              )
                            : const SizedBox.shrink(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
