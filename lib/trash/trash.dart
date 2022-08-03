import 'package:http/http.dart' as http;
import 'package:html/parser.dart';


void main() async {
  final response = await http.get(
    Uri.parse("https://almaty.fizmat.kz/news/v-rfmsh-almaty-vruchili-attestaty-vypusknikam/"),
  );

  var document = parse(response.body);

  document.getElementsByClassName('tags')[0].children[1].getElementsByTagName('li').forEach((element) {
    print(element.children[0].text.toString());
  });
  //print(document.getElementsByClassName('gallery-item').length);
  //print(document.getElementsByClassName('gallery-item').toString());
  //print(identical(document.getElementsByClassName('gallery-item').toString(), "null"));

  //if (document.getElementById('gallery-1')!. != 0) {
  //  document.getElementsByClassName('gallery-1')[0].getElementsByTagName('dl').forEach((element) {
  //    print(element.children[0].children[0].attributes['href'].toString());
  //  });
  //}
  //print(document.getElementsByClassName('col-lg-11 col-md-11 col-sm-11 col-xs-11 col-xsm-12 post')[0].children[1].attributes['src'].toString());

}