import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fizmat_app_flutter/pages/detail_page.dart';
import 'package:fizmat_app_flutter/widgets/category_boxes.dart';
import 'package:fizmat_app_flutter/icons.dart';
import 'package:fizmat_app_flutter/widgets/discover_card.dart';
import 'package:fizmat_app_flutter/widgets/discover_small_card.dart';
import 'package:fizmat_app_flutter/widgets/svg_asset.dart';

import 'package:fizmat_app_flutter/fizmat_utils/news.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

List<List<String>> news = [];

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121421),
      body: SafeArea(
        child:
      ),
    );
  }

  Future<List<List<String>>> load_last_news() async {
    news = await News.get_last_3_news();
    return news;
  }

  void Log in tapped() {
  }
}
