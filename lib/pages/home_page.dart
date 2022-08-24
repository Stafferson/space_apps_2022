import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fizmat_app_flutter/pages/schedule_page.dart';
import 'package:fizmat_app_flutter/pages/discover_page.dart';
import 'package:fizmat_app_flutter/icons.dart';
import 'package:fizmat_app_flutter/pages/profile_page.dart';
import 'package:fizmat_app_flutter/widgets/svg_asset.dart';

import '../fizmat_utils/animated_indexed_stack.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    DiscoverPage(),
    SchedulePage(),
    ProfilePage()
  ];

  List<SvgAsset> icons = [
    const SvgAsset(assetName: AssetName.discover),
    const SvgAsset(assetName: AssetName.schedule),
    const SvgAsset(assetName: AssetName.profile),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          enableFeedback: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const SvgAsset(assetName: AssetName.discover),
              label: '',
              tooltip: 'Discover',
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xff4A80F0).withOpacity(0.3),
                        offset: const Offset(0, 4),
                        blurRadius: 20),
                  ],
                ),
                child: const SvgAsset(
                    assetName: AssetName.discover, color: Color(0xff4A80F0)),
              ),
            ),
            BottomNavigationBarItem(
              icon: const SvgAsset(assetName: AssetName.schedule),
              label: '',
              tooltip: '',
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xff4A80F0).withOpacity(0.3),
                        offset: const Offset(0, 4),
                        blurRadius: 20),
                  ],
                ),
                child: const SvgAsset(
                  assetName: AssetName.schedule,
                  color: Color(0xff4A80F0),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: const SvgAsset(assetName: AssetName.profile),
              label: '',
              tooltip: 'Profile',
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xff4A80F0).withOpacity(0.3),
                        offset: const Offset(0, 4),
                        blurRadius: 20),
                  ],
                ),
                child: const SvgAsset(
                  assetName: AssetName.profile,
                  color: Color(0xff4A80F0),
                ),
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
          backgroundColor: const Color(0xff1C2031),
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedIndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 56,
        color: Color(0xFF1C2031),
        backgroundColor: Color(0xff121421),
        items: icons,
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
    );
  }
}
