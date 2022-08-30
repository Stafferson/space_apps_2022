import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121421),
      body: SafeArea(
        child: AnimationLimiter(
          child: Column(
            children: [
              const Expanded(flex: 2, child: _TopPortion()),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "${user!.displayName}",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      profile_buttons_builder(),
                      const SizedBox(height: 16),
                      const _ProfileInfoRow()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget profile_buttons_builder() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FloatingActionButton.extended(
        onPressed: () {},
        heroTag: 'follow',
        elevation: 0,
        label: const Text("Follow"),
        icon: const Icon(Icons.person_add_alt_1),
      ),
      const SizedBox(width: 16.0),
      const FloatingActionButton.extended(
        onPressed: test,
        heroTag: 'mesage',
        elevation: 0,
        backgroundColor: Colors.red,
        label: Text("Message"),
        icon: Icon(Icons.message_rounded),
      ),
    ],
  );
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

  final List<ProfileInfoItem> _items = const [
    ProfileInfoItem("Volunteering hours", 900),
    ProfileInfoItem("Sport hours", 120),
    ProfileInfoItem("Club hours", 200),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items
            .map((item) => Expanded(
            child: Row(
              children: [
                if (_items.indexOf(item) != 0) const VerticalDivider(),
                Expanded(child: _singleItem(context, item)),
              ],
            )))
            .toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item.value.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      Text(
        item.title,
        style: Theme.of(context).textTheme.caption,
      )
    ],
  );
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff0043ba), Color(0xff006df1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                /*const SizedBox(width: 60, height: 10),
                Text(
                  "You're",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 34.w,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(width: 10, height: 10),
                DefaultTextStyle(
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 34.w,
                      fontWeight: FontWeight.bold
                  ),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      RotateAnimatedText('AWESOME'),
                      RotateAnimatedText('GENIUS'),
                      RotateAnimatedText('DIFFERENT'),
                    ],
                    onTap: () {
                      print(user!.uid);
                      print(user!.email.toString());
                      print(user!.displayName.toString());
                      print(user!.photoURL.toString());
                      print(user!.phoneNumber.toString());
                    },
                  ),
                ),*/
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200")),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
void test() {
  final wednesday = <String, String>{
    "1": "8.00 - 8.45",
    "2": "8.50 - 9.35",
    "3": "9.50 - 10.35",
    "4": "10.40 - 11.25",
    "5": "11.45 - 12.30",
    "6": "12.35 - 13.20",
    "7": "13.40 - 14.25",
    "8": "14.30 - 15.15",
    "9": "15.40 - 16.25",
    "10": "16.30 - 17.15",
  };

  FirebaseFirestore? db;
  db = FirebaseFirestore.instance;

  //db.collection("schedule_timeline")
  //    .doc("friday")
  //    .set(wednesday)
  //    .onError((e, _) => print("Error writing document: $e"));
  //print("OK");

  /*final docRef = db.collection("schedule_timeline").doc("monday");
  docRef.get().then(
        (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      for (int i = 0; i < data.length; i++) {
        print(data.keys.elementAt(i));
        print(data.values.elementAt(i));
      }
      print(data.toString());
    },
    onError: (e) => print("Error getting document: $e"),
  );*/
  var data = null;
  db.collection("schedule_timeline").get().then(
        (res) {
          data = List<String>.from(res.docs.elementAt(1).data().values.toList());
          print(data);
          print("gay");
        },
    onError: (e) => print("Error completing: $e"),
  );

  for (int i = 0; i < data!.length; i++) {
    print("GAY");
    print(data!.keys.elementAt(i));
    print(data!.values.elementAt(i));
  }
}
