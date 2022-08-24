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


class ClassInfoPage extends StatefulWidget {
  final String? classId;
  const ClassInfoPage(
      {Key? key,
        required this.classId
      }) : super(key: key);

  @override
  _ClassInfoPageState createState() => _ClassInfoPageState();
}

class _ClassInfoPageState extends State<ClassInfoPage> {

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
                /*InkWell(
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
                ),*/
                not_app_bar(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget not_app_bar() {
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
                ],
              ),
            ),
          ),
        )
    );
  }

  void onBackIconTapped() {
    Get.back();
  }
}
