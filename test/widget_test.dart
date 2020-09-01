import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/screens/feed_screen.dart';
import '../lib/screens/photo_screen.dart';
import '../lib/widgets/widgets.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('TypeCompare', (WidgetTester tester) async {
    var p = Photo(
      photoLink: kFlutterDash,
      key: Key('Photo'),
    );

    expect(true, p.runtimeType == Photo);
  });

  testWidgets('LikeButton', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: LikeButton(likeCount: 10, isLiked: true)));

    final titleFinder = find.text('10');
    final messageFinder = find.byIcon(AppIcons.like_fill);

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });

  testWidgets('Photo', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Photo(
      photoLink: kFlutterDash,
      key: Key('Photo'),
    )));

    final titleFinder = find.byKey(Key('Photo'));

    expect(titleFinder, findsOneWidget);
  });

  testWidgets('FullScreenImage -> altDescription', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FullScreenImage(
          altDescription: 'Test altDescription',
          key: Key('FullScreenImage'),
        ),
      ),
    );

    final titleFinder = find.byKey(Key('FullScreenImage'));
    final altDescription = find.text('Test altDescription');

    expect(titleFinder, findsOneWidget);
    expect(altDescription, findsOneWidget);
  });

  testWidgets('FullScreenImage -> userName', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FullScreenImage(
          userName: 'kaparray',
          key: Key('FullScreenImage'),
        ),
      ),
    );

    final titleFinder = find.byKey(Key('FullScreenImage'));
    final userNameText = find.text('@kaparray');

    expect(titleFinder, findsOneWidget);
    expect(userNameText, findsOneWidget);
  });

  testWidgets('FullScreenImage -> name', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FullScreenImage(
          name: 'Kirill Adeshchenko',
          key: Key('FullScreenImage'),
        ),
      ),
    );

    final titleFinder = find.byKey(Key('FullScreenImage'));
    final nameText = find.text('Kirill Adeshchenko');

    expect(titleFinder, findsOneWidget);
    expect(nameText, findsOneWidget);
  });

  testWidgets('FullScreenImage -> AppBar', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FullScreenImage(
          key: Key('FullScreenImage'),
        ),
      ),
    );

    final titleFinder = find.byKey(Key('FullScreenImage'));
    final backButton = find.byIcon(CupertinoIcons.back);
    final photoTextAppBar = find.text('Photo');

    expect(titleFinder, findsOneWidget);
    expect(backButton, findsOneWidget);
    expect(photoTextAppBar, findsOneWidget);
  });

  testWidgets('FullScreenImage -> ButtonBar', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FullScreenImage(
          key: Key('FullScreenImage'),
        ),
      ),
    );

    final titleFinder = find.byKey(Key('FullScreenImage'));
    final saveButton = find.text('Save');
    final visitButton = find.text('Visit');

    expect(titleFinder, findsOneWidget);
    expect(saveButton, findsOneWidget);
    expect(visitButton, findsOneWidget);
  });

  testWidgets('Hero test', (WidgetTester tester) async {
    final GlobalKey key = GlobalKey();

    await tester.pumpWidget(
      MaterialApp(
        key: key,
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

    final Hero topModalBarrier = tester.widget<Hero>(
      find.byType(Hero),
    );

    expect(topModalBarrier.tag, 'tag');
    expect(true, topModalBarrier.child.runtimeType == Photo);
  });

  testWidgets('AnimatedBuilder', (WidgetTester tester) async {
    final GlobalKey keyUserAvatar = GlobalKey();

    await tester.pumpWidget(
      MaterialApp(
        key: keyUserAvatar,
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

    await tester.pump(const Duration(milliseconds: 300));
    double oneFifth = _getOpacity(keyUserAvatar, tester, false);
    expect(0.7, (oneFifth * 10).roundToDouble() / 10);

    await tester.pump(const Duration(milliseconds: 800));
    double full = _getOpacity(keyUserAvatar, tester, false);
    expect(1.0, (full * 10).roundToDouble() / 10);

    final keyName = GlobalKey();

    await tester.pumpWidget(
      MaterialApp(
        key: keyName,
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

    await tester.pump(const Duration(milliseconds: 800));
    double test1 = _getOpacity(keyName, tester, true);
    expect(0.1, (test1 * 10).roundToDouble() / 10);

    await tester.pump(const Duration(milliseconds: 1200));
    double test2 = _getOpacity(keyName, tester, true);
    expect(1.0, (test2 * 10).roundToDouble() / 10);
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
    final FadeTransition transition = tester.widgetList(finder).toList()[isLast ? 4 : 2];
    return transition.opacity.value;
  } else {
    final Opacity transition = tester.widgetList(finder).toList()[isLast ? 1 : 0];
    return transition.opacity;
  }
}
