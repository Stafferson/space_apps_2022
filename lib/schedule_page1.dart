import 'package:fizmat_app_flutter/widgets/schedule_day_element_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fizmat_app_flutter/detail_page.dart';
import 'package:fizmat_app_flutter/widgets/category_boxes.dart';
import 'package:fizmat_app_flutter/icons.dart';
import 'package:fizmat_app_flutter/widgets/discover_card.dart';
import 'package:fizmat_app_flutter/widgets/discover_small_card.dart';
import 'package:fizmat_app_flutter/widgets/svg_asset.dart';
import 'package:gsheets/gsheets.dart';

int _index = 0;
final PageController _pageController = PageController(initialPage: 0, keepPage: true);
final PageController _pageController1 = PageController(initialPage: 0, viewportFraction: 1 / 5, keepPage: true);
const _credentials = r'''
{
   "type": "service_account",
   "project_id": "testtest1-326506",
   "private_key_id": "a2ca143d9e4d70406caa08fea80e080f370fb898",
   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDAntdNIsgrZdqV\nXFCrSv+esyjUL+kS5Qo0+UzJ0NcdUVyLfAIHsX8tQubW38hW2z3tEDrJsKOEJ+oo\naHklHFKATrBqZMvfuWTzBs5cljXm/sVqBEppdnfa1xx9Zq3AnwfejzcV3MxprPxK\nTNzavVE46u/GN026hMflNiT9muD2TEU0MICXUYm9YfAMMCUj2iHIUZeZqcV+CLOs\nZgk6Vzt0t5EoAQkmtC1WEAqyf+2xxW7w3q12jpgMD7Idia81b7BzHdyZBq2RYwjf\nlHvB/qT+ur/8rDJK9RlPmHG+JuzjF299O1rFUQLFkYHpLYrC2bvBJzrMZSovVowa\nyggQbGaTAgMBAAECggEAPHJ8gV3tcEUN8/pc7GxkTJLPuMryOzY6XkZv9RN/Nlme\nj71SS8TFcthAZeUjUzKJO/hwYnP21JXME3M5tU4ui8pl7XWFT0e4aNXVc9PFxaBl\nJnCDQ5ZkZX5FGAtdconVp9/MuyUn1u/s2opFcrWfpBuCNHONhn991a4IrLdqapAY\nB82txIvsG5fLNnfU+rdbSbDh6Wqov5ybv43GmafE7ldRhmfRiIYgo9fSoQ4sfKU4\n2J5Wc1Z1V1pgYlKMpdktKoM5SlSCeHxoIqaL40ntLcYnAE3UpMSS8teUbWMDuKL7\nwkgAol2h627uV42/ukFi0ahnD+ClU8OUtRtosIlFGQKBgQDwM1s+W1cwSgwtkxFx\niqUn97PKW5skjRRUvIQILCmn87HgIqTX5oC7xDXfWSUYXUu9rLv2M7Lejk0tARQH\nDtbWEYeBho3k5nYgUgad43NmpcaxitrM0UalIAjY7dY8XUn0Y2YhvaUjZcQUsnFK\nYybfR0r0rj9Cy4W2rQmuwtLriwKBgQDNSk0mxb/5rHHspEl76HfMv5ep80J589ga\nv34/n4wDhFrjup2C0huRQuFG8+X2woINDjLYzG9C/n0JFSD+/DwFHGGJnMcUpZZF\n1ueTJkMXqiM3X03zxFBC8EchgWyTn8P0IuqQn8gmSVFqa2fPkz+PTsIrPYNTUpoj\n24x1Qr7yGQKBgAcrQTnnN/709tAVZ5vf63X56p/LhCHfJBAzYC1uRAADQffSkODw\nvD7eaE02N+k2P6B1m1aJzHjf/mWtdo+PXdIdy9GN1oZSaowkZpYnx7X0lK2P21/p\njxY2ko0G7DH5BtAId2/iXR9lVijX+pGhy/M2CYKsAK9Zq6/8EiHpJqppAoGBAKOJ\nvUxV3EkZhuftOFztJAKH3loU37AnANDOG9SzVOa4WW9xCmlc13kwviW3xkp9SPz9\ngqQSt8+2zASgQFjgty+bHFhz/GQGRV/9gx1GLcx8TPGfionWqdmpcADRCZ3QeFnU\nNuhfYSKe5azRQzGpK8kOBMBNkICgHQrTq2D+ev6BAoGABSm5XoZr3NSiLKMa2znX\n9l4YGmcn0ttb3zMWwBKnGFbyDFhe6K2VECHLlgOQKKrLwpFiiseF1mAkgWno71ad\n+ubcaU70GBTsqvs+f0cFnl2uXaV2Z521NN5qze+H/EAA77k9z9SUT/vvxPKfwnyx\nxdun5rm9Y/VXtFKqE9YMkKc=\n-----END PRIVATE KEY-----\n",
   "client_email": "server-sheet-acceser@testtest1-326506.iam.gserviceaccount.com",
   "client_id": "118153376587632505628",
   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
   "token_uri": "https://oauth2.googleapis.com/token",
   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/server-sheet-acceser%40testtest1-326506.iam.gserviceaccount.com"
}
''';
const _spreadsheetId = '1LdtKUIRmVL6zoxAvbD83ecbLQouSlXyU-65XNl7rLT8';

