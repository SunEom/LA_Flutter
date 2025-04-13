import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Components/top_bar.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Model/adventrue_island.dart';
import 'package:sample_project/Model/auction_item.dart';
import 'package:sample_project/Model/item_price.dart';
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
                    children: [_TabBarSection(), _TabViewSection()],
                  ),
                ),
              ));
  }
}

class MarketItemComp extends StatelessWidget {
  final MarketItem item;
  final MarketViewModel viewModel;

  const MarketItemComp({
    required this.item,
    required this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOpen = viewModel.openItem?.id == item.id;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              NImage(
                url: item.icon,
                width: 50,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.itemName,
                    style: TextStyle(
                      color: K.appColor.white,
                      fontWeight: K.appFont.heavy,
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        NumberUtil.getCommaNumber(item.price),
                        style: TextStyle(
                          color: K.appColor.yellow,
                          fontWeight: K.appFont.heavy,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 5),
                      NImage(url: MainRewardType.gold.icon, width: 15),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              // IconButton(
              //   onPressed: () => viewModel.onClickAccordianButton(item),
              //   icon: Icon(
              //     isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              //     color: K.appColor.white,
              //   ),
              // ),
            ],
          ),
        ),

        // 애니메이션 추가!
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: K.appColor.mainBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: K.appColor.white.withOpacity(0.2)),
              ),
              child: viewModel.isAccordianLoading
                  ? LoadingView(title: "${item.itemName}의 최근 시세를 가져오고 있습니다.")
                  : viewModel.itemPrice != null
                      ? Container(
                          height: 150,
                          child: LineChart(
                            LineChartData(
                              maxY: viewModel.getMaxPrice(),
                              minY: viewModel.getMinPrice(),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: viewModel.itemPrice!.prices
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    int idx = entry.key;
                                    ItemPriceData data = entry.value;
                                    return FlSpot(
                                        idx.toDouble(), data.avgPrice);
                                  }).toList(),
                                  isCurved: true,
                                  color: Colors.yellow,
                                  barWidth: 2,
                                  dotData: FlDotData(show: true),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                show: true,
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true, // ✅ Y축 표시
                                    reservedSize: 40,
                                    interval: 10,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.roundToDouble().toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(show: false),
                            ),
                          ),
                        )
                      : Container()),
          crossFadeState:
              isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}

class AuctionItemComp extends StatelessWidget {
  final AuctionItem item;
  final MarketViewModel viewModel;

  const AuctionItemComp({
    required this.item,
    required this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOpen = viewModel.openItem?.id == item.id;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              NImage(
                url: item.icon,
                width: 50,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.itemName,
                    style: TextStyle(
                      color: K.appColor.getGradeColor(item.grade),
                      fontWeight: K.appFont.heavy,
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        NumberUtil.getCommaNumber(item.price),
                        style: TextStyle(
                          color: K.appColor.yellow,
                          fontWeight: K.appFont.heavy,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 5),
                      NImage(url: MainRewardType.gold.icon, width: 15),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              // IconButton(
              //   onPressed: () => viewModel.onClickAccordianButton(item),
              //   icon: Icon(
              //     isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              //     color: K.appColor.white,
              //   ),
              // ),
            ],
          ),
        ),

        // 애니메이션 추가!
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: K.appColor.mainBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: K.appColor.white.withOpacity(0.2)),
              ),
              child: viewModel.isAccordianLoading
                  ? LoadingView(title: "${item.itemName}의 최근 시세를 가져오고 있습니다.")
                  : viewModel.itemPrice != null
                      ? Container(
                          height: 150,
                          child: LineChart(
                            LineChartData(
                              maxY: viewModel.getMaxPrice(),
                              minY: viewModel.getMinPrice(),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: viewModel.itemPrice!.prices
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    int idx = entry.key;
                                    ItemPriceData data = entry.value;
                                    return FlSpot(
                                        idx.toDouble(), data.avgPrice);
                                  }).toList(),
                                  isCurved: true,
                                  color: Colors.yellow,
                                  barWidth: 2,
                                  dotData: FlDotData(show: true),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                show: true,
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true, // ✅ Y축 표시
                                    reservedSize: 40,
                                    interval: 10,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.roundToDouble().toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(show: false),
                            ),
                          ),
                        )
                      : Container()),
          crossFadeState:
              isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}

// 📌 탭 바 영역
class _TabBarSection extends StatelessWidget {
  const _TabBarSection();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MarketViewModel>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: MarketViewTab.defaultOrder.map((tab) {
        final isSelected = viewModel.currentTab == tab;
        return _TabButton(
          tab: tab,
          isSelected: isSelected,
        );
      }).toList(),
    );
  }
}

// 📌 탭 버튼
class _TabButton extends StatelessWidget {
  final MarketViewTab tab;
  final bool isSelected;

  const _TabButton({
    required this.tab,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<MarketViewModel>();

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextButton(
          onPressed: () => viewModel.changeTab(tab),
          child: Text(
            tab.displayName,
            style: TextStyle(
              color: isSelected
                  ? K.appColor.darkBlue
                  : K.appColor
                      .lightGray, // 선택된 탭은 흰색 텍스트, 선택되지 않은 탭은 어두운 회색 텍스트
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

// 📌 탭 화면 영역
class _TabViewSection extends StatelessWidget {
  const _TabViewSection();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MarketViewModel>();

    switch (viewModel.currentTab) {
      case MarketViewTab.market:
        return const _MarketScreen();
      case MarketViewTab.auction:
        return const _AuctionScreen();
      default:
        return const Center(child: Text('Unknown Tab'));
    }
  }
}

// 📌 재련재료 & 각인서 화면
class _MarketScreen extends StatelessWidget {
  const _MarketScreen();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MarketViewModel>();
    return Column(children: [
      ...viewModel.marketItems.map((e) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            e.category.name,
            style: TextStyle(
                color: K.appColor.white,
                fontWeight: K.appFont.heavy,
                fontSize: 20),
          ),
          ...e.items.map(((e) => MarketItemComp(
                item: e,
                viewModel: viewModel,
              ))),
          const SizedBox(
            height: 30,
          )
        ]);
      })
    ]);
  }
}

// 📌 보석 화면
class _AuctionScreen extends StatelessWidget {
  const _AuctionScreen();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MarketViewModel>();

    return SingleChildScrollView(
      child: Column(children: [
        ...viewModel.auctionItems.map((e) {
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
                ...e.items.map(((e) => AuctionItemComp(
                      item: e,
                      viewModel: viewModel,
                    ))),
                const SizedBox(
                  height: 30,
                )
              ]);
        })
      ]),
    );
  }
}
