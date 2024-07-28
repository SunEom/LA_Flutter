//Tab Button
import 'package:flutter/material.dart';
import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Screen/Detail/detail_view_model.dart';

class TabButton extends StatelessWidget {
  final DetailViewModel viewModel;
  final DetailViewTab tab;

  const TabButton({required this.viewModel, required this.tab});

  bool get isSelectedTab => viewModel.selectedTab == tab;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), // 애니메이션 지속 시간 설정
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelectedTab ? K.appColor.white : K.appColor.lightGray,
            width: 1.2,
          ),
        ),
      ),
      child: TextButton(
        onPressed: () {
          viewModel.changeTab(tab);
        },
        style: const ButtonStyle(
          backgroundColor: WidgetStateColor.transparent,
          overlayColor: WidgetStateColor.transparent,
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300), // 애니메이션 지속 시간 설정
          style: TextStyle(
              color: isSelectedTab ? K.appColor.white : K.appColor.lightGray,
              fontSize: 15,
              fontWeight: K.appFont.heavy),
          child: Text(tab.displayName),
        ),
      ),
    );
  }
}
