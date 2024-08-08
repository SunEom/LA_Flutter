import 'package:flutter/material.dart';
import 'package:sample_project/Constant/Constant.dart';

class NewBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
          color: K.appColor.red, borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.only(left: 2.5),
        child: Text(
          "N",
          style: TextStyle(
              color: K.appColor.white,
              fontSize: 12,
              fontWeight: K.appFont.heavy),
        ),
      ),
    );
  }
}
