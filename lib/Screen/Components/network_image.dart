import 'package:flutter/material.dart';
import 'package:sample_project/Constant/Constant.dart';

class NImage extends StatelessWidget {
  final String url;
  final double? width;

  const NImage({required this.url, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Image.network(
        url,
        width: width,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            // 로딩이 완료되었을 때 이미지(child)를 반환합니다
            return child;
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: K.appColor.white,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          }
        },
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.error,
          size: width,
          color: K.appColor.white, // 오류 시 표시될 아이콘의 색상
        ),
      ),
    );
  }
}
