import 'package:fizmat_app_flutter/fizmat_utils/schedule.dart';
import 'package:fizmat_app_flutter/widgets/category_boxes_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';

class CategoryBoxes extends StatefulWidget {
  final Function(bool isSelected)? onPressed;
  final String? text;
  final bool? isCurrent;
  final bool? isTillTheEnd;

  const CategoryBoxes({Key? key,
    this.onPressed,
    this.text,
    this.isCurrent,
    this.isTillTheEnd
  }) : super(key: key);

  @override
  State<CategoryBoxes> createState() => _CategoryBoxesState();
}

class _CategoryBoxesState extends State<CategoryBoxes> {
  @override
  Widget build(BuildContext context) {
    if (widget.isCurrent ?? false) {
      return FutureBuilder<List<List<String>>>(
          future: Schedule.get_class_schedule(),
          builder: (context, snapshot) {
            Widget _child;
            if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data![0][0].toString() == "0") {
                _child = Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Container(
                      height: 78.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xff1C2031),
                      ),
                      child: Center(
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
                          child: Text("You have not choosed your class yet",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:  17.sp,
                                  fontWeight: FontWeight.normal
                              ),
                              textAlign: TextAlign.center)
                        ),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.data![0][0].toString() == "1") {
                _child = Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Container(
                      height: 78.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xff1C2031),
                      ),
                      child: Center(
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
                          child: Text("No such class has been found",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:  17.sp,
                                  fontWeight: FontWeight.normal
                              ),
                              textAlign: TextAlign.center)
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                _child = Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Container(
                      height: 78.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xff1C2031),
                      ),
                      child: Center(
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
                          child: Text("nigger",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:  17.sp,
                                  fontWeight: FontWeight.normal
                              ),
                              textAlign: TextAlign.center
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }
            else {
              List<List<String>?> schedule = [prefs?.getStringList("class_monday"), prefs?.getStringList("class_tuesday"), prefs?.getStringList("class_wednesday"), prefs?.getStringList("class_thursday"), prefs?.getStringList("class_friday"), prefs?.getStringList("class_monday_schedule"), prefs?.getStringList("class_tuesday_schedule"), prefs?.getStringList("class_wednesday_schedule"), prefs?.getStringList("class_thursday_schedule"), prefs?.getStringList("class_friday_schedule")];
              if (schedule[0] != null && schedule[5] != null) {
                String text = "";
                _child = Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Container(
                      height: 78.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xff1C2031),
                      ),
                      child: Center(
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
                          child: Text("nigger",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:  17.sp,
                                  fontWeight: FontWeight.normal
                              ),
                              textAlign: TextAlign.center
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                _child = CategoryBoxesShimmer();
              }
              _child = CategoryBoxesShimmer();
            }
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: _child,
            );
          }
      );
    }
    else if (widget.isTillTheEnd ?? false) {
      return FutureBuilder<List<List<String>>>(
          future: Schedule.get_class_schedule(),
          builder: (context, snapshot) {
            Widget _child;
            if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
              _child = Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Container(
                    height: 78.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xff1C2031),
                    ),
                    child: Center(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
                        child: Text("NIGGER",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:  17.sp,
                                fontWeight: FontWeight.normal
                            ),
                            textAlign: TextAlign.center
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            else {
              _child = CategoryBoxesShimmer();
            }
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: _child,
            );
          }
      );
    }
    else {
      return FutureBuilder<List<List<String>>>(
          future: Schedule.get_class_schedule(),
          builder: (context, snapshot) {
            Widget _child;
            if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
              _child = Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Container(
                    height: 78.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xff1C2031),
                    ),
                    child: Center(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
                        child: Text(widget.text!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:  17.sp,
                            fontWeight: FontWeight.normal
                          ),
                          textAlign: TextAlign.center
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            else {
              _child = CategoryBoxesShimmer();
            }
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: _child,
            );
          }
      );
    }
  }
}







