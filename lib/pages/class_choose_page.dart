import 'package:animate_icons/animate_icons.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:fizmat_app_flutter/fizmat_utils/schedule.dart';
import 'package:fizmat_app_flutter/pages/class_info_schedule_page.dart';
import 'package:fizmat_app_flutter/pages/discover_page.dart';
import 'package:fizmat_app_flutter/pages/home_page.dart';
import 'package:fizmat_app_flutter/widgets/ScheduleClassCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fizmat_app_flutter/widgets/discover_small_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:shaky_animated_listview/animators/grid_animator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassChoosePage extends StatefulWidget {
  const ClassChoosePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ClassChoosePage> createState() => _ClassChoosePageState();
}

bool _showAppbar = true;
bool isScrollingDown = false;
AnimateIconController _controller = AnimateIconController();

SharedPreferences? prefs;
final List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

class _ClassChoosePageState extends State<ClassChoosePage> {
  final _scrollViewController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_builder(),
      backgroundColor: Color(0xff121421),
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: class_list_builder(),
            )
          ],
        ),
      ),
    );
  }

  Widget class_list_builder() {
    return Container(
      child: Center(
          child: FutureBuilder<List<String>>(
            future: Schedule.get_list_all_classes(),
            builder: (context, snapshot) {
              Widget _child;
              if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                /*_child = GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 19.w, mainAxisExtent:  125.w, mainAxisSpacing: 19.w),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ScheduleClassCard(
                      onTap: () {
                        on_class_tap(index);
                      },
                      title: snapshot.data![index],
                      gradientStartColor: Color(0xff13DEA0),
                      gradientEndColor: Color(0xff06B782),
                      icon: const Icon(
                        Icons.format_list_bulleted_rounded,
                        color: Colors.white,
                      ),
                    );
                  }
                );*/
                return AnimationLimiter(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 19.w, mainAxisExtent:  125.w, mainAxisSpacing: 19.w),
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredGrid(
                          columnCount: 3,
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: FadeInAnimation(
                            child: ScheduleClassCard(
                              onTap: () {
                                on_class_tap(snapshot.data![index]);
                              },
                              title: snapshot.data![index],
                              gradientStartColor: Color(0xff13DEA0),
                              gradientEndColor: Color(0xff06B782),
                              icon: const Icon(
                                Icons.format_list_bulleted_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                  ),
                );
              } else {
                _child = const SpinKitDoubleBounce(
                  color: Colors.white,
                  size: 50.0,
                );
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

  AppBar appbar_builder() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 60,
      leading: Padding(
        padding: EdgeInsets.only(
          top: 10.h,
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.to(()=> HomePage()),
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
      elevation: 0,

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

  void on_class_tap(String _class) {
    Get.to(() => ClassInfoPage(classId: _class));
  }
}