List<String> arr = [];
List<String> arr1 = [];
List<String> arr2 = [];
List<String> arr3 = [];
List<String> arr4 = [];

final gsheets = GSheets(_credentials);

Future<List<List<String>>> fetchSchedule(int _day) async {
  String _class = "10E";

  final ss = await gsheets.spreadsheet(_spreadsheetId);

  final sheet = await ss.worksheetByTitle(_class);

  arr3 = await sheet!.values.column(7, fromRow: 5);
  switch (_day) {
    case (0):
      arr4 = await sheet.values.column(8, fromRow: 5);
      arr = await sheet.values.column(4, fromRow: 5);
      break;
    case (1):
      arr1 = await sheet.values.column(5, fromRow: 5);
      break;
    case (2):
      arr2 = await sheet.values.column(6, fromRow: 5);
      break;
    case (3):
      break;
    case (4):
      break;
  }

  arr.removeWhere((element) => element.length <= 5);
  arr1.removeWhere((element) => element.length <= 5);
  arr2.removeWhere((element) => element.length <= 5);
  arr3.removeWhere((element) => element.length <= 5);
  arr4.removeWhere((element) => element.length <= 5);

  return compute(parseSchedule, [arr, arr1, arr2, arr3, arr4]);

  //List<String> arr = [];
  //List<String> arr1 = [];
  //List<String> arr2 = [];
  //List<String> arr3 = [];
  //List<String> arr4 = [];
  //try {
  //  arr = await sheet!.values.column(4, fromRow: 5);
  //  arr1 = await sheet.values.column(5, fromRow: 5);
  //  arr2 = await sheet.values.column(6, fromRow: 5);
  //  arr3 = await sheet.values.column(7, fromRow: 5);
  //  arr4 = await sheet.values.column(8, fromRow: 5);
  //} catch (e) {
  //  print(e);
  //}

  //if (arr != [] && arr1 != [] && arr2 != [] && arr3 != [] && arr4 != []) {
  //  return compute(parseSchedule, [arr, arr1, arr2, arr3, arr4]);
  //} else {
  //  return [];
  //}

  return [];

  //var arr0 = [arr, arr1, arr2, arr3, arr4];
  //print("DSADS" + arr0.toString());


  //return compute(parseSchedule, arr0);
}

List<List<String>> parseSchedule(arr0) {
  print("REQUEST SHEETS");
  //print(arr0.toString());
  return arr0;
}



class SchedulePage1 extends StatefulWidget {
  const SchedulePage1({
    Key? key,
  }) : super(key: key);

  @override
  State<SchedulePage1> createState() => _SchedulePageState1();
}
final List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

class _SchedulePageState1 extends State<SchedulePage1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121421),
      body: SafeArea(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 28.w,
                right: 18.w,
                top: 16.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Schedule",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.w,
                          fontWeight: FontWeight.bold)),
                  InkWell(
                    borderRadius: BorderRadius.circular(360),
                    onTap: onSearchIconTapped,
                    child: Container(
                      height: 35.w,
                      width: 35.w,
                      child: Center(
                        child: SvgAsset(
                          assetName: AssetName.search,
                          height: 24.w,
                          width: 24.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
              height: 560.h,
              child: Center(
                child: PageView.builder (
                  onPageChanged: (int index) {
                    setState(() {
                      _index = index;
                      print(_index);
                      _pageController1.animateToPage(
                        _index,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    });
                  },
                  controller: _pageController,
                  // padding: EdgeInsets.only(
                  //   left: 40.w,
                  //   right: 40.w,
                  // ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                      child: ScheduleDayCard(
                          tagD : index,
                        title: days[index],
                        subtitle: "${days[index]} subtitle"
                      ),
                    );
                  },
                  itemCount: days.length,
                ),
              ),
            ),

            Container(
              transform: Matrix4.translationValues(0.0, -14.0, 0.0),
              height: 100.h,
              margin: EdgeInsets.only(left: 0, right: 0),
              child: PageView.builder(
                onPageChanged: (int index) {
                  setState(() {
                    _index = index;
                    print(_index);
                    _pageController.animateToPage(
                      _index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                    );
                  });
                },
                controller: _pageController1,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        //fetchSchedule();
                        goToSelectedDay(index);
                      },
                      child: TextButton(
                          onPressed: () => print("DSA"),
                          child: Text(
                            days[index],
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 10.w,
                              color: Colors.white),
                          )
                      ),
                    ),
                  );
                },
                itemCount: days.length,
              ),
            ),
            Container(
              color: Colors.white,
              width: 10.w,
              height: 10.w,
              transform: Matrix4.translationValues(0.0, -30.0, 0.0),
            )
          ],
        ),
      ),
    );
  }

  goToSelectedDay(int index) {
    _index = index;
    _pageController1.animateToPage(
      _index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
    _pageController.animateToPage(
      _index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
    //print("DSA $index");
  }

  void onSeeAllTapped() {
  }

  void onSleepMeditationTapped() {
    //Get.to(()=> DetailPage(), transition: Transition.rightToLeft);
  }

  void onDepressionHealingTapped() {
  }

  void onSearchIconTapped() {
  }



}
