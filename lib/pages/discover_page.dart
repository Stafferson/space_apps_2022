import 'package:animate_icons/animate_icons.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fizmat_app_flutter/pages/class_choose_page.dart';
import 'package:fizmat_app_flutter/pages/news_page.dart';
import 'package:fizmat_app_flutter/widgets/discover_card_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:fizmat_app_flutter/pages/detail_page.dart';
import 'package:fizmat_app_flutter/widgets/category_boxes.dart';
import 'package:fizmat_app_flutter/icons.dart';
import 'package:fizmat_app_flutter/widgets/discover_card.dart';
import 'package:fizmat_app_flutter/widgets/discover_small_card.dart';
import 'package:fizmat_app_flutter/widgets/svg_asset.dart';

import 'package:fizmat_app_flutter/fizmat_utils/newsAPI.dart';

import '../widgets/category_boxes_shimmer.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

AnimateIconController _controller = AnimateIconController();

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appbar_builder(),
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                floating: true,
                snap: true,
                title: Padding(
                  padding: EdgeInsets.only(
                    left: 14.w,
                    top: 16.h,
                  ),
                  child: Text("Discover",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.w,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
              ),
            ];
          },
          body: RefreshIndicator(
            onRefresh: () {
              return Future.delayed(Duration(seconds: 1), () {
                setState(() {});
              });
            },
            child: ListView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              children: [
                /*Padding(
                padding: EdgeInsets.only(
                  left: 28.w,
                  right: 18.w,
                  top: 16.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Discover",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 34.w,
                            fontWeight: FontWeight.bold)),
                    InkWell(
                      borderRadius: BorderRadius.circular(360),
                      onTap: onSearchIconTapped,
                      child: Container(
                        height: 35.w,
                        width: 35.w,
                        child: Center(
                          child: SvgAsset(
                            assetName: AssetName.search,
                            height: 24.w,
                            width: 24.w,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),*/
                category_boxes_builder(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Last News",
                        style: TextStyle(
                            color: Color(0xff515979),
                            fontWeight: FontWeight.w500,
                            fontSize: 14.w),
                      ),
                      GestureDetector(
                          onTap: onSeeAllTapped,
                          child: Text("See All",
                              style: TextStyle(
                                  color: Color(0xff4A80F0),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.w)))
                    ],
                  ),
                ),
                SizedBox(height: 14.h,),
                last_news_builder(),
                SizedBox(height: 14.h),
                Padding(
                  padding: EdgeInsets.only(left: 28.w),
                  child: Text(
                    "Main menu",
                    style: TextStyle(
                        color: Color(0xff515979),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.w),
                  ),
                ),
                SizedBox(height: 14.h),
                main_menu_builder(),
                //SizedBox(height: 14.h),
                //main_menu_builder(),
                //SizedBox(height: 48.h),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xff121421),
    );
  }

  Future<void> onSearchIconTapped() async {
    //print("here");
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.set({
      "name": "Johsan",
      "age": 189,
      "addressd": {
        "line1": "100 Mountain View"
      }
    });
  }

  onLastNewsTapped(int index1, List<List<String>> _snapshot) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      //Get.to(()=> DetailPage(title: news[1][index].toString(), url: news[0][index].toString()), transition: Transition.rightToLeft);
      Get.to(()=> DetailPage(title: _snapshot[1][index1].toString(), url: _snapshot[0][index1].toString(), index: index1,), transition: Transition.rightToLeft);
    });
  }

  Widget last_news_builder() {
    return SizedBox(
      height: 176.h,
      child: FutureBuilder<List<List<String>>>(
          future: NewsApi.get_last_3_news(),
          builder: (context, snapshot) {
            Widget _child;
            if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
              _child = ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length + 2,
                  itemBuilder: (context, index) {
                    if (index == 0 || index == snapshot.data!.length + 1) {
                      return SizedBox(
                        width: 16.w,
                      );
                    } else {
                      String subtitle = "";
                      String title = "";
                      if (snapshot.data![1][index - 1].length > 29) {
                        title = snapshot.data![1][index - 1].substring(
                            0, 30);
                      } else {
                        title = snapshot.data![1][index - 1];
                      }

                      if (snapshot.data![2][index - 1].length > 41) {
                        subtitle = snapshot.data![2][index - 1]
                            .substring(0, 42);
                      } else {
                        subtitle = snapshot.data![2][index - 1];
                      }

                      return DiscoverCard(
                        tag: (index - 1).toString(),
                        title: "$title...",
                        subtitle: "$subtitle...",
                        onTap: () => onLastNewsTapped(index - 1, snapshot.data!),
                      );
                    }

                    //return DiscoverCard(
                    //  title: "${snapshot.data![1][index].substring(
                    //      0, 30)}...",
                    //  subtitle: "${snapshot.data![2][index]
                    //      .substring(0, 42)}...",
                    //  onTap: onLastNewsTapped(index),
                    //  tag: index.toString(),
                    //);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 20.w,
                    );
                  }
              );
            }
            else {
              _child = ListView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: <Widget>[

                  SizedBox(
                    width: 36.w,
                  ),

                  DiscoverCardShimmer(),

                  SizedBox(
                    width: 20.w,
                  ),

                  DiscoverCardShimmer(),

                  SizedBox(
                    width: 20.w,
                  ),

                  DiscoverCardShimmer(),

                  SizedBox(
                    width: 36.w,
                  ),
                ],
              );
            }

            return AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: _child,
            );
          }
      ),
    );
  }

  Widget category_boxes_builder() {
    /*return Container(
      height: 120.h,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: 28.w,
          ),
          CategoryBoxes(
            text: "Current lesson:\nNone",
            onPressed: (value) => print(value),
          ),
          CategoryBoxes(
            text: "Till the end:\nNonemin",
            onPressed: (value) => print(value),
          ),
        ],
      ),
    );*/
    return SizedBox(
      height: 120.h,
      child: FutureBuilder<List<List<String>>>(
          future: NewsApi.get_last_3_news(),
          builder: (context, snapshot) {
            Widget _child;
            if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
              _child = ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 28.w,
                  ),
                  CategoryBoxes(
                    text: "Current lesson:\nNone",
                    onPressed: (value) => print(value),
                    isCurrent: true,
                  ),
                  CategoryBoxes(
                    text: "Till the end:\nNonemin",
                    onPressed: (value) => print(value),
                  ),
                ],
              );
            }
            else {
              _child = ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 28.w,
                  ),
                  CategoryBoxesShimmer(),
                  CategoryBoxesShimmer(),
                  CategoryBoxesShimmer(),
                ],
              );
            }

            return AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: _child,
            );
          }
      ),
    );
  }

  Widget main_menu_builder1() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 28.w),
      child: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 19.w, mainAxisExtent:  125.w, mainAxisSpacing: 19.w),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          DiscoverSmallCard(
            onTap: (){
              on_lesson_schedule_tapped();
            },
            title: "Lessons\nSchedule",
            icon: const Icon(
              Icons.format_list_bulleted_rounded,
              color: Colors.white,
            ),
          ),
          DiscoverSmallCard(
              onTap: (){
                on_useful_links_tapped();
              },
              title: "Useful\nLinks",
              icon: const Icon(
                Icons.forum_rounded,
                color: Colors.white,
              )
          ),
          DiscoverSmallCard(
            onTap: (){
              on_school_clubs_tapped();
            },
            title: "School\nClubs",
            icon: const Icon(
              Icons.groups_rounded,
              color: Colors.white,
            ),
          ),
          DiscoverSmallCard(
            onTap: (){
              on_school_staff_news_tapped();
            },
            title: "School\nStaff's news",
            icon:  const Icon(
              Icons.notifications_active_rounded,
              color: Colors.white,
            ),
          ),
        ],

      ),
    );
  }

  Widget main_menu_builder() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 28.w),
      child: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 19.w, mainAxisExtent:  125.w, mainAxisSpacing: 19.w),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          DiscoverSmallCard(
            onTap: (){
              on_lesson_schedule_tapped();
            },
            title: "Lessons\nSchedule",
            gradientStartColor: Color(0xff13DEA0),
            gradientEndColor: Color(0xff06B782),
            icon: const Icon(
              Icons.format_list_bulleted_rounded,
              color: Colors.white,
            ),
          ),
          DiscoverSmallCard(
              onTap: (){
                on_useful_links_tapped();
              },
              title: "Useful\nLinks",
              gradientStartColor: Color(0xffFC67A7),
              gradientEndColor: Color(0xffF6815B),
              icon: const Icon(
                Icons.forum_rounded,
                color: Colors.white,
              )
          ),
          DiscoverSmallCard(
            onTap: (){
              on_school_clubs_tapped();
            },
            title: "School\nClubs",
            gradientStartColor: Color(0xffFFD541),
            gradientEndColor: Color(0xffF0B31A),
            icon: const Icon(
              Icons.groups_rounded,
              color: Colors.white,
            ),
          ),
          DiscoverSmallCard(
            onTap: (){
              on_school_staff_news_tapped();
            },
            title: "School\nStaff's news",
            icon:  const Icon(
              Icons.notifications_active_rounded,
              color: Colors.white,
            ),
          ),
          /*DiscoverSmallCard(
            onTap: (){
              on_setting_tapped();
            },
            title: "Useful\nLinks",
            gradientStartColor: Color(0xffFC67A7),
            gradientEndColor: Color(0xffF6815B),
            icon:  const Icon(
              Icons.link_rounded,
              color: Colors.white,
            ),
          ),
          DiscoverSmallCard(
            onTap: (){
              on_setting_tapped();
            },
            title: "Settings",
            gradientStartColor: Color(0xff13DEA0),
            gradientEndColor: Color(0xff06B782),
            icon:  const Icon(
              Icons.settings_rounded,
              color: Colors.white,
            ),
          ),*/
        ],

      ),
    );
  }

  AppBar appbar_builder() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 60.h,
      title: Padding(
        padding: EdgeInsets.only(
          left: 14.w,
          top: 16.h,
        ),
        child: Text("Discover",
            style: TextStyle(
                color: Colors.white,
                fontSize: 34.w,
                fontWeight: FontWeight.bold
            )
        ),
      ),
      actions: <Widget>[
        /*Padding(
          padding: EdgeInsets.only(
            top: 16.h,
          ),
          child: IconButton(
            icon: Icon(
              Icons.search_rounded,
              size: 30.w,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
              //ScaffoldMessenger.of(context).showSnackBar(
              //    const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ),*/
        /*Padding(
          padding: EdgeInsets.only(
            top: 16.h,
          ),
          child: IconButton(
            icon: Icon(
                Icons.refresh_rounded,
                size: 30.w,
            ),
            tooltip: 'Refresh current page',
            onPressed: () {
              setState(() {});
              /*Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Next page'),
                    ),
                    body: info_page_builder(),
                  );
                },
              ));*/
            },
          ),
        ),*/

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

  Widget info_page_builder() {
    return const Center(
      child: Text(
        'This is the next page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }


  void onSeeAllTapped() {
    Get.to(()=> NewsPage());
    /*ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("This function is still in progress"),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      duration: Duration(milliseconds: 500),
    ));*/
  }

  void on_lesson_schedule_tapped() {
    Get.to(()=> ClassChoosePage());
  }

  void on_school_clubs_tapped() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("This function is still in progress"),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      duration: Duration(milliseconds: 500),
    ));
  }

  void on_useful_links_tapped() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("This function is still in progress"),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      duration: Duration(milliseconds: 500),
    ));
  }

  void on_school_staff_news_tapped() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("This function is still in progress"),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      duration: Duration(milliseconds: 500),
    ));
  }
}
