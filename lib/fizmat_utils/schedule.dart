import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gsheets/gsheets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

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

final gsheets = GSheets(_credentials);

List<String> arr0 = [];
List<String> arr1 = [];
List<String> arr2 = [];
List<String> arr3 = [];
List<String> arr4 = [];
List<String> arr00 = [];
List<String> arr11 = [];
List<String> arr22 = [];
List<String> arr33 = [];
List<String> arr44 = [];

FirebaseFirestore db = FirebaseFirestore.instance;

class Schedule {

  static Future<List<List<String>>> get_class_schedule() async {

    final prefs = await SharedPreferences.getInstance();
    String? _class = prefs.getString('class');
    print("class: {$_class}");
    final ss = await gsheets.spreadsheet(_spreadsheetId);

    var sheet;

    if (_class != null) {
      sheet = await ss.worksheetByTitle(_class);
      print("sheet title: " + sheet.title);
      print(sheet != null);

      if (sheet != null) {
        arr0 = await sheet.values.column(4, fromRow: 5);
        arr1 = await sheet.values.column(5, fromRow: 5);
        arr2 = await sheet.values.column(6, fromRow: 5);
        arr3 = await sheet!.values.column(7, fromRow: 5);
        arr4 = await sheet.values.column(8, fromRow: 5);
        //make sure that everything is a part of user needed schedule
        arr0.removeWhere((element) => element.length <= 5);
        arr1.removeWhere((element) => element.length <= 5);
        arr2.removeWhere((element) => element.length <= 5);
        arr3.removeWhere((element) => element.length <= 5);
        arr4.removeWhere((element) => element.length <= 5);

        db.collection("schedule_timeline").get().then(
              (res) {
            //res.docs.elementAt(1).data().values.forEach((element) {
            //  arr00.add(element);
            //});
            arr00 = List<String>.from(res.docs.elementAt(1).data().values.toList());
            //res.docs.elementAt(3).data().values.forEach((element) {
            //  arr11.add(element);
            //});
            arr11 = List<String>.from(res.docs.elementAt(3).data().values.toList());
            //res.docs.elementAt(4).data().values.forEach((element) {
            //  arr22.add(element);
            //});
            arr22 = List<String>.from(res.docs.elementAt(4).data().values.toList());
            //res.docs.elementAt(2).data().values.forEach((element) {
            //  arr33.add(element);
            //});
            arr33 = List<String>.from(res.docs.elementAt(2).data().values.toList());
            //res.docs.elementAt(0).data().values.forEach((element) {
            //  arr44.add(element);
            //});
            arr44 = List<String>.from(res.docs.elementAt(0).data().values.toList());
          },
          onError: (e) => print("Error completing: $e"),
        );

        if (arr0 == null || arr0.length == 0) {
          arr0 = ["", "", "", "", "", "", "", "", "", ""];
        }
        if (arr1 == null || arr1.length == 0) {
          arr1 = ["", "", "", "", "", "", "", "", "", ""];
        }
        if (arr2 == null || arr2.length == 0) {
          arr2 = ["", "", "", "", "", "", "", "", "", ""];
        }
        if (arr3 == null || arr3.length == 0) {
          arr3 = ["", "", "", "", "", "", "", "", "", ""];
        }
        if (arr4 == null || arr4.length == 0) {
          arr4 = ["", "", "", "", "", "", "", "", "", ""];
        }
        if (arr00 == null || arr00.length == 0) {
          arr00 = ["8:00 - 8:45", "8:50 - 9.35", "9:50 - 10.35", "10:40 - 11.25", "11:45 - 12.30", "12:35 - 13.20", "13:40 - 14.25,", "14:30 - 15.15", "15:40 - 16.25", "16:30 - 17.15"];
        }
        if (arr11 == null || arr11.length == 0) {
          arr11 = ["8:00 - 8:45", "8:50 - 9.35", "9:50 - 10.35", "10:40 - 11.25", "11:45 - 12.30", "12:35 - 13.20", "13:40 - 14.25,", "14:30 - 15.15", "15:40 - 16.25", "16:30 - 17.15"];
        }
        if (arr22 == null || arr22.length == 0) {
          arr22 = ["8:00 - 8:45", "8:50 - 9.35", "9:50 - 10.35", "10:40 - 11.25", "11:45 - 12.30", "12:35 - 13.20", "13:40 - 14.25,", "14:30 - 15.15", "15:40 - 16.25", "16:30 - 17.15"];
        }
        if (arr33 == null || arr33.length == 0) {
          arr33 = ["8:00 - 8:45", "8:50 - 9.35", "9:50 - 10.35", "10:40 - 11.25", "11:45 - 12.30", "12:35 - 13.20", "13:40 - 14.25,", "14:30 - 15.15", "15:40 - 16.25", "16:30 - 17.15"];
        }
        if (arr44 == null || arr44.length == 0) {
          arr44 = ["8:00 - 8:45", "8:50 - 9.35", "9:50 - 10.35", "10:40 - 11.25", "11:45 - 12.30", "12:35 - 13.20", "13:40 - 14.25,", "14:30 - 15.15", "15:40 - 16.25", "16:30 - 17.15"];
        }

        print("SCHEDULE AND TIMELINE");
        print(arr0);
        print(arr1);
        print(arr2);
        print(arr3);
        print(arr4);
        print(arr00);
        print(arr11);
        print(arr22);
        print(arr33);
        print(arr44);


        prefs.setStringList("class_monday", arr0);
        prefs.setStringList("class_tuesday", arr1);
        prefs.setStringList("class_wednesday", arr2);
        prefs.setStringList("class_thursday", arr3);
        prefs.setStringList("class_friday", arr4);
        prefs.setStringList("class_monday_schedule", arr00);
        prefs.setStringList("class_tuesday_schedule", arr11);
        prefs.setStringList("class_wednesday_schedule", arr22);
        prefs.setStringList("class_thursday_schedule", arr33);
        prefs.setStringList("class_friday_schedule", arr44);

        return [arr0, arr1, arr2, arr3, arr4, arr00, arr11, arr22, arr33, arr44];
      } else {
        print("1");
        return [["1"]]; // no such class in google sheets
      }
    } else {
      print("2");
      return [["0"]]; // no class saved
    }
  }

