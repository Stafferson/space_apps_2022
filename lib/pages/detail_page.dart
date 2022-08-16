import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:fizmat_app_flutter/icons.dart';
import 'package:fizmat_app_flutter/widgets/svg_asset.dart';
import 'package:fizmat_app_flutter/fizmat_utils/news.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailPage extends StatefulWidget {
  final String? title;
  final String? url;
  final int? index;
  const DetailPage(
      {Key? key,
        required this.title,
        required this.url,
        required this.index
      }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

List<List<String>> news = [];

class _DetailPageState extends State<DetailPage> {
  bool? isHeartIconTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 66.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.w),
                  child: Material(
                    color: Colors.transparent,
                    child: Hero(
                      tag: widget.index.toString(),
                      child: Material(
                        color: Colors.transparent,
                        child: Text(widget.title.toString(),
                          style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.w,
                          fontWeight: FontWeight.bold)
                        ),
                      ),
                    )
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.w),
                  child: FutureBuilder<List<List<String>>>(
                    future: load_news_info(widget.url),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data![2].length != 0) {
                          String rubrics = "";
                          for (var element in snapshot.data![2]) {
                            rubrics += "$element ";
                          }
                          return Text(
                            "Рубрики: $rubrics",
                            style: TextStyle(
                                color: Color(0xffffffff).withOpacity(0.7),
                                fontWeight: FontWeight.w400,
                                fontSize: 16.w),
                          );
                        } else {
                          return Container();
                        }
                      }
                      else {
                        return Container();
                      }
                    },
                  ),
                ),
                SizedBox(height: 25.h),
                SizedBox(
                  height: 280.w,
                  child: FutureBuilder<List<List<String>>>(
                      future: load_news_info(widget.url.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                          return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data![0].length + 2,
                              itemBuilder: (context, index) {
                                if (index == 0 || index == snapshot.data![0].length + 1) {
                                  return SizedBox(
                                    width: 28.w,
                                  );
                                } else {
                                  return Container(
                                    height: 280.w,
                                    width: 280.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.network(snapshot.data![0][index - 1]).image,
                                      ),
                                    ),
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
                          return const SpinKitDoubleBounce(
                            color: Colors.white,
                            size: 50.0,
                          );
                        }
                      }
                  )
                ),
                SizedBox(height: 32.h),
                Padding(
                  padding: EdgeInsets.only(left: 28.w),
                  child: Row(
                    children: [
                      Container(
                        height: 56.w,
                        width: 56.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: Center(
                            child: SvgAsset(
                                assetName: AssetName.headphone,
                                height: 28.w,
                                width: 28.w)),
                      ),
                      SizedBox(width: 16.w),
                      Container(
                        height: 56.w,
                        width: 56.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: Center(
                            child: SvgAsset(
                                assetName: AssetName.tape,
                                height: 28.w,
                                width: 28.w)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                FutureBuilder<List<List<String>>> (
                    future: load_news_info(widget.url!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                        return Padding(
                          padding: EdgeInsets.only(left: 28.w, right: 28.w, bottom: 80.h),
                          child: Linkify(
                            text: snapshot.data![1].reduce((value, element) => value + "\n" + "\n" + element),
                            style: TextStyle(
                                color: Color(0xffffffff).withOpacity(0.7),
                                fontWeight: FontWeight.w400,
                                fontSize: 16.w),
                            options: LinkifyOptions(humanize: true),
                            onOpen: onOpen
                          ),
                          //Text(
                          //  snapshot.data![1].reduce((value, element) => value + "\n" + "\n" + element),
                          //  style: TextStyle(
                          //      color: Color(0xffffffff).withOpacity(0.7),
                          //      fontWeight: FontWeight.w400,
                          //      fontSize: 16.w),
                          //),
                        );
                      }
                      else {
                        return const SpinKitDoubleBounce(
                          color: Colors.white,
                          size: 50.0,
                        );
                      }
                    }
                )
              ],
            ),

            Align(alignment: Alignment.topCenter,
            child: Container(
              color:  Color(0xff121421),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 22.w,
                  right: 22.w,
                  top: 20.h,
                  bottom: 10.h
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(360),
                        onTap: onBackIconTapped,
                        child: Container(
                          height: 35.w,
                          width: 35.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                          ),
                          child: Center(
                            child: SvgAsset(
                              assetName: AssetName.back,
                              height: 20.w,
                              width: 20.w,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(360),
                        onTap: onHeartIconTapped,
                        child: Container(
                          height: 35.w,
                          width: 35.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                          ),
                          child: Center(
                            child: SvgAsset(
                              assetName: AssetName.heart,
                              height: 24.w,
                              width: 24.w,
                              color: isHeartIconTapped! ? Colors.red: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            ),

            Align(
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
                      onTap: onReadOnlineButtonPressed,
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
                                "Read online",
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
            ),


          ],
        ),
      ),
    );
  }

  Future<List<List<String>>> load_news_info(url) async {
    news = await News.get_infonews_url(url);
    return news;
  }

  Future<void> onReadOnlineButtonPressed() async{
    await launchUrl(Uri.parse(widget.url.toString()));
  }

  void onBackIconTapped() {
   Get.back();
  }

  void onHeartIconTapped() {
    setState(() {
      isHeartIconTapped = !isHeartIconTapped!;
    });
  }

  Future<void> onOpen(LinkableElement link) async {
    await launchUrl(Uri.parse(await link.url.replaceAll('http', 'https')));
  }
}
