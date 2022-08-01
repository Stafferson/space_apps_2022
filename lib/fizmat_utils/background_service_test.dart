import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gsheets/gsheets.dart';
import 'package:http/http.dart';

import '../firebase_options.dart';

/// Your google auth credentials
///
/// how to get credentials - https://medium.com/@a.marenkov/how-to-get-credentials-for-google-sheets-456b7e88c430
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

/// Your spreadsheet id
///
/// It can be found in the link to your spreadsheet -
/// link looks like so https://docs.google.com/spreadsheets/d/YOUR_SPREADSHEET_ID/edit#gid=0
/// [YOUR_SPREADSHEET_ID] in the path is the id your need
const _spreadsheetId = '1LdtKUIRmVL6zoxAvbD83ecbLQouSlXyU-65XNl7rLT8';

void main() async {
  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('collection');

    Future<void> getData() async {
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await _collectionRef.get();

      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

      print(allData);
    }
  }

  init();
}