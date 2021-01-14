import 'dart:async';

import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/bottom_nav_bar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';
import 'feed_screen.dart';

class Home extends StatefulWidget {
  @override
  Home(this.onConnectivityChanged);

  final Stream<ConnectivityResult> onConnectivityChanged;

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();

  StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    subscription = widget.onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.wifi:
          ConnectivityOverlay().removeOverlay(context);
          break;
        case ConnectivityResult.mobile:
          ConnectivityOverlay().removeOverlay(context);
          break;
        case ConnectivityResult.none:
          ConnectivityOverlay().showOverlay(context, Text('No internet connection'));
          break;
      }
    });
  }

  @override
  void dispose() {

    subscription.cancel();
    super.dispose();
  }

  List<Widget> pages = [
    Feed(
      key: PageStorageKey('FeedPage'),
    ),
    Container(),
    Container()
  ];

  final List<BottomNavyBarItem> _tabs = [
    BottomNavyBarItem(
        asset: AppIcons.home,
        title: Text('Feed'),
        activeColor: AppColors.dodgerBlue,
        inactiveColor: AppColors.manatee),
    BottomNavyBarItem(
        asset: AppIcons.home,
        title: Text('Search'),
        activeColor: AppColors.dodgerBlue,
        inactiveColor: AppColors.manatee),
    BottomNavyBarItem(
        asset: AppIcons.home,
        title: Text('User'),
        activeColor: AppColors.dodgerBlue,
        inactiveColor: AppColors.manatee)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavBar(
        itemCornerRadius: 8,
        curve: Curves.ease,
        items: _tabs,
        currentTab: currentTab,
        onItemSelected: (int index) async {
          if (index == 1) {
            var value = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    body: Column(
                      children: [
                        FlatButton(
                            onPressed: () {
                              Navigator.pop(context, 123);
                            },
                            child: Text('Click me'))
                      ],
                    ),
                  ),
                ));
            print(value);
          } else {
            setState(() {
              currentTab = index;
            });
          }
        },
      ),
      body: PageStorage(
        child: pages[currentTab],
        bucket: bucket,
      ),
    );
  }
}