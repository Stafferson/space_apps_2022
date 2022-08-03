import 'package:fizmat_app_flutter/widgets/DiscoverCardShimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fizmat_app_flutter/detail_page.dart';
import 'package:fizmat_app_flutter/widgets/category_boxes.dart';
import 'package:fizmat_app_flutter/icons.dart';
import 'package:fizmat_app_flutter/widgets/discover_card.dart';
import 'package:fizmat_app_flutter/widgets/discover_small_card.dart';
import 'package:fizmat_app_flutter/widgets/svg_asset.dart';
import 'package:shimmer/shimmer.dart';

import 'fizmat_utils/news.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

List<List<String>> news = [];

class _DiscoverPageState extends State<DiscoverPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121421),
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
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
            ),
            Container(
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
                  CategoryBoxes(
                    text: "Tair is cool",
                    onPressed: (value) => print(value),
                  ),
                  CategoryBoxes(
                    text: "Insomnia",
                    onPressed: (value) => print(value),
                  ),
                ],
              ),
            ),
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
            SizedBox(
              height: 16.h,
            ),
            SizedBox(
              height: 176.w,
              child: FutureBuilder<List<List<String>>>(
                  future: load_last_news(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return SizedBox(
                              width: 16.w,
                            );
                          } //else if (index == snapshot.data!.length + 1) {
                            //return SizedBox(
                            //  width: 16.w,
                            //);
                            //}
                          else {
                            return DiscoverCard(
                              title: "${snapshot.data![1][index - 1].substring(
                                  0, 30)}...",
                              subtitle: "${snapshot.data![2][index - 1]
                                  .substring(0, 42)}...",
                              onTap: onLastNewsTapped(index - 1),
                            );
                          }
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 20.w,
                          );
                        }
                      );
                    }
                    else {
                      return CircularProgressIndicator();
                    }
                  }
              )
            ),
            SizedBox(height: 28.h),
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
            SizedBox(height: 16.h),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 28.w),
              child: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 19.w, mainAxisExtent:  125.w, mainAxisSpacing: 19.w),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  DiscoverSmallCard(
                    onTap: (){},
                    title: "Lessons\nSchedule",
                    gradientStartColor: Color(0xff13DEA0),
                    gradientEndColor: Color(0xff06B782),
                    icon: const Icon(
                      Icons.format_list_bulleted_rounded,
                      color: Colors.white,
                    ),
                  ),
                  DiscoverSmallCard(
                    onTap: (){},
                    title: "School\nForum",
                    gradientStartColor: Color(0xffFC67A7),
                    gradientEndColor: Color(0xffF6815B),
                    icon: const Icon(
                      Icons.forum_rounded,
                      color: Colors.white,
                    )
                    // SvgAsset(
                    //   assetName: AssetName.tape,
                    //   height: 24.w,
                    //   width: 24.w,
                    // ),
                  ),
                  DiscoverSmallCard(
                    onTap: (){
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
                    onTap: (){},
                    title: "Settings",
                    icon:  const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    // SvgAsset(
                    //   assetName: AssetName.tape,
                    //   height: 24.w,
                    //   width: 24.w,
                    // ),
                  ),
                ],

              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<List<String>>> load_last_news() async {
    news = await News.get_last_3_news();
    return news;
  }

  void onSeeAllTapped() {
  }

  void onSleepMeditationTapped() {
    //Get.to(()=> DetailPage(), transition: Transition.rightToLeft);
  }

  void onDepressionHealingTapped() {
  }

  void onSearchIconTapped() {
  }

  onLastNewsTapped(int index) {
    Get.to(()=> DetailPage(title: news[1][index].toString(), url: news[2][index].toString()), transition: Transition.rightToLeft);
  }
}
