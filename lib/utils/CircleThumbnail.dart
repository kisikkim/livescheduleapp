import 'package:flutter/material.dart';

class CircleThumbnail extends StatelessWidget {

  String url;
  double size;

  CircleThumbnail(this.url, this.size);

  @override
  Widget build(BuildContext context) {
    return _buildThumbNail();
  }

  Widget _buildThumbNail() {
    return new Container(
      width: size,
      height: size,
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