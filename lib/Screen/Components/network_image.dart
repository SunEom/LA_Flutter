import 'package:flutter/material.dart';

class NImage extends StatelessWidget {
  final String url;
  final double width;

  const NImage({required this.url, required this.width});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      errorBuilder: (context, error, stackTrace) => Icon(
        Icons.error,
        size: width,
      ),
    );
  }
}
