import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

import '../main.dart';

class News {
  static Future<List<List<String>>> get_last_3_news() async {
    final response = await http.get(
      Uri.parse('https://almaty.fizmat.kz/o-shkole/novosti-i-meropriyatiya/'),
    );

    if (response.statusCode == 200) {
      var document = parse(response.body);
      List<String> news_url = [for (var i = 0; i < 3; i++) document.getElementsByClassName('news__item-img')[i].children[0].attributes['href'].toString()];
      List<String> news_titles = [for (var i = 0; i < 3; i++) document.getElementsByClassName('news__item-txt')[i].children[0].children[0].text.toString()];
      List<String> news_descriptions = [for (var i = 0; i < 3; i++) document.getElementsByClassName('news__item-txt')[i].children[1].text.toString()];
      //print(news_url);
      //print(news_titles);
      //print(news_descriptions);
      //return images_url.toString();
      //print(document.getElementsByClassName("news__item")[0].getElementsByClassName(classNames));

      String news_pages = document.getElementsByClassName('page-numbers')[document.getElementsByClassName('page-numbers').length - 2].text.toString();
      prefs!.setString("news_pages_amount", news_pages);
      return [news_url, news_titles, news_descriptions] ;
    } else {
      return [[]];
    }
  }

  static Future<List<List<String>>> get_infonews_url(String url) async {
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      var document = parse(response.body);

      List<String> news_images_url = [];
      news_images_url.add(document.getElementsByClassName('col-lg-11 col-md-11 col-sm-11 col-xs-11 col-xsm-12 post')[0].children[1].attributes['src'].toString());

      if (document.getElementsByClassName('gallery-item').length != 0) {
        document.getElementsByClassName('gallery-item').forEach((element) {
          news_images_url.add(element.children[0].children[0].attributes['href'].toString());
        });
      }

      List<String> news_description = [];
      document.getElementsByClassName('col-lg-11 col-md-11 col-sm-11 col-xs-11 col-xsm-12 post')[0].getElementsByTagName('p').forEach((element) {
        news_description.add(element.text.toString());
      });

      List<String> news_rubric = [];
      document.getElementsByClassName('tags')[0].children[1].getElementsByTagName('li').forEach((element) {
        news_rubric.add(element.children[0].text.toString());
      });

      return [news_images_url, news_description, news_rubric];
      //return [[]];
    } else {
      return [[]];
    }
  }

  static Future<List<List<String>>> get_all_news_per_page(int pageNumber) async {

    int pageTotal = int.parse(prefs!.getString('news_pages_amount') ?? "90");

    if (pageNumber > pageTotal) {
      return [["0"]];
    }

    final response = await http.get(
      Uri.parse('https://almaty.fizmat.kz/o-shkole/novosti-i-meropriyatiya/page/${pageNumber}/'),
    );

    if (response.statusCode == 200) {
      var document = parse(response.body);

      List<String> news_url = [];
      List<String> news_titles = [];
      List<String> news_descriptions = [];
      try {
        news_url = [for (var i = 0; i < document.getElementsByClassName('news__item-img').length; i++) document.getElementsByClassName('news__item-img')[i].children[0].attributes['href'].toString()];
      } catch (e) {
        print(e);
      }
      try {
        news_titles = [for (var i = 0; i < document.getElementsByClassName('news__item-txt').length; i++) document.getElementsByClassName('news__item-txt')[i].children[0].children[0].text.toString()];
      } catch (e) {
        print(e);
      }
      try {
        news_descriptions = [for (var i = 0; i < document.getElementsByClassName('news__item-txt').length; i++) document.getElementsByClassName('news__item-txt')[i].children[1].text.toString()];
      } catch (e) {
        print(e);
      }
      print(document.getElementsByClassName('news__item-img').length);
      print(document.getElementsByClassName('news__item-txt').length);
      print(document.getElementsByClassName('news__item-txt').length);
      print("ALL NEWS ON PAGE ${pageNumber}");
      print(news_url);
      print(news_titles);
      print(news_descriptions);
      //return images_url.toString();
      //print(document.getElementsByClassName("news__item")[0].getElementsByClassName(classNames));
      return [news_url, news_titles, news_descriptions] ;
    } else {
      return [[]];
    }
  }

  static void test() async {

    List<String> news_url = [];
    List<String> news_titles = [];
    List<String> news_descriptions = [];
    for (int j = 0; j < 93; j++) {
      print(j);
      final response = await http.get(
        Uri.parse('https://almaty.fizmat.kz/o-shkole/novosti-i-meropriyatiya/page/${j}/'),
      );

      var document = parse(response.body);
      news_url.add(document.getElementsByClassName('news__item-img').length.toString());
      news_titles.add(document.getElementsByClassName('news__item-txt').length.toString());
      news_descriptions.add(document.getElementsByClassName('news__item-txt').length.toString());
    }
    print(news_url);
    print(news_titles);
    print(news_descriptions);
  }
}