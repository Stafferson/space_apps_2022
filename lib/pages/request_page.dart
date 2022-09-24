// import 'dart:io';
// import 'dart:ui';
//
// import 'package:direct_select_flutter/direct_select_container.dart';
// import 'package:direct_select_flutter/direct_select_item.dart';
// import 'package:direct_select_flutter/direct_select_list.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:http/http.dart';
// import 'package:select_form_field/select_form_field.dart';
//
// class RequestPage extends StatefulWidget {
//   const RequestPage({Key? key}) : super(key: key);
//
//   @override
//   State<RequestPage> createState() => _RequestPageState();
// }
//
// class _RequestPageState extends State<RequestPage> {
//   final _formKey = GlobalKey<FormState>();
//   final List<Map<String, dynamic>> _items = [
//     {
//       'value': 'plot',
//       'label': 'Плотник',
//       'textStyle': const TextStyle(color: Colors.white),
//     },
//     {
//       'value': 'santech',
//       'label': 'Сантехник',
//       'textStyle': const TextStyle(color: Colors.white),
//     },
//     {
//       'value': 'sis',
//       'label': 'Сисадмин',
//       'textStyle': const TextStyle(color: Colors.white),
//     },
//   ];
//   String w = 'plot';
//   TextEditingController controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Form(
//             key: _formKey,
//             child: Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     TextFormField(
//                       keyboardType: TextInputType.multiline,
//                       maxLines: null,
//                       controller: controller,
//                       style: const TextStyle(fontSize: 25, color: Colors.black),
//                       decoration: InputDecoration(
//                         label: const Text(
//                           "Введите Проблему",
//                           style: TextStyle(color: Colors.black),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Введите текст';
//                         }
//                         return null;
//                       },
//                     ),
//                     SelectFormField(
//                       type: SelectFormFieldType.dropdown,
//                       labelText: 'Персонал',
//                       items: _items,
//                       style: const TextStyle(color: Colors.black),
//                       onChanged: (val) {
//                         w = val;
//                         print(w);
//                       },
//                     ),
//                     TextButton(
//                       onPressed: sendButtonClicked,
//                       child: const Text('Отправить'),
//                     )
//                   ],
//                 ))));
//   }
//
//   void sendButtonClicked() {
//     if (_formKey.currentState!.validate()) {
//       var name = FirebaseAuth.instance.currentUser!.displayName;
//       sendRequest(name, controller.text, w);
//     }
//   }
//
//   DirectSelectItem<String> getDropDownMenuItem(String value) {
//     return DirectSelectItem<String>(
//         itemHeight: 56,
//         value: value,
//         itemBuilder: (context, value) {
//           return Text(value);
//         });
//   }
//
//   _getDslDecoration() {
//     return const BoxDecoration(
//       border: BorderDirectional(
//         bottom: BorderSide(width: 1, color: Colors.black12),
//         top: BorderSide(width: 1, color: Colors.black12),
//       ),
//     );
//   }
//
//   void sendRequest(String? name, String problem, String who) async {
//     var map = Map<String, dynamic>();
//     map['name'] = name;
//     map['problem'] = problem;
//     map['who'] = who;
//     var response = await post(
//         Uri.parse('https://fizmatsheetapp.herokuapp.com/WriteData'),
//         headers: <String, String>{
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: map);
//     if (response.statusCode != 200) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Ошибка')));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//         'Успешно',
//         style: TextStyle(color: Colors.white),
//       )));
//     }
//   }
// }
