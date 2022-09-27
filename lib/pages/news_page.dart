import 'package:animate_icons/animate_icons.dart';
import 'package:fizmat_app_flutter/widgets/news_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:fizmat_app_flutter/fizmat_utils/newsAPI.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import 'detail_page.dart';


class NewsPage extends StatefulWidget {
  const NewsPage(
      {Key? key,}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

AnimateIconController _controller = AnimateIconController();

class _NewsPageState extends State<NewsPage> {
  final PagingController<int, List<String>> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      var newItems = await NewsApi.get_all_news_per_page(pageKey);
      var isLastPage = pageKey >= int.parse(prefs!.getString('news_pages_amount') ?? "90");
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      //appBar: appbar_builder(),
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                floating: true,
                snap: true,
                toolbarHeight: 60,
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
                  child: Text("All News",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.w,
                          fontWeight: FontWeight.bold)
                  ),
                ),
                backgroundColor: Color(0xff121421),
              ),
            ];
          },
          body: news_builder(),
        ),
      ),
    );
  }

  void onBackIconTapped() {
    Get.back();
  }

  Future<void> onOpen(LinkableElement link) async {
    await launchUrl(Uri.parse(link.url), mode: LaunchMode.externalApplication);
  }

  AppBar appbar_builder() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 60,
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
        child: Text("All News",
            style: TextStyle(
                color: Colors.white,
                fontSize: 34.w,
                fontWeight: FontWeight.bold)
        ),
      ),
      backgroundColor: Color(0xff121421),
      //actions: <Widget>[
      //  Padding(
      //    padding: EdgeInsets.only(
      //      top: 10.h,
      //    ),
      //    child: AnimateIcons(
      //      startIcon: Icons.refresh_rounded,
      //      endIcon: Icons.refresh_rounded,
      //      size: 28.0,
      //      // add this tooltip for the start icon
      //      startTooltip: 'Icons.add_circle',
      //      // add this tooltip for the end icon
      //      endTooltip: 'Icons.add_circle_outline',
      //      controller: _controller,
      //      onStartIconPress: () {
      //        setState(() {});
      //        return true;
      //      },
      //      onEndIconPress: () {
      //        setState(() {});
      //        return true;
      //      },
      //      startIconColor: Colors.white,
      //      endIconColor: Colors.white,
      //      duration: Duration(milliseconds: 500),
      //      clockwise: true,
      //    ),
      //  ),
      //],
    );
  }
  
  Widget news_builder() {
    return RefreshIndicator(
      onRefresh: () => Future.sync(
          () => _pagingController.refresh()
      ),
      child: Container(
        child: Center(
          child: PagedListView<int, List<String>>.separated(
            pagingController: _pagingController,
            padding: const EdgeInsets.all(16),
            builderDelegate: PagedChildBuilderDelegate<List<String>>(
                newPageProgressIndicatorBuilder: (_) => const SpinKitDoubleBounce(
                  color: Colors.white,
                  size: 50.0,
                ),
                firstPageProgressIndicatorBuilder: (_) => const SpinKitDoubleBounce(
                  color: Colors.white,
                  size: 50.0,
                ),
                itemBuilder: (context, item, index) {
                  String title = "";
                  String subtitle = "";
                  //if (item[0].length > 45) {
                  //  title = "${item[0].substring(
                  //      0, 46)}...";
                  //} else {
                  //  title = item[0];
                  //}

                  title = item[0];

                  //if (item[1].length > 41) {
                  //  subtitle = "${item[1].substring(0, 42)}...";
                  //} else {
                  //  subtitle = item[1];
                  //}
                  subtitle = item[1];
                  return NewsItem(
                    title: title,
                    subtitle: subtitle,
                    image: item[2],
                    url: item[3],
                    tag: "all_news_$index",
                    onTap: () => onNewsTapped(index, item, "all_news_$index"),
                  );
              }
            ),
            separatorBuilder: (contex, index) => SizedBox(height: 16.h),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  onNewsTapped(int index1, List<String> _snapshot, String tag) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Get.to(()=> DetailPage(tag: tag, title: _snapshot[0], url: _snapshot[3], index: index1), transition: Transition.rightToLeft);
    });
  }
}
