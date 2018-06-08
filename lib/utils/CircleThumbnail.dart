import 'package:flutter/material.dart';

class CircleThumbnail extends StatelessWidget {

  String url;

  CircleThumbnail(this.url);

  @override
  Widget build(BuildContext context) {
    return _buildThumbNail();
  }

  Widget _buildThumbNail() {
    return new Container(
      width: 50.0,
      height: 50.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        border: new Border.all(color: Colors.white30),
      ),

      margin: const EdgeInsets.only(top: 5.0, left: 5.0, right: 16.0),
      padding: const EdgeInsets.all(3.0),
      child: new ClipOval(
        child: new Image.network(url),
      ),
    );
  }

}