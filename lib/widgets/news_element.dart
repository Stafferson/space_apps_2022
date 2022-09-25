import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fizmat_app_flutter/icons.dart';
import 'package:fizmat_app_flutter/widgets/svg_asset.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewsItem extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? image;
  final String? url;
  final Function? onTap;
  final String? tag;
  const NewsItem(
      {Key? key,
        this.title,
        this.subtitle,
        this.image,
        this.url,
        this.onTap,
        this.tag,})
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
            gradient: const LinearGradient(
              colors: [
                Color(0xff441DFC),
                Color(0xff4E81EB),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Container(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: const SvgAsset(
                      height: 500,
                      width: 400,
                      assetName: AssetName.vectorBottomBottom),
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: const SvgAsset(
                        height: 500,
                        width: 400,
                        assetName: AssetName.vectorTopTop
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 22.h, bottom: 16.h,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 300.h,
                        width: 300.w,
                        child: CachedNetworkImage(
                          imageUrl: image!,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imageProvider,
                              ),
                            ),
                          ),
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              const SpinKitDoubleBounce(
                                color: Colors.white,
                                size: 50.0,
                              ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 2,
                        height: 24.h,
                      ),
                      Container(
                        width: 280.w,
                        child: Material(
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
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: 280.w,
                        child: Material(
                          color: Colors.transparent,
                          child: Hero(
                            tag: tag!,
                            child: DefaultTextStyle(
                              child: Text(subtitle!),
                              style: TextStyle(
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
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
