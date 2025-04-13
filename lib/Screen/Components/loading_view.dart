// 로딩 뷰
import 'package:flutter/material.dart';
import 'package:sample_project/Constant/constant.dart';

class LoadingView extends StatelessWidget {
  final String title;

  const LoadingView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(K.appColor.deepPurple),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: K.appColor.white,
                fontSize: 14,
                fontWeight: K.appFont.heavy),
          ),
        ],
      ),
    );
  }
}
