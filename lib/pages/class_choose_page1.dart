import 'package:animate_icons/animate_icons.dart';
import 'package:fizmat_app_flutter/fizmat_utils/schedule.dart';
import 'package:fizmat_app_flutter/pages/class_info_schedule_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../icons.dart';
import '../widgets/svg_asset.dart';

class ClassChoosePage1 extends StatelessWidget {
  ClassChoosePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_builder(),
      backgroundColor: Color(0xff121421),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 16.h,
                ),
                /*Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 10.h),
                  child: class_list_builder(),
                ),*/
                FutureBuilder<List<List<String>>>(
                  future: Schedule.get_list_all_classes_info(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                      return const ClassWheelLists();
                    } else {
                      return Container(
                        child: const Center(
                          child: SpinKitDoubleBounce(
                            color: Colors.white,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            //not_app_bar(),
          ],
        ),
      ),
    );
  }

  AppBar appbar_builder() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
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
        child: Text("All classes",
            style: TextStyle(
                color: Colors.white,
                fontSize: 34.w,
                fontWeight: FontWeight.bold)
        ),
      ),
      backgroundColor: Color(0xff121421),
    );
  }
}

class ClassWheelLists extends StatefulWidget {
  //final List<String>? classes_numbers = ["7", "8", "9", "10", "11"];
  //final List<String>? classes_liters = ["A", "B", "C", "D", "E"];
  const ClassWheelLists({
    Key? key,
  }) : super(key: key);

  @override
  State<ClassWheelLists> createState() => _ClassWheelListsState();
}

class _ClassWheelListsState extends State<ClassWheelLists> {

  final List<String> classes_numbers = ["7", "8", "9", "10", "11"];
  final List<String> classes_liters = ["A", "B", "C", "D", "E"];

  int _selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return class_list_builder();
  }

  Widget class_list_builder() {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              alignment: Alignment.centerRight,
              child: ListWheelScrollView(
                key: UniqueKey(),
                diameterRatio: 0.5,
                itemExtent: 75,
                onSelectedItemChanged: (int index) {
                  // update the UI on selected item changes
                  setState(() {
                    _selectedItemIndex = index;
                  });
                },
                children:
                  /*for (String element in widget.classes_numbers)
                    ListTile(
                      title: Text(
                        element,
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),*/

                  getListNumber(),
              ),
            ),
          ),
          Flexible(
            child: Container(
              alignment: Alignment.centerRight,
              child: ListWheelScrollView(
                diameterRatio: 0.5,
                itemExtent: 75,
                children: [
                  for (String element in classes_liters)
                    ListTile(
                      title: Text(
                        element,
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void on_class_tap(String _class) {
    Get.to(() => ClassInfoPage(classId: _class));
  }

  List<Widget> getListNumber() {
    return classes_numbers.map((e) =>
        Card(
          // make selected item background color is differ from the rest
          color: classes_numbers.indexOf(e) == _selectedItemIndex
              ? Colors.orange
              : Colors.indigo,
          child: Center(
            child: Text(
              e,
              style: const TextStyle(
                  fontSize: 20, color: Colors.white),
            ),
          ),
        )
    ).toList();
  }
}
