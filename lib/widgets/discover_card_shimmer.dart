import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fizmat_app_flutter/icons.dart';
import 'package:fizmat_app_flutter/widgets/svg_asset.dart';
import 'package:shimmer/shimmer.dart';

class DiscoverCardShimmer extends StatelessWidget {
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  final double? height;
  final double? width;
  final Widget? vectorBottom;
  final Widget? vectorTop;
  const DiscoverCardShimmer(
      {Key? key,
        this.gradientStartColor,
        this.gradientEndColor,
        this.height,
        this.width,
        this.vectorBottom,
        this.vectorTop,d})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
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
            height: 176.w,
            width: 305.w,
            child: Stack(
              children: [
                vectorBottom ??
                    ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: SvgAsset(
                          height: 176.w,
                          width: 306.w,
                          assetName: AssetName.vectorBottom),
                    ),
                vectorTop ??
                    ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: SvgAsset(
                          height: 176.w,
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
                            child: Shimmer.fromColors(
                              baseColor: Color(0x4dd1d1d1),
                              highlightColor: Colors.white,
                              child: SizedBox(
                                height: 20.w,
                                width: 230.w,
                                child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))
                                    ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 6.h,
                          ),

                          Material(
                            color: Colors.transparent,
                            child: Shimmer.fromColors(
                              baseColor: Color(0x4dd1d1d1),
                              highlightColor: Colors.white,
                              child: SizedBox(
                                height: 20.w,
                                width: 160.w,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7))
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 16.h,
                          ),

                          Material(
                            color: Colors.transparent,
                            child: Shimmer.fromColors(
                              baseColor: Color(0x4dd1d1d1),
                              highlightColor: Colors.white,
                              child: SizedBox(
                                height: 16.w,
                                width: 230.w,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7))
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 6.h,
                          ),

                          Material(
                            color: Colors.transparent,
                            child: Shimmer.fromColors(
                              baseColor: Color(0x4dd1d1d1),
                              highlightColor: Colors.white,
                              child: SizedBox(
                                height: 16.w,
                                width: 230.w,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7))
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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