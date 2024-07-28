// 로딩 뷰
import 'package:flutter/material.dart';
import 'package:sample_project/Constant/Constant.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "유저 정보를 가져오는 중입니다!",
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
