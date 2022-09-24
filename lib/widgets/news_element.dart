import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fizmat_app_flutter/icons.dart';
import 'package:fizmat_app_flutter/widgets/svg_asset.dart';

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
            height: 176.h,
            width: 305.w,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: SvgAsset(
                      height: 176.h,
                      width: 306.w,
                      assetName: AssetName.vectorBottom),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: SvgAsset(
                      height: 176.h,
                      width: 305.w,
                      assetName: AssetName.vectorTop),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 11.w, right: 11.w, top: 22.h, bottom: 16.h,),
                  child: Row(
                    children: [
                      Container(
                        height: 130.w,
                        width: 130.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network(image!).image,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w,),
                      Column(
                        children: [
                          Container(
                            width: 180.w,
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
                          Container(height: 8.h, color: Colors.white,),
                          /*Container(
                            width: 180.w,
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
                          ),*/
                        ],
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