  static Future<List<List<String>>> get_class_schedule_by_id(String _class) async {

    final prefs = await SharedPreferences.getInstance();
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    var sheet;

    sheet = await ss.worksheetByTitle(_class);
    print("sheet title: " + sheet.title);
    print(sheet != null);

    if (sheet != null) {
      arr0 = await sheet.values.column(4, fromRow: 5);
      arr1 = await sheet.values.column(5, fromRow: 5);
      arr2 = await sheet.values.column(6, fromRow: 5);
      arr3 = await sheet!.values.column(7, fromRow: 5);
      arr4 = await sheet.values.column(8, fromRow: 5);
      //make sure that everything is a part of user needed schedule
      arr0.removeWhere((element) => element.length <= 5);
      arr1.removeWhere((element) => element.length <= 5);
      arr2.removeWhere((element) => element.length <= 5);
      arr3.removeWhere((element) => element.length <= 5);
      arr4.removeWhere((element) => element.length <= 5);

      db.collection("schedule_timeline").get().then(
            (res) {
          //res.docs.elementAt(1).data().values.forEach((element) {
          //  arr00.add(element);
          //});
          arr00 = List<String>.from(res.docs.elementAt(1).data().values.toList());
          //res.docs.elementAt(3).data().values.forEach((element) {
          //  arr11.add(element);
          //});
          arr11 = List<String>.from(res.docs.elementAt(3).data().values.toList());
          //res.docs.elementAt(4).data().values.forEach((element) {
          //  arr22.add(element);
          //});
          arr22 = List<String>.from(res.docs.elementAt(4).data().values.toList());
          //res.docs.elementAt(2).data().values.forEach((element) {
          //  arr33.add(element);
          //});
          arr33 = List<String>.from(res.docs.elementAt(2).data().values.toList());
          //res.docs.elementAt(0).data().values.forEach((element) {
          //  arr44.add(element);
          //});
          arr44 = List<String>.from(res.docs.elementAt(0).data().values.toList());
        },
        onError: (e) => print("Error completing: $e"),
      );

      print("SCHEDULE AND TIMELINE");

      if (arr0 == null || arr0.length == 0) {
        arr0 = ["", "", "", "", "", "", "", "", "", ""]; // no such class in google sheets
      }
      if (arr1 == null || arr1.length == 0) {
        arr1 = ["", "", "", "", "", "", "", "", "", ""];
      }
      if (arr2 == null || arr2.length == 0) {
        arr2 = ["", "", "", "", "", "", "", "", "", ""];
      }
      if (arr3 == null || arr3.length == 0) {
        arr3 = ["", "", "", "", "", "", "", "", "", ""];
      }
      if (arr4 == null || arr4.length == 0) {
        arr4 = ["", "", "", "", "", "", "", "", "", ""];
      }
      if (arr00 == null || arr00.length == 0) {
        arr00 = ["8:00 - 8:45", "8:50 - 9.35", "9:50 - 10.35", "10:40 - 11.25", "11:45 - 12.30", "12:35 - 13.20", "13:40 - 14.25,", "14:30 - 15.15", "15:40 - 16.25", "16:30 - 17.15"];
      }
      if (arr11 == null || arr11.length == 0) {
        arr11 = ["8:00 - 8:45", "8:50 - 9.35", "9:50 - 10.35", "10:40 - 11.25", "11:45 - 12.30", "12:35 - 13.20", "13:40 - 14.25,", "14:30 - 15.15", "15:40 - 16.25", "16:30 - 17.15"];
      }
      if (arr22 == null || arr22.length == 0) {
        arr22 = ["8:00 - 8:45", "8:50 - 9.35", "9:50 - 10.35", "10:40 - 11.25", "11:45 - 12.30", "12:35 - 13.20", "13:40 - 14.25,", "14:30 - 15.15", "15:40 - 16.25", "16:30 - 17.15"];
      }
      if (arr33 == null || arr33.length == 0) {
        arr33 = ["8:00 - 8:45", "8:50 - 9.35", "9:50 - 10.35", "10:40 - 11.25", "11:45 - 12.30", "12:35 - 13.20", "13:40 - 14.25,", "14:30 - 15.15", "15:40 - 16.25", "16:30 - 17.15"];
      }
      if (arr44 == null || arr44.length == 0) {
        arr44 = ["8:00 - 8:45", "8:50 - 9.35", "9:50 - 10.35", "10:40 - 11.25", "11:45 - 12.30", "12:35 - 13.20", "13:40 - 14.25,", "14:30 - 15.15", "15:40 - 16.25", "16:30 - 17.15"];
      }

      print(arr0);
      print(arr1);
      print(arr2);
      print(arr3);
      print(arr4);
      print(arr00);
      print(arr11);
      print(arr22);
      print(arr33);
      print(arr44);

      prefs.setStringList("${_class}class_monday", arr0);
      prefs.setStringList("${_class}class_tuesday", arr1);
      prefs.setStringList("${_class}class_wednesday", arr2);
      prefs.setStringList("${_class}class_thursday", arr3);
      prefs.setStringList("${_class}class_friday", arr4);
      prefs.setStringList("class_monday_schedule", arr00);
      prefs.setStringList("class_tuesday_schedule", arr11);
      prefs.setStringList("class_wednesday_schedule", arr22);
      prefs.setStringList("class_thursday_schedule", arr33);
      prefs.setStringList("class_friday_schedule", arr44);

      List<String> arr_saved_classes = prefs.getStringList("saved_classes") ?? [];
      print(arr_saved_classes);
      if (!arr_saved_classes.contains(_class)) {
        arr_saved_classes.add(_class);
      }
      prefs.setStringList("saved_classes", arr_saved_classes);
      print("NIGGERS ARE HERE");
      print(arr_saved_classes);
      print(arr_saved_classes.contains(_class));

      return [arr0, arr1, arr2, arr3, arr4, arr00, arr11, arr22, arr33, arr44];
    } else {
      print("1");
      return [["1"]]; // no such class in google sheets
    }
  }

