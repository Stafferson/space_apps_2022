import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fizmat_app_flutter/icons.dart';
import 'package:fizmat_app_flutter/widgets/svg_asset.dart';

class ScheduleClassCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  final double? height;
  final double? width;
  final Widget? vectorBottom;
  final Widget? vectorTop;
  final double? borderRadius;
  final Widget? icon;
  final Function()? onTap;
  final String? tag;
  const ScheduleClassCard(
      {Key? key,
        this.tag,
        this.title,
        this.subtitle,
        this.gradientStartColor,
        this.gradientEndColor,
        this.height,
        this.width,
        this.vectorBottom,
        this.vectorTop,
        this.borderRadius,
        this.icon,
        this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => onTap!(),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white,
            width: 0.5,
          ),
          color: Color(0xff4E81EB) ,
        ),
        child: Stack(
          children: [
            Container(
              height: 125.w,
              width: 150.w,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 125.w,
                width: 150.w,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 125.w,
                      width: 150.w,
                      child: SvgAsset(assetName: AssetName.vectorSmallBottom, color: Colors.white,),
                    ),
                    SizedBox(
                      child: SvgAsset(
                          height: 125.w,
                          width: 150.w,
                          fit: BoxFit.fitHeight,
                          assetName: AssetName.vectorSmallTop, color: Color(0xFF1C2031)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 125.w,
              width: 150.w,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, top: 20.w, bottom: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Hero(
                        tag: tag!,
                        child: DefaultTextStyle(
                          style: TextStyle(
                              fontSize: 18.w,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          child: Text(
                            title!,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        icon ??
                            SvgAsset(
                              assetName: AssetName.headphone,
                              height: 24.w,
                              width: 24.w,
                            ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
