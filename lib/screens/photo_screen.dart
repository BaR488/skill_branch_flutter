import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery_saver/gallery_saver.dart';

class FullScreenImageArguments {
  FullScreenImageArguments(
      {this.routeSettings,
      this.altDescription,
      this.userName,
      this.name,
      this.photo,
      this.userPhoto,
      this.heroTag,
      this.key});

  final String altDescription;
  final String userName;
  final String name;
  final String photo;
  final String userPhoto;
  final String heroTag;
  final Key key;

  final RouteSettings routeSettings;
}

class FullScreenImage extends StatefulWidget {
  final String altDescription;
  final String userName;
  final String name;
  final String photo;
  final String userPhoto;
  final String heroTag;

  const FullScreenImage(
      {Key key,
      this.photo = '',
      this.userPhoto = '',
      this.altDescription = '',
      this.userName = '',
      this.name = '',
      this.heroTag = 'defaultPhotoHeroTag'})
      : super(key: key);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage>
    with TickerProviderStateMixin {
  String altDescription;
  String userName;
  String name;
  String photo;
  String avatar;
  String heroTag;

  AnimationController _controller;

  Animation<double> avatarOpacity;
  Animation<double> userNameOpacity;

  @override
  void initState() {
    super.initState();
    this.name = widget.name;
    this.userName = widget.userName;
    this.altDescription = widget.altDescription;
    this.photo = widget.photo;
    this.avatar = widget.userPhoto;
    this.heroTag = widget.heroTag;

    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);

    avatarOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          .0,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );

    userNameOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.5,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    String title = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: AppColors.grayChateau),
            onPressed: () => {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                      height: MediaQuery.of(context).size.height * (0.4),
                      child: ClaimBottomSheet());
                },
              )
            },
          ),
        ],
        title: Text(
          'Photo',
          style: Theme.of(context)
              .textTheme
              .headline2
              .copyWith(fontWeight: FontWeight.w500),
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: AppColors.grayChateau),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: heroTag,
            child: Photo(
              photoLink: photo,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              altDescription,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          _buildPhotoMeta(),
          _buildPhotoControls()
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPhotoMeta() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Opacity(
              opacity: avatarOpacity.value,
              child: UserAvatar(
                avatarLink: avatar,
              ),
            ),
            SizedBox(
              width: 6,
            ),
            Opacity(
              opacity: userNameOpacity.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    '@$userName',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: AppColors.manatee),
                  )
                ],
              ),
            )
          ]);
        },
      ),
    );
  }

  Future<bool> _saveNetworkImage(path) async {
    return GallerySaver.saveImage(path);
  }

  Widget _buildPhotoControls() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
            child: Container(
              child: LikeButton(
                likeCount: 10,
                isLiked: true,
              ),
              height: 36,
              width: 105,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
            child: _buildButton('Save', () {
              print('save');
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Download photos'),
                    content: Text('Are you sure you want to download a photo?'),
                    actions: [
                      FlatButton(
                          onPressed: () {
                            _saveNetworkImage(photo)
                                .then((bool saved) => print(
                                    saved ? 'Image saved' : 'Image NOT saved'))
                                .catchError((e) => print('Image save ERROR'))
                                .whenComplete(
                                    () => Navigator.of(context).pop());
                          },
                          child: Text('Download')),
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'))
                    ],
                  );
                },
              );
            }),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
            child: _buildButton('Visit', () async {
              print('visit');
            }),
          ),
        ),
      ]),
    );
  }

  Widget _buildButton(String name, VoidCallback callback) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        child: Container(
          color: AppColors.dodgerBlue,
          child: Center(
              child: Text(
            name,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: AppColors.white),
          )),
          height: 36,
          width: 105,
        ),
      ),
    );
  }
}
