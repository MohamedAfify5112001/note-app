import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DismissibleWidget<T> extends StatelessWidget {
  final T item;
  final DismissDirectionCallback onDismissed;
  final Widget child;

  const DismissibleWidget(
      {super.key,
      required this.item,
      required this.child,
      required this.onDismissed});

  @override
  Widget build(BuildContext context) => Dismissible(
        key: ObjectKey(item),
        onDismissed: onDismissed,
        background: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.all(Radius.circular(8.r)),
            color: Colors.red,
          ),
          child: const Icon(
            Icons.delete_forever_sharp,
            color: Colors.white,
            size: 29,
          ),
        ),
        secondaryBackground: Container(
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.all(Radius.circular(8.r)),
            color: Colors.red,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: const Icon(
            Icons.delete_forever_sharp,
            color: Colors.white,
            size: 29,
          ),
        ),
        child: child,
      );
}
