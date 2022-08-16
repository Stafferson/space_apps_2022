import 'package:fizmat_app_flutter/fizmat_utils/schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fizmat_app_flutter/widgets/discover_small_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassChoosePage extends StatefulWidget {
  const ClassChoosePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ClassChoosePage> createState() => _ClassChoosePageState();
}

ScrollController? _scrollViewController;
bool _showAppbar = true;
bool isScrollingDown = false;

SharedPreferences? prefs;
final List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

class _ClassChoosePageState extends State<ClassChoosePage> {

  @override
  void InitState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _scrollViewController!.addListener(() {
      if (_scrollViewController!.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController!.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollViewController!.dispose();
    _scrollViewController!.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appbar_builder(),
      backgroundColor: Color(0xff121421),
      body: SafeArea(
        /*child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              class_list_builder(),
            ],
          ),
        ),*/
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              height: _showAppbar ? 56.0 : 0.0,
              duration: Duration(milliseconds: 200),
              child: AppBar(
                title: Text("All classes",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 34.w,
                        fontWeight: FontWeight.bold)),
                actions: const <Widget>[
                  //add buttons here
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                controller: _scrollViewController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    class_list_builder(),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget class_list_builder() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
      height: 610.h,
      child: Center(
          child: FutureBuilder<List<String>>(
            future: Schedule.get_list_all_classes(),
            builder: (context, snapshot) {
              Widget _child;
              if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 19.w, mainAxisExtent:  125.w, mainAxisSpacing: 19.w),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DiscoverSmallCard(
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
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.only(
          left: 14.w,
          top: 16.h,
        ),
        child: Text("All classes",
            style: TextStyle(
                color: Colors.white,
                fontSize: 34.w,
                fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Color(0xff121421),
      elevation: 0,
    );
  }

  void on_class_tap(int index) {}
}
