import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/utils/component/sizedbox_comp.dart';
import 'package:note_app/utils/component/text_component.dart';

import '../../model/note_model.dart';

class NoteItem extends StatelessWidget {
  final Note note;

  const NoteItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(8.r))),
      color: Color(note.color),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextComponent(
                text: note.title,
                maxLines: 10,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black87,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400)),
            SizedBoxComponentHeight(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextComponent(
                    text: note.dateTime,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.white, fontSize: 10.sp)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
