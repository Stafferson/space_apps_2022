import 'package:http/http.dart' as http;
import 'package:html/parser.dart';


void main() async {
  final response = await http.get(
    Uri.parse('https://almaty.fizmat.kz/o-shkole/novosti-i-meropriyatiya/'),
  );

  if (response.statusCode == 200) {
    var document = parse(response.body);
    var images_url = document.getElementsByClassName('news__item-img')[0].text;
    print("1");
    print(images_url.toString());
    //print(document.getElementsByClassName("news__item")[0].getElementsByClassName(classNames));
  }
}