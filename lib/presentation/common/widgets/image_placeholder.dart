import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  final double width;
  final double height;
  final IconData icon;
  final Color color;

  const ImagePlaceholder({
    super.key,
    required this.width,
    required this.height,
    this.icon = Icons.movie,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: Icon(
        icon,
        color: color,
        size: 30,
      ),
    );
  }
}