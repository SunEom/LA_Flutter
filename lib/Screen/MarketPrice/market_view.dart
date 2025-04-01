import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Components/top_bar.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Model/adventrue_island.dart';
import 'package:sample_project/Model/market_item.dart';
import 'package:sample_project/Screen/Components/loading_view.dart';
import 'package:sample_project/Screen/Components/network_image.dart';
import 'package:sample_project/Screen/MarketPrice/market_view_model.dart';
import 'package:sample_project/Util/number_util.dart';

class MarketView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MarketViewModel>(context);

    return Scaffold(
        backgroundColor: K.appColor.mainBackgroundColor,
        appBar: TopBar(
          title: '아이템 시세',
        ),
        body: viewModel.isLoading
            ? const LoadingView(title: "아이템 시세를 가져오는 중입니다.\n잠시만 기다려주세요.")
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...viewModel.marketItems.map((e) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.category.name,
                                style: TextStyle(
                                    color: K.appColor.white,
                                    fontWeight: K.appFont.heavy,
                                    fontSize: 20),
                              ),
                              ...e.items.map(((e) => MarketItemComp(item: e))),
                              const SizedBox(
                                height: 30,
                              )
                            ]);
                      })
                    ],
                  ),
                ),
              ));
  }
}

class MarketItemComp extends StatelessWidget {
  final MarketItem item;

  const MarketItemComp({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          NImage(
            url: item.icon,
            width: 50,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.itemName,
                  style: TextStyle(
                      color: K.appColor.white,
                      fontWeight: K.appFont.heavy,
                      fontSize: 15)),
              Row(
                children: [
                  Text(NumberUtil.getCommaNumber(item.price),
                      style: TextStyle(
                          color: K.appColor.yellow,
                          fontWeight: K.appFont.heavy,
                          fontSize: 15)),
                  const SizedBox(
                    width: 5,
                  ),
                  NImage(url: MainRewardType.gold.icon, width: 15),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
