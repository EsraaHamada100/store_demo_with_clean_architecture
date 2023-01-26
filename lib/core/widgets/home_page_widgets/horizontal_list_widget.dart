import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HorizontalListWidget extends StatelessWidget {
  const HorizontalListWidget({required this.stringsList, super.key});
  final List<String> stringsList;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: stringsList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          height: 12.h,
          width: 12.h,
          alignment: Alignment.center,
          padding: EdgeInsets.all(1.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 1,
                color: Colors.black12,
              ),
            ],
          ),
          child: Text(
            stringsList[index],
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall,
            maxLines: 2,
          ),
        ),
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(width: 5.w),
      ),
    );
  }
}
