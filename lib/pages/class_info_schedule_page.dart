import 'package:animate_icons/animate_icons.dart';
import 'package:fizmat_app_flutter/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:fizmat_app_flutter/icons.dart';
import 'package:fizmat_app_flutter/widgets/svg_asset.dart';
import 'package:fizmat_app_flutter/fizmat_utils/newsAPI.dart';
import 'package:url_launcher/url_launcher.dart';

import '../fizmat_utils/schedule.dart';
import '../main.dart';
import '../widgets/schedule_day_element_card.dart';


class ClassInfoPage extends StatefulWidget {
  final String? classId;
  const ClassInfoPage(
      {Key? key,
        required this.classId
      }) : super(key: key);

  @override
  _ClassInfoPageState createState() => _ClassInfoPageState();
}

AnimateIconController _controller = AnimateIconController();
final List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

class _ClassInfoPageState extends State<ClassInfoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_builder(),
      backgroundColor: const Color(0xff121421),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                schedule_builder(),
                choose_class_builder(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget schedule_builder() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
      height: 610.h,
      child: Center(
          child: FutureBuilder<List<List<String>>>(
            future: Schedule.get_class_schedule_by_id(widget.classId.toString()),
            builder: (context, snapshot) {
              Widget _child;
              if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data![0][0].toString() == "1") {
                  _child = const Text("No such class has been found");
                } else {
                  _child = PageView.builder (
                    itemBuilder: (BuildContext context, int index) {
                      print("SCHEDULE UPDATED");
                      return Padding(
                        padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                        child: ScheduleDayCard(
                            tagD : index,
                            title: days[index],
                            schedule: snapshot.data![index],
                            subtitle: "${days[index]} subtitle",
                            schedule_timeline: snapshot.data![index + 5],
                        ),
                      );
                    },
                    itemCount: days.length,
                  );
                }
              } else {
                List<List<String>?> schedule = [prefs?.getStringList("${widget.classId}class_monday"), prefs?.getStringList("${widget.classId}class_tuesday"), prefs?.getStringList("${widget.classId}class_wednesday"), prefs?.getStringList("${widget.classId}class_thursday"), prefs?.getStringList("${widget.classId}class_friday"), prefs?.getStringList("class_monday_schedule"), prefs?.getStringList("class_tuesday_schedule"), prefs?.getStringList("class_wednesday_schedule"), prefs?.getStringList("class_thursday_schedule"), prefs?.getStringList("class_friday_schedule")];
                if (schedule[0] != null && schedule[5] != null) {
                  _child = PageView.builder (
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                        child: ScheduleDayCard(
                            tagD : index,
                            title: days[index],
                            schedule: schedule[index],
                            subtitle: "${days[index]} subtitle",
                            schedule_timeline: schedule[index + 5],
                        ),
                      );
                    },
                    itemCount: days.length,
                  );
                } else {
                  _child = const SpinKitDoubleBounce(
                    color: Colors.white,
                    size: 50.0,
                  );
                }
              }
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _child,
              );
            },
          )
      ),
    );
  }

  Widget choose_class_builder() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 87.h,
        decoration: const BoxDecoration(
            color: Colors.black,
            gradient: LinearGradient(
                stops: [0,1],
                colors: [
                  Color(0xff121421),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter
            )
        ),
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: onClassChooseButtonPressed,
              child: Ink(
                decoration: BoxDecoration(
                  color: Color(0xff4A80F0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  height: 56.h,
                  width: 319.w,
                  child: Center(
                      child: Text(
                        "Save this schedule",
                        style: TextStyle(
                            fontSize: 16.w,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onBackIconTapped() {
    Get.back();
  }

  AppBar appbar_builder() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 60.h,
      leading: Padding(
        padding: EdgeInsets.only(
          top: 10.h,
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.only(
          left: 14.w,
          top: 10.h,
        ),
        child: Hero(
          tag: "class${widget.classId.toString()}",
          child: DefaultTextStyle(
            style: TextStyle(
                color: Colors.white,
                fontSize: 34.w,
                fontWeight: FontWeight.bold),
            child: Text(widget.classId.toString(),
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xff121421),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: 10.h,
          ),
          child: AnimateIcons(
            startIcon: Icons.refresh_rounded,
            endIcon: Icons.refresh_rounded,
            size: 28.0,
            // add this tooltip for the start icon
            startTooltip: 'Icons.add_circle',
            // add this tooltip for the end icon
            endTooltip: 'Icons.add_circle_outline',
            controller: _controller,
            onStartIconPress: () {
              setState(() {});
              return true;
            },
            onEndIconPress: () {
              setState(() {});
              return true;
            },
            startIconColor: Colors.white,
            endIconColor: Colors.white,
            duration: Duration(milliseconds: 500),
            clockwise: true,
          ),
        ),
      ],
    );
  }

  void onClassChooseButtonPressed() {
    prefs!.setString("class", widget.classId.toString());
    Get.to(()=> HomePage());
  }
}
