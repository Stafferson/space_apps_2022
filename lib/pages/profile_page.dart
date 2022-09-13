import 'package:animate_icons/animate_icons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../icons.dart';
import '../widgets/svg_asset.dart';

AnimateIconController _controller = AnimateIconController();
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121421),
      //appBar: appbar_builder(),
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
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.w,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${user!.email}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.w
                        ),
                      ),
                      const SizedBox(height: 32),
                      //profile_buttons_builder(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton.extended(
                            onPressed: () => copy_email(),
                            heroTag: 'message',
                            elevation: 0,
                            backgroundColor: Colors.white,
                            label: const Text("Copy my email"),
                            icon: const Icon(Icons.local_post_office_outlined),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          FloatingActionButton.extended(
                            onPressed: () => copy_profile_photo_url(),
                            heroTag: 'message',
                            elevation: 0,
                            backgroundColor: Colors.white,
                            label: const Text("Copy my profile photo Url"),
                            icon: const Icon(Icons.link_rounded),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      //const _ProfileInfoRow()
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

  AppBar appbar_builder() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      title: Padding(
        padding: EdgeInsets.only(
          left: 14.w,
          top: 16.h,
        ),
        child: Hero(
          tag: "profile",
          child: Text("Profile",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 34.w,
                  fontWeight: FontWeight.bold
              )
          ),
        ),
      ),
      actions: <Widget>[
        /*Padding(
          padding: EdgeInsets.only(
            top: 16.h,
          ),
          child: IconButton(
            icon: Icon(
              Icons.search_rounded,
              size: 30.w,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
              //ScaffoldMessenger.of(context).showSnackBar(
              //    const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ),*/
        /*Padding(
          padding: EdgeInsets.only(
            top: 16.h,
          ),
          child: IconButton(
            icon: Icon(
                Icons.refresh_rounded,
                size: 30.w,
            ),
            tooltip: 'Refresh current page',
            onPressed: () {
              setState(() {});
              /*Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Next page'),
                    ),
                    body: info_page_builder(),
                  );
                },
              ));*/
            },
          ),
        ),*/

        Padding(
          padding: EdgeInsets.only(
            top: 16.h,
          ),
          child: AnimateIcons(
            startIcon: Icons.refresh_rounded,
            endIcon: Icons.refresh_rounded,
            size: 28.0,
            // add this tooltip for the start icon
            startTooltip: 'Icons.add_circle',
            // add this tooltip for the end icon
            endTooltip: 'Icons.add_circle_outline',
            controller: _controller,
            onStartIconPress: () {
              setState(() {});
              return true;
            },
            onEndIconPress: () {
              setState(() {});
              return true;
            },
            startIconColor: Colors.white,
            endIconColor: Colors.white,
            duration: Duration(milliseconds: 500),
            clockwise: true,
          ),
        ),
      ],
      backgroundColor: Color(0xff121421),
      elevation: 0,
    );
  }

  void copy_email() {
    Clipboard.setData(ClipboardData(text: user!.email.toString()));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Copied to the Clipboard!"),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      duration: Duration(milliseconds: 500),
    ));
  }

  void copy_profile_photo_url() {
    Clipboard.setData(ClipboardData(text: user!.photoURL!.replaceAll("s96-c", "s360-c").toString()));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Copied to the Clipboard!"),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      duration: Duration(milliseconds: 500),
    ));
  }

  Widget profile_buttons_builder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /*FloatingActionButton.extended(
        onPressed: () {},
        heroTag: 'follow',
        elevation: 0,
        backgroundColor: Colors.white,
        label: const Text("Follow"),
        icon: const Icon(Icons.person_add_alt_1),
      ),
      const SizedBox(width: 16.0),*/
        FloatingActionButton.extended(
          onPressed: () => copy_email(),
          heroTag: 'message',
          elevation: 0,
          backgroundColor: Colors.white,
          label: const Text("Copy my email"),
          icon: const Icon(Icons.local_post_office_outlined),
        ),
        const SizedBox(
          height: 16,
        ),
        FloatingActionButton.extended(
          onPressed: () => copy_profile_photo_url(),
          heroTag: 'message',
          elevation: 0,
          backgroundColor: Colors.white,
          label: const Text("Copy my profile photo Url"),
          icon: const Icon(Icons.link_rounded),
        ),
      ],
    );
  }
}


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
        /*Container(
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
                const SizedBox(width: 60, height: 10),
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
                ),
              ],
            ),
          ),
        ),*/
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          user!.photoURL!.replaceAll("s96-c", "s360-c").toString()
                        )
                    ),
                  ),
                ),
                /*Positioned(
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
                ),*/
                CachedNetworkImage(
                  imageUrl: user!.photoURL!.replaceAll("s96-c", "s360-c").toString(),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
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
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