  static Future<List<List<String>>> get_class_timeline() async {

    final prefs = await SharedPreferences.getInstance();
    String? _class = prefs.getString('class');
    print("class: {$_class}");
    final ss = await gsheets.spreadsheet(_spreadsheetId);

    var sheet;

    if (_class != null) {
      sheet = await ss.worksheetByTitle(_class);
      print("sheet title: " + sheet.title);
      print(sheet != null);
      if (sheet != null) {
        arr0 = await sheet.values.column(4, fromRow: 5);
        arr1 = await sheet.values.column(5, fromRow: 5);
        arr2 = await sheet.values.column(6, fromRow: 5);
        arr3 = await sheet!.values.column(7, fromRow: 5);
        arr4 = await sheet.values.column(8, fromRow: 5);
        //make sure that everything is a part of user needed schedule
        arr0.removeWhere((element) => element.length <= 5);
        arr1.removeWhere((element) => element.length <= 5);
        arr2.removeWhere((element) => element.length <= 5);
        arr3.removeWhere((element) => element.length <= 5);
        arr4.removeWhere((element) => element.length <= 5);

        prefs.setStringList("class_monday", arr0);
        prefs.setStringList("class_tuesday", arr1);
        prefs.setStringList("class_wednesday", arr2);
        prefs.setStringList("class_thursday", arr3);
        prefs.setStringList("class_friday", arr4);

        return [arr0, arr1, arr2, arr3, arr4];
      } else {
        print("1");
        return [["1"]]; // no such class in google sheets
      }
    } else {
      print("2");
      return [["0"]]; // no class saved
    }
  }

