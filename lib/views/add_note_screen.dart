import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:note_app/utils/colors.dart';
import '../bloc/note_bloc.dart';
import '../utils/boxes.dart';
import '../utils/component/navigator.dart';
import '../utils/component/sizedbox_comp.dart';
import '../utils/component/text_component.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController noteEditingController = TextEditingController();

  Color primaryColor = AppColors.colors[0];

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
                            await NoQueriesFunction.addNote(NoteParameters(
                                titleEditingController.text.toString(),
                                noteEditingController.text.toString(),
                                DateFormat.yMMMMd()
                                    .format(DateTime.now())
                                    .toString(),
                                primaryColor.value));
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
                                  text: "Save",
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
                                  color: (BlocProvider.of<NoteBloc>(context).isDark)
                                      ? Colors.grey[400]
                                      : Colors.grey[500],
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
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(
                              fontSize: 16.sp,
                              color: (BlocProvider.of<NoteBloc>(context).isDark)
                                  ? Colors.grey[400]
                                  : Colors.grey[500],
                            ),
                      ),
                    ),
                    SizedBoxComponentHeight(height: 400.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        AppColors.colors.length,
                        (index) => circleColors(
                          color: AppColors.colors[index],
                        ),
                      ),
                    ),
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

  Widget circleColors({required Color color}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              primaryColor = color;
            });
          },
          child: Container(
            width: 40.w,
            height: 50.h,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ),
        if (primaryColor == color) const Icon(Icons.check, size: 26),
      ],
    );
  }
}
