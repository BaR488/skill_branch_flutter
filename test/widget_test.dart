import 'dart:async';

import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/home.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/screens/feed_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
//
//  testWidgets('TypeCompare', (WidgetTester tester) async {
//    var p = Photo(
//      photoLink: kFlutterDash,
//      key: Key('Photo'),
//    );
//
//    expect(true, p.runtimeType == Photo);
//  });
//
//  testWidgets('LikeButton', (WidgetTester tester) async {
//    await tester.pumpWidget(
//        MaterialApp(home: LikeButton(likeCount: 10, isLiked: true)));
//
//    final titleFinder = find.text('10');
//    final messageFinder = find.byIcon(AppIcons.like_fill);
//
//    expect(titleFinder, findsOneWidget);
//    expect(messageFinder, findsOneWidget);
//  });
//
//  testWidgets('Photo', (WidgetTester tester) async {
//    await tester.pumpWidget(MaterialApp(
//        home: Photo(
//      photoLink: kFlutterDash,
//      key: Key('Photo'),
//    )));
//
//    final titleFinder = find.byKey(Key('Photo'));
//
//    expect(titleFinder, findsOneWidget);
//  });
//
//  testWidgets('FullScreenImage -> altDescription', (WidgetTester tester) async {
//    await tester.pumpWidget(
//      MaterialApp(
//        home: FullScreenImage(
//          altDescription: 'Test altDescription',
//          key: Key('FullScreenImage'),
//        ),
//      ),
//    );
//
//    final titleFinder = find.byKey(Key('FullScreenImage'));
//    final altDescription = find.text('Test altDescription');
//
//    expect(titleFinder, findsOneWidget);
//    expect(altDescription, findsOneWidget);
//  });
//
//  testWidgets('FullScreenImage -> userName', (WidgetTester tester) async {
//    await tester.pumpWidget(
//      MaterialApp(
//        home: FullScreenImage(
//          userName: 'kaparray',
//          key: Key('FullScreenImage'),
//        ),
//      ),
//    );
//
//    final titleFinder = find.byKey(Key('FullScreenImage'));
//    final userNameText = find.text('@kaparray');
//
//    expect(titleFinder, findsOneWidget);
//    expect(userNameText, findsOneWidget);
//  });
//
//  testWidgets('FullScreenImage -> name', (WidgetTester tester) async {
//    await tester.pumpWidget(
//      MaterialApp(
//        home: FullScreenImage(
//          name: 'Kirill Adeshchenko',
//          key: Key('FullScreenImage'),
//        ),
//      ),
//    );
//
//    final titleFinder = find.byKey(Key('FullScreenImage'));
//    final nameText = find.text('Kirill Adeshchenko');
//
//    expect(titleFinder, findsOneWidget);
//    expect(nameText, findsOneWidget);
//  });
//
//  testWidgets('FullScreenImage -> AppBar', (WidgetTester tester) async {
//    await tester.pumpWidget(
//      MaterialApp(
//        home: FullScreenImage(
//          key: Key('FullScreenImage'),
//        ),
//      ),
//    );
//
//    final titleFinder = find.byKey(Key('FullScreenImage'));
//    final backButton = find.byIcon(CupertinoIcons.back);
//    final photoTextAppBar = find.text('Photo');
//
//    expect(titleFinder, findsOneWidget);
//    expect(backButton, findsOneWidget);
//    expect(photoTextAppBar, findsOneWidget);
//  });
//
//  testWidgets('FullScreenImage -> ButtonBar', (WidgetTester tester) async {
//    await tester.pumpWidget(
//      MaterialApp(
//        home: FullScreenImage(
//          key: Key('FullScreenImage'),
//        ),
//      ),
//    );
//
//    final titleFinder = find.byKey(Key('FullScreenImage'));
//    final saveButton = find.text('Save');
//    final visitButton = find.text('Visit');
//
//    expect(titleFinder, findsOneWidget);
//    expect(saveButton, findsOneWidget);
//    expect(visitButton, findsOneWidget);
//  });
//
//  testWidgets('Hero test', (WidgetTester tester) async {
//    final GlobalKey key = GlobalKey();
//
//    await tester.pumpWidget(
//      MaterialApp(
//        key: key,
//        home: FullScreenImage(
//          photo: kFlutterDash,
//          altDescription: 'This is Flutter dash. I love him :)',
//          userName: 'kaparray',
//          name: 'Kirill Adeshchenko',
//          userPhoto: 'https://skill-branch.ru/img/speakers/Adechenko.jpg',
//          heroTag: 'tag',
//        ),
//      ),
//    );
//
//    final Hero topModalBarrier = tester.widget<Hero>(
//      find.byType(Hero),
//    );
//
//    expect(topModalBarrier.tag, 'tag');
//    expect(true, topModalBarrier.child.runtimeType == Photo);
//  });
//
//  testWidgets('AnimatedBuilder', (WidgetTester tester) async {
//    final GlobalKey keyUserAvatar = GlobalKey();
//
//    await tester.pumpWidget(
//      MaterialApp(
//        key: keyUserAvatar,
//        home: FullScreenImage(
//          photo: kFlutterDash,
//          altDescription: 'This is Flutter dash. I love him :)',
//          userName: 'kaparray',
//          name: 'Kirill Adeshchenko',
//          userPhoto: 'https://skill-branch.ru/img/speakers/Adechenko.jpg',
//          heroTag: 'tag',
//        ),
//      ),
//    );
//
//    await tester.pump(const Duration(milliseconds: 300));
//    double oneFifth = _getOpacity(keyUserAvatar, tester, false);
//    expect(0.7, (oneFifth * 10).roundToDouble() / 10);
//
//    await tester.pump(const Duration(milliseconds: 800));
//    double full = _getOpacity(keyUserAvatar, tester, false);
//    expect(1.0, (full * 10).roundToDouble() / 10);
//
//    final keyName = GlobalKey();
//
//    await tester.pumpWidget(
//      MaterialApp(
//        key: keyName,
//        home: FullScreenImage(
//          photo: kFlutterDash,
//          altDescription: 'This is Flutter dash. I love him :)',
//          userName: 'kaparray',
//          name: 'Kirill Adeshchenko',
//          userPhoto: 'https://skill-branch.ru/img/speakers/Adechenko.jpg',
//          heroTag: 'tag',
//        ),
//      ),
//    );
//
//    await tester.pump(const Duration(milliseconds: 800));
//    double test1 = _getOpacity(keyName, tester, true);
//    expect(0.1, (test1 * 10).roundToDouble() / 10);
//
//    await tester.pump(const Duration(milliseconds: 1200));
//    double test2 = _getOpacity(keyName, tester, true);
//    expect(1.0, (test2 * 10).roundToDouble() / 10);
//  });

  testWidgets('module1', (WidgetTester tester) async {
    TextTheme textTheme = buildAppTextTheme();

    expect(
      textTheme.headline6,
      TextStyle(
        fontSize: 12,
        height: 20 / 12,
        letterSpacing: -0.24,
        fontWeight: FontWeight.w300,
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
      ),
    );

    expect(
        textTheme.headline5,
        TextStyle(
          fontSize: 13,
          height: 18 / 13,
          fontWeight: FontWeight.normal,
          color: AppColors.black,
          fontStyle: FontStyle.normal,
          fontFamily: 'Roboto',
        ));

    expect(
      textTheme.headline4,
      TextStyle(
        fontSize: 14,
        height: 16 / 14,
        color: AppColors.alto,
        fontWeight: FontWeight.w600,
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        letterSpacing: 0.75,
      ),
    );

    expect(
      textTheme.headline3,
      TextStyle(
        fontSize: 14,
        height: 20 / 14,
        color: AppColors.manatee,
        fontWeight: FontWeight.normal,
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        letterSpacing: 0.25,
      ),
    );

    expect(
      textTheme.headline2,
      TextStyle(
        fontSize: 17,
        height: 22 / 17,
        fontFamily: 'Roboto',
        color: AppColors.black,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        letterSpacing: -0.41,
      ),
    );

    expect(
      textTheme.headline1,
      TextStyle(
        fontSize: 18,
        height: 23 / 18,
        color: AppColors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
      ),
    );
  });

  testWidgets('module2', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          textTheme: buildAppTextTheme(),
        ),
        home: FullScreenImage(
          photo: kFlutterDash,
          altDescription: 'This is Flutter dash. I love him :)',
          userName: 'kaparray',
          name: 'Kirill Adeshchenko',
          userPhoto: 'https://skill-branch.ru/img/speakers/Adechenko.jpg',
          heroTag: 'tag',
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(seconds: 2));

    await tester.tap(find.widgetWithIcon(IconButton, Icons.more_vert));

    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('adult'.toUpperCase()), findsOneWidget);
    expect(find.text('spam'.toUpperCase()), findsOneWidget);
    expect(find.text('hate'.toUpperCase()), findsOneWidget);
  });

  testWidgets('module3', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          textTheme: buildAppTextTheme(),
        ),
        home: FullScreenImage(
          photo: kFlutterDash,
          altDescription: 'This is Flutter dash. I love him :)',
          userName: 'kaparray',
          name: 'Kirill Adeshchenko',
          userPhoto: 'https://skill-branch.ru/img/speakers/Adechenko.jpg',
          heroTag: 'tag',
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(seconds: 2));

    await tester.tap(find.widgetWithText(GestureDetector, 'Save'));

    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Download'), findsOneWidget);
    expect(find.text('Close'), findsOneWidget);
  });

  testWidgets('module4', (WidgetTester tester) async {
    StreamController<ConnectivityResult> controller =
        StreamController<ConnectivityResult>();

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(textTheme: buildAppTextTheme()),
        home: Home(controller.stream),
      ),
    );
    await tester.pump();

    controller.add(ConnectivityResult.none);
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('No internet connection'), findsOneWidget);

    controller.add(ConnectivityResult.wifi);
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('No internet connection'), findsNothing);

    controller.add(ConnectivityResult.none);
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('No internet connection'), findsOneWidget);

    controller.add(ConnectivityResult.mobile);
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('No internet connection'), findsNothing);

    controller.add(ConnectivityResult.none);
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('No internet connection'), findsOneWidget);

    controller.close();
  });
}

double _getOpacity(GlobalKey key, WidgetTester tester, bool isLast) {
  bool isFadeTransition = false;

  Finder finder = find.byType(Opacity);

  if (tester.widgetList(finder).toList().isEmpty) {
    finder = find.byType(FadeTransition);
    isFadeTransition = true;
  }

  if (isFadeTransition) {
    final FadeTransition transition =
        tester.widgetList(finder).toList()[isLast ? 4 : 2];
    return transition.opacity.value;
  } else {
    final Opacity transition =
        tester.widgetList(finder).toList()[isLast ? 1 : 0];
    return transition.opacity;
  }
}
