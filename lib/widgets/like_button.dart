import 'package:FlutterGalleryApp/res/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LikeButton extends StatefulWidget {
  final int likeCount;
  final bool isLiked;

  const LikeButton({Key key, this.likeCount, this.isLiked});

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked;
  int likeCount;

  @override
  void initState() {
    super.initState();

    isLiked = widget.isLiked;
    likeCount = widget.likeCount;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          isLiked = !isLiked;
          if(isLiked) {
            likeCount++;
          } else {
            likeCount--;
          }
          print(likeCount);
        });
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(this.isLiked ? AppIcons.like_fill : AppIcons.like),
              SizedBox(
                width: 4.21,
              ),
              Text(likeCount.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      height: 16 / 14))
            ],
          ),
        ),
      ),
    );
  }
}
