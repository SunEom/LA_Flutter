import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Components/top_bar.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Screen/Components/loading_view.dart';
import 'package:sample_project/Screen/Detail/Components/armory_sibling_tab.dart';
import 'package:sample_project/Screen/Detail/Components/character_not_found_view.dart';
import 'package:sample_project/Screen/Detail/Components/collectible_tab.dart';
import 'package:sample_project/Screen/Detail/Components/profile_container.dart';
import 'package:sample_project/Screen/Detail/Components/skill_tab.dart';
import 'package:sample_project/Screen/Detail/Components/tab_button.dart';
import 'package:sample_project/Screen/Detail/detail_view_model.dart';
import 'package:sample_project/Screen/Detail/Components/main_tab.dart';

class DetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DetailViewModel>(context);

    if (viewModel.alertData != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(viewModel.alertData!),
          ),
        );
        viewModel.resetAlertData();
      });
    }

    Widget selectedTabView() {
      switch (viewModel.selectedTab) {
        case DetailViewTab.main:
          return MainInfoContents();

        case DetailViewTab.skill:
          return SkillContents();

        case DetailViewTab.armory:
          return ArmorySiblingContents();

        case DetailViewTab.collectibles:
          return CollectibleTab();

        default:
          return Text(
            viewModel.selectedTab.displayName,
            style: TextStyle(
                color: K.appColor.white,
                fontSize: 20,
                fontWeight: K.appFont.heavy),
          );
      }
    }

    final ScrollController scrollController = ScrollController();

    return RefreshIndicator(
        onRefresh: viewModel.reloadData,
        child: Scaffold(
          appBar: TopBar(title: "캐릭터 정보"),
          body: viewModel.isLoading
              ? const LoadingView(
                  title: "유저 정보를 가져오는 중입니다!",
                )
              : PrimaryScrollController(
                  controller: scrollController,
                  child: Center(
                    child: viewModel.info != null
                        ? Padding(
                            padding: const EdgeInsets.all(20),
                            child: ListView(
                              controller: scrollController,
                              children: [
                                ProfileContents(),
                                const SizedBox(
                                  height: 10,
                                ),

                                // 탭 버튼
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: DetailViewTab.defaultOrder
                                      .map((tab) => TabButton(
                                            tab: tab,
                                          ))
                                      .toList(),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),

                                // 탭에 따라 변경되는 화면
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 150),
                                  transitionBuilder: (widget, animation) {
                                    const curve = Curves.easeInOut;
                                    var tween =
                                        Tween<double>(begin: 0.0, end: 1.0)
                                            .chain(CurveTween(curve: curve));
                                    var opacityAnimation =
                                        animation.drive(tween);
                                    return FadeTransition(
                                        opacity: opacityAnimation,
                                        child: widget);
                                  },
                                  child: selectedTabView(),
                                )
                              ],
                            ),
                          )
                        : CharacterNotFoundView(
                            nickname: viewModel.nickname,
                          ), // 캐릭터를 찾을 수 없음
                  )),
          backgroundColor: K.appColor.mainBackgroundColor,
        ));
  }
}
