// 캐릭터를 찾을 수 없음
import 'package:flutter/material.dart';
import 'package:sample_project/Constant/Constant.dart';

class CharacterNotFoundView extends StatelessWidget {
  final String nickname;
  const CharacterNotFoundView({required this.nickname});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            nickname,
            style: TextStyle(
                color: K.appColor.white,
                fontSize: 14,
                fontWeight: K.appFont.heavy),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            "해당 유저가 존재하지 않거나",
            style: TextStyle(
                color: K.appColor.white,
                fontSize: 14,
                fontWeight: K.appFont.bold),
          ),
          Text(
            "오랜시간 접속하지 않은 유저입니다.",
            style: TextStyle(
                color: K.appColor.white,
                fontSize: 14,
                fontWeight: K.appFont.bold),
          ),
        ],
      ),
    );
  }
}
