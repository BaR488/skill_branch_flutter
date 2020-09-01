import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/photo.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'photo_screen.dart';

const String kFlutterDash =
    'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() {
    return _FeedState();
  }
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                _buildItem('This is Flutter Dash!!! I love him ;) ',
                    'Name Name', 'userName', index),
                Divider(
                  thickness: 2,
                  color: AppColors.mercury,
                )
              ],
            );
          }),
    );
  }

  Widget _buildItem(
      String description, String name, String userName, num index) {
    final String heroTag = 'photo-id-$index';
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FullScreenImage(
                    altDescription: description,
                    name: name,
                    userName: userName,
                    userPhoto: kFlutterDash,
                    photo: kFlutterDash,
                    heroTag: heroTag)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: heroTag,
            child: Photo(
              photoLink: kFlutterDash,
            ),
          ),
          _buildPhotoMeta(name, userName),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.h3,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPhotoMeta(String name, String userName) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            UserAvatar(
              avatarLink: kFlutterDash,
            ),
            SizedBox(
              width: 6,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: AppStyles.h2Black,
                ),
                Text(
                  userName,
                  style: AppStyles.h5Black.copyWith(color: AppColors.manatee),
                )
              ],
            )
          ],
        ),
        LikeButton(likeCount: 10, isLiked: true)
      ]),
    );
  }
}
