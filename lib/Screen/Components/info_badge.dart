import 'package:flutter/material.dart';
import 'package:sample_project/Constant/Constant.dart';

class InfoBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.info_outline,
      color: K.appColor.lightGray,
      size: 22,
    );
  }
}
