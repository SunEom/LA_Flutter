import 'package:flutter/material.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Screen/Components/network_image.dart';

class CharacterImageView extends StatelessWidget {
  final String className;

  const CharacterImageView({super.key, required this.className});

  @override
  Widget build(BuildContext context) {
    return // 이미지 위젯
        // 사용 예시
        FutureBuilder<String>(
      future: K.appImage.getClassImage(className),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 40,
            height: 40,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return NImage(
          url: snapshot.data ?? "",
          width: 40,
        );
      },
    );
  }
}
