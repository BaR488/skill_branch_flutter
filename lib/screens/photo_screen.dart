import 'package:flutter/widgets.dart';

class FullScreenImage extends StatefulWidget {
  final String altDescription;
  final String userName;
  final String name;

  const FullScreenImage({Key key, this.altDescription, this.userName, this.name}) : super(key: key);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
