import 'package:fizmat_app_flutter/schedule_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fizmat_app_flutter/icons.dart';
import 'package:fizmat_app_flutter/widgets/svg_asset.dart';
import 'package:get/get.dart';

class ScheduleDayCard extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  final double? height;
  final double? width;
  final Widget? vectorBottom;
  final Widget? vectorTop;
  final Function? onTap;
  final int tagD;
  ScheduleDayCard(
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
        required this.tagD,})
      : super(key: key);

  @override
    _ScheduleDayCardState createState() => _ScheduleDayCardState();

}

class _ScheduleDayCardState extends State<ScheduleDayCard> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);


    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.onTap!(),
        borderRadius: BorderRadius.circular(26),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: LinearGradient(
              colors: [
                widget.gradientStartColor ?? Color(0xff441DFC),
                widget.gradientEndColor ?? Color(0xff4E81EB),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Container(
            height: double.infinity,
            child: Stack(
              children: [
                widget.vectorBottom ??
                    ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: SvgAsset(
                          height: 560.w,
                          width: 320.w,
                          assetName: AssetName.vectorBottom),
                    ),
                widget.vectorTop ??
                    ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: SvgAsset(
                          height: 560.w,
                          width: 320.w,
                          assetName: AssetName.vectorSmallTop),
                    ),
                // vectorTop ??
                //     ClipRRect(
                //       borderRadius: BorderRadius.circular(26),
                //       child: SvgAsset(
                //           height: 560.w,
                //           width: 320.w,
                //           assetName: AssetName.vectorSmallBottom),
                //     ),
                Padding(
                  padding: EdgeInsets.only(left: 24.w, top: 24.h, bottom: 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: widget.tagD,
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                widget.title!,
                                style: TextStyle(
                                    fontSize: 22.w,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          widget.subtitle != null
                              ? Text(
                            widget.subtitle!,
                            style: TextStyle(
                                fontSize: 16.w,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ): Container(),
                          FutureBuilder<List<List<String>>>(
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  print(snapshot.toString());
                                  return const Center(
                                    child: Text('An error has occurred!'),
                                  );
                                }
                                // else if (snapshot.data.isNull) {
                                //   return Text("Loading");
                                // }
                                else if (snapshot.hasData) {
                                  //return ListView.builder(
                                  //  itemCount: snapshot.data!.length,
                                  //  itemBuilder: (BuildContext context, int index) {
                                  //    return Text(
                                  //      snapshot.data![index],
                                  //      style: TextStyle(
                                  //          fontSize: 16.w,
                                  //          fontWeight: FontWeight.w300,
                                  //          color: Colors.white),
                                  //    );
                                  //  },
                                  //);

                                  return Text(snapshot.data![widget.tagD].join("\n\n"));
                                }
                                else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                              future: fetchSchedule(widget.tagD)
                          )
                        ],
                      ),
                      Row(
                        children: [
                          //Icon(Icons.)
                          //const Icon(Icons.newspaper_rounded, color: Colors.white,)
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

  @override
  bool get wantKeepAlive => true;

}
