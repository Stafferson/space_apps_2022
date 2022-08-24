import 'package:animate_icons/animate_icons.dart';
import 'package:fizmat_app_flutter/fizmat_utils/schedule.dart';
import 'package:fizmat_app_flutter/widgets/schedule_day_element_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:fizmat_app_flutter/pages/detail_page.dart';
import 'package:fizmat_app_flutter/widgets/category_boxes.dart';
import 'package:fizmat_app_flutter/icons.dart';
import 'package:fizmat_app_flutter/widgets/discover_card.dart';
import 'package:fizmat_app_flutter/widgets/discover_small_card.dart';
import 'package:fizmat_app_flutter/widgets/svg_asset.dart';
import 'package:gsheets/gsheets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({
    Key? key,
  }) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

final List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
AnimateIconController _controller = AnimateIconController();

class _SchedulePageState extends State<SchedulePage> {

  @override
  void InitState() async {
    print("INITITIIT");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_builder(),
      backgroundColor: Color(0xff121421),
      body: SafeArea(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            schedule_builder(),
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
            future: Schedule.get_class_schedule(),
            builder: (context, snapshot) {
              Widget _child;
              if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                /*List<String> arr0 = [];
                      List<String> arr1 = [];
                      List<String> arr = [];
                      print("DATA");
                      for (int i = 0; i < 5; i++) {
                        for (int j = 0; j < snapshot.data![i].length; j++) {
                          arr0.add(snapshot.data![i][j].split("\n")[0]);
                          arr1.add(snapshot.data![i][j].split("\n")[1]);
                        }
                      }
                      print(arr0.toString());
                      print(arr1.toString());*/ // needed for testing, and splitting the schedule: lessons/cabinet
                if (snapshot.data![0][0].toString() == "0") {
                  _child = const Text("You have not choosed your class yet");
                } else if (snapshot.data![0][0].toString() == "1") {
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
                            subtitle: "${days[index]} subtitle"
                        ),
                      );
                    },
                    itemCount: days.length,
                  );
                }
              } else {
                List<List<String>?> schedule = [prefs?.getStringList("class_monday"), prefs?.getStringList("class_tuesday"), prefs?.getStringList("class_wednesday"), prefs?.getStringList("class_thursday"), prefs?.getStringList("class_friday")];
                if (schedule[0] != null) {
                  _child = PageView.builder (
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                        child: ScheduleDayCard(
                            tagD : index,
                            title: days[index],
                            schedule: schedule[index],
                            subtitle: "${days[index]} subtitle"
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

  /*AppBar appbar_builder() {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(
          left: 14.w,
          top: 16.h,
        ),
        child: Text("Schedule",
            style: TextStyle(
                color: Colors.white,
                fontSize: 34.w,
                fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Color(0xff121421),
      elevation: 0,
    );
  }*/

  AppBar appbar_builder() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.only(
          left: 14.w,
          top: 16.h,
        ),
        child: Hero(
          tag: "Schedule",
          child: Text("Schedule",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 34.w,
                  fontWeight: FontWeight.bold)
          ),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: 16.h,
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
      backgroundColor: Color(0xff121421),
      elevation: 0,
    );
  }
}
