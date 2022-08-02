import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

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
      print(news_url);
      print(news_titles);
      print(news_descriptions);
      //return images_url.toString();
      //print(document.getElementsByClassName("news__item")[0].getElementsByClassName(classNames));
      return [news_url, news_titles, news_descriptions];
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

      List<String> news_image_url = [];
      news_image_url.add(document.getElementsByClassName('col-lg-11 col-md-11 col-sm-11 col-xs-11 col-xsm-12 post')[0].children[1].attributes['src'].toString());

      if ((await document.getElementsByClassName('gallery-1')).length != 0) {
        document.getElementsByClassName('gallery-1')[0].getElementsByTagName('dl').forEach((element) {
          news_image_url.add(element.children[0].children[0].attributes['href'].toString());
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

      //return [news_image_url, news_description, news_rubric];
      return [[]];
    } else {
      return [[]];
    }
  }
}