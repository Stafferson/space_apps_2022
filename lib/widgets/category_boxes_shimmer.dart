import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fizmat_app_flutter/icons.dart';
import 'package:fizmat_app_flutter/widgets/svg_asset.dart';
import 'package:shimmer/shimmer.dart';

class CategoryBoxesShimmer extends StatefulWidget {
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  final double? height;
  final double? width;
  final Widget? vectorBottom;
  final Widget? vectorTop;
  const CategoryBoxesShimmer(
      {Key? key,
        this.gradientStartColor,
        this.gradientEndColor,
        this.height,
        this.width,
        this.vectorBottom,
        this.vectorTop})
      : super(key: key);

  @override
  State<CategoryBoxesShimmer> createState() => _CategoryBoxesShimmerState();
}

class _CategoryBoxesShimmerState extends State<CategoryBoxesShimmer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: Container(
          height: 78.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xff1C2031),
          ),
          child: Center(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 19.h),
              child: Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: Color(0x4dd1d1d1),
                    highlightColor: Colors.white,
                    child: SizedBox(
                      height: 17.sp,
                      width: 120.w,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                                Radius.circular(7))
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Shimmer.fromColors(
                    baseColor: Color(0x4dd1d1d1),
                    highlightColor: Colors.white,
                    child: SizedBox(
                      height: 17.sp,
                      width: 72.w,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                                Radius.circular(7))
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
