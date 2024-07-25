import 'package:flutter/material.dart';
import 'package:sample_project/Constant/Constant.dart';

AppBar TopBar() {
  return AppBar(
    title: Text(K.appData.AppName),
    backgroundColor: K.appColor.mainBackgroundColor,
    foregroundColor: K.appColor.white,
  );
}
