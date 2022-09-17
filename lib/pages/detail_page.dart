import 'package:animate_icons/animate_icons.dart';
import 'package:fizmat_app_flutter/pages/discover_page.dart';
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


class DetailPage extends StatefulWidget {
  final String? title;
  final String? url;
  final int? index;
  final List<String>? description;
  const DetailPage(
      {Key? key,
        required this.title,
        required this.url,
        required this.index,
        this.description
      }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

AnimateIconController _controller = AnimateIconController();

class _DetailPageState extends State<DetailPage> {
  bool? isHeartIconTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      appBar: appbar_builder(),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 18.w, right: 18.w),
                  child: Material(
                    color: Colors.transparent,
                    child: Hero(
                      tag: widget.index.toString(),
                      child: Material(
                        color: Colors.transparent,
                        child: DefaultTextStyle(child: Text(widget.title.toString()),
                          style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.w,
                          fontWeight: FontWeight.bold
                          )
                        ),
                      ),
                    )
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 18.w, right: 18.w),
                  child: FutureBuilder<List<List<String>>>(
                    future: NewsApi.get_infonews_url(widget.url.toString()),
                    builder: (context, snapshot) {
                      Widget _child;
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
                                fontSize: 16.w
                            ),
                          );
                        } else {
                          _child = Container();
                        }
                      }
                      else {
                        _child = Container();
                      }

                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        child: _child,
                      );
                    },
                  ),
                ),
                SizedBox(height: 25.h),
                SizedBox(
                  height: 280.w,
                  child: FutureBuilder<List<List<String>>>(
                      future: NewsApi.get_infonews_url(widget.url.toString()),
                      builder: (context, snapshot) {
                        Widget _child;
                        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                          _child = ListView.separated(
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
                          _child = const SpinKitDoubleBounce(
                            color: Colors.white,
                            size: 50.0,
                          );
                        }

                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          child: _child,
                        );
                      }
                  )
                ),
                SizedBox(height: 32.h),
                /*Padding(
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
                ),*/
                //SizedBox(height: 32.h),
                FutureBuilder<List<List<String>>> (
                    future: NewsApi.get_infonews_url(widget.url.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                        return Padding(
                          padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 80.h),
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
            read_online(),
          ],
        ),
      ),
    );
  }

  /*Widget not_app_bar() {
    return  Align(alignment: Alignment.topCenter,
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
    );
  }*/

  Widget read_online() {
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
    );
  }

  Future<void> onReadOnlineButtonPressed() async{
    await launchUrl(Uri.parse(widget.url.toString()), mode: LaunchMode.externalApplication);
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

    /*if (await canLaunchUrl(Uri.parse(link.url))!) {
      await launchUrl(Uri.parse(link.url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Could not launch url"),
      ));
    }*/

    await launchUrl(Uri.parse(link.url), mode: LaunchMode.externalApplication);
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
        child: Text("",
            style: TextStyle(
                color: Colors.white,
                fontSize: 34.w,
                fontWeight: FontWeight.bold)
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
}
