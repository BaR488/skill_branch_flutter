import 'dart:io';

import 'package:FlutterGalleryApp/res/res.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:FlutterGalleryApp/screens/home.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(Connectivity().onConnectivityChanged),
      theme: ThemeData(
        textTheme: buildAppTextTheme(),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Column(
                  children: [
                    Text('404'),
                    Text('Page not found'),
                  ],
                ),
              ),
            );
          },
        );
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/fullScreenImage') {
          FullScreenImageArguments args =
              settings.arguments as FullScreenImageArguments;
          final route = FullScreenImage(
            photo: args.photo,
            heroTag: args.heroTag,
            key: args.key,
            userName: args.userName,
            name: args.name,
            altDescription: args.altDescription,
            userPhoto: args.userPhoto,
          );

          if (Platform.isAndroid) {
            return MaterialPageRoute(
                builder: (context) {
                  return route;
                },
                settings: args.routeSettings);
          } else if (Platform.isIOS) {
            return CupertinoPageRoute(
                builder: (context) {
                  return route;
                },
                settings: args.routeSettings);
          }
        }
      },
      debugShowCheckedModeBanner: false,
    );
  }
}