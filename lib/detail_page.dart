import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fizmat_app_flutter/icons.dart';
import 'package:fizmat_app_flutter/widgets/svg_asset.dart';


class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool? isHeartIconTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 66.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.w),
                  child: Hero(
                  tag: "sleepMeditation",
                    child: Material(
                      color: Colors.transparent,
                      child: Text("В РФМШ Алматы вручили аттестаты выпускникам",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 34.w,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.w),
                  child: Text(
                    "Рубрики: #Школьная жизнь",
                    style: TextStyle(
                        color: Color(0xffffffff).withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 16.w),
                  ),
                ),
                SizedBox(height: 25.h),
                SizedBox(
                  height: 279.w,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(width: 28.w),
                      Container(
                        height: 280.w,
                        width: 280.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network("https://almaty.fizmat.kz/wp-content/uploads/sites/2/2022/06/attestat2.jpg").image,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Container(
                        height: 280.w,
                        width: 280.w,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network(
                              "https://almaty.fizmat.kz/wp-content/uploads/sites/2/2022/06/photo6147602698011258936.jpg",
                            ).image,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Container(
                        height: 280.w,
                        width: 280.w,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network(
                              "https://almaty.fizmat.kz/wp-content/uploads/sites/2/2022/06/photo6147602698011258935.jpg",
                            ).image,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                Padding(
                  padding: EdgeInsets.only(left: 28.w),
                  child: Row(
                    children: [
                      Container(
                        height: 56.w,
                        width: 56.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: Center(
                            child: SvgAsset(
                                assetName: AssetName.headphone,
                                height: 28.w,
                                width: 28.w)),
                      ),
                      SizedBox(width: 16.w),
                      Container(
                        height: 56.w,
                        width: 56.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: Center(
                            child: SvgAsset(
                                assetName: AssetName.tape,
                                height: 28.w,
                                width: 28.w)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 46.h),
                Padding(
                  padding: EdgeInsets.only(left: 28.w, right: 28.w, bottom: 80.h),
                  child: Text(
                    "14 июня 2022 года в РФМШ Алматы состоялась торжественная церемония вручения аттестатов выпускникам 2022 года."
                        "\n\nТоржественное мероприятие прошло в традиционном формате. В праздничном мероприятии приняли участие все выпускные классы, классные руководители и родители. Главных героев торжества школа встретила бурными аплодисментами, напомнив о достижениях каждого. Свои теплые пожелания выпускникам выразили председатель правления НАО «РФМШ» Калиев Р.С., член попечительского совета РФМШ Оспанов Б.Н., исполняющий обязанности директора школы Карим А.Т."
                        "\n\nОтметим, в этом году РФМШ Алматы окончили 180 выпускников. Из них 7 выпускников стали обладателями знака «Алтын белгі», а 53 выпускника удостоены аттестата особого образца."
                        "\n\nПрекрасный зал, море улыбок, приятных встреч, радостные лица и слезы счастья родителей  ожидало наших выпускников в этот волнительный день."
                        "\n\nДорогие выпускники, от всей души поздравляем Вас с этим замечательным праздником. Надеемся, что знания, полученные в школе, вы приумножите, будете воспитывать в себе лучшие качества. Желаем, чтобы ваши мечты исполнились. Удачи вам, везения, новых достижений, счастья и успехов в дальнейшей жизни!",
                    style: TextStyle(
                        color: Color(0xffffffff).withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 16.w),
                  ),
                )
              ],
            ),

            Align(alignment: Alignment.topCenter,
            child:   Container(
              color:  Color(0xff121421),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 22.w,
                  right: 22.w,
                  top: 20.h,
                  bottom: 10.h
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(360),
                        onTap: onBackIconTapped,
                        child: Container(
                          height: 35.w,
                          width: 35.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                          ),
                          child: Center(
                            child: SvgAsset(
                              assetName: AssetName.back,
                              height: 20.w,
                              width: 20.w,
                            ),
                          ),
                        ),
                      ),


                      InkWell(
                        borderRadius: BorderRadius.circular(360),
                        onTap: onHeartIconTapped,
                        child: Container(
                          height: 35.w,
                          width: 35.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                          ),
                          child: Center(
                            child: SvgAsset(
                              assetName: AssetName.heart,
                              height: 24.w,
                              width: 24.w,
                              color: isHeartIconTapped! ? Colors.red: Colors.white,
                            ),
                          ),
                        ),
                      ),




                    ],
                  ),
                ),
              ),
            )
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 87.h,
                decoration: BoxDecoration(
                  color: Colors.black,
                  gradient: LinearGradient(
                    stops: [0,1],
                    colors: [
                      Color(0xff121421),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter
                  )
                ),
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: onStartButtonPressed,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Color(0xff4A80F0),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          height: 56.h,
                          width: 319.w,
                          child: Center(
                              child: Text(
                                "Read online",
                                style: TextStyle(
                                    fontSize: 16.w,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

  void onStartButtonPressed() {

  }

  void onBackIconTapped() {
   Get.back();
  }

  void onHeartIconTapped() {
    setState(() {
      isHeartIconTapped = !isHeartIconTapped!;
    });
  }
}
