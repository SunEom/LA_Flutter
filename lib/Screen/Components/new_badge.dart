import 'package:flutter/material.dart';
import 'package:sample_project/Constant/Constant.dart';

class NewBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: K.appColor.red, // 배경 색상
            shape: BoxShape.circle, // 원형
          ),
        ),
        Text(
          "N",
          style: TextStyle(
            color: K.appColor.white, // 텍스트 색상
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
