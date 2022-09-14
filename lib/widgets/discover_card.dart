import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fizmat_app_flutter/icons.dart';
import 'package:fizmat_app_flutter/widgets/svg_asset.dart';

class DiscoverCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  final double? height;
  final double? width;
  final Widget? vectorBottom;
  final Widget? vectorTop;
  final Function? onTap;
  final String? tag;
  final bool? is_loaded;
  const DiscoverCard(
      {Key? key,
      this.title,
      this.subtitle,
      this.gradientStartColor,
      this.gradientEndColor,
      this.height,
      this.width,
      this.vectorBottom,
      this.vectorTop,
      this.onTap,
      this.tag,
      this.is_loaded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap!(),
        borderRadius: BorderRadius.circular(26),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: LinearGradient(
              colors: [
                gradientStartColor ?? Color(0xff441DFC),
                gradientEndColor ?? Color(0xff4E81EB),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Container(
            height: 176.h,
            width: 305.w,
            child: Stack(
              children: [
                vectorBottom ??
                    ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: SvgAsset(
                          height: 176.h,
                          width: 306.w,
                          assetName: AssetName.vectorBottom),
                    ),
                vectorTop ??
                    ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: SvgAsset(
                          height: 176.h,
                          width: 305.w,
                          assetName: AssetName.vectorTop),
                    ),
                Padding(
                  padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 22.h, bottom: 16.h,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: Hero(
                              tag: tag!,
                              child: DefaultTextStyle(
                                child: Text(title!),
                                style: TextStyle(
                                    fontSize: 20.w,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          subtitle != null
                              ? Text(
                                  subtitle!,
                                  style: TextStyle(
                                      fontSize: 16.w,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: const [
                          //SvgAsset(
                          //  assetName: AssetName.headphone,
                          //  height: 24.w,
                          //  width: 24.w,
                          //),
                          //SizedBox(width: 24.w),
                          //SvgAsset(
                          //  assetName: AssetName.tape,
                          //  height: 24.w,
                          //  width: 24.w,
                          //),
                          Icon(Icons.newspaper_rounded, color: Colors.white,)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
