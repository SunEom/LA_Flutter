import 'package:flutter/material.dart';
import 'package:sample_project/Constant/constant.dart';

AppBar TopBar() {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    title: Text(
      K.appData.AppName,
      style: TextStyle(
          color: K.appColor.white, fontSize: 24, fontWeight: K.appFont.heavy),
    ),
    backgroundColor: K.appColor.mainBackgroundColor,
    foregroundColor: K.appColor.white,
  );
}
