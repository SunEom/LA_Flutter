import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Components/top_bar.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Screen/Home/Components/adventure_island_view.dart';
import 'package:sample_project/Screen/Home/Components/event_container.dart';
import 'package:sample_project/Screen/Home/Components/notice_container.dart';
import 'package:sample_project/Screen/Home/Components/search_bar.dart';
import 'package:sample_project/Screen/Home/home_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: TopBar(),
      body: RefreshIndicator(
        onRefresh: viewModel.reloadData,
        child: ColoredBox(
          color: K.appColor.mainBackgroundColor,
          child: Center(
              child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: SearchContainer(),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: AdventureIslandContainer(),
              ),
              EventContainer(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: NoticeContainer(),
              )
            ],
          )),
        ),
      ),
    );
  }
}