  static Future<List<List<String>>> get_saved_class_schedule() async {

    String? _class = prefs!.getString('class');
    print("class: {$_class}");


    arr0 = await prefs!.getStringList("class_monday")!;
    arr1 = await prefs!.getStringList("class_tuesday")!;
    arr2 = await prefs!.getStringList("class_wednesday")!;
    arr3 = await prefs!.getStringList("class_thursday")!;
    arr4 = await prefs!.getStringList("class_friday")!;

    if (arr0 != null) {
      return [arr0, arr1, arr2, arr3, arr4];
    } else {
      return [["0"]]; // no class saved
    }
  }

  static Future<List<String>> get_list_all_classes() async {

    final ss = await gsheets.spreadsheet(_spreadsheetId);

    List<String> arr = [];

    for (int i = 0; i < 100; i++) {
      var sheet = await ss.worksheetByIndex(i);
      if (sheet != null) {
        arr.add(sheet.title);
      }
      else {
        break;
      }
    }

    return arr;
  }

  static Future<List<List<String>>> get_list_all_classes_info() async {

    final ss = await gsheets.spreadsheet(_spreadsheetId);

    List<String> arr0 = [];
    List<String> arr1 = [];

    for (int i = 0; i < 100; i++) {
      var sheet = await ss.worksheetByIndex(i);
      if (sheet != null) {
        arr0.add(sheet.title.replaceAll(RegExp(r'[^0-9]'),''));
        arr1.add(sheet.title.replaceAll(RegExp(r'[^a-zA-Z]'),''));
      }
      else {
        break;
      }
    }

    return [arr0.toSet().toList(), arr1.toSet().toList()];
  }

}