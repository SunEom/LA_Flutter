import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Model/adventrue_island.dart';
import 'package:sample_project/Screen/Home/home_view.dart';
import 'package:sample_project/Screen/Home/home_view_model.dart';
import 'package:sample_project/Util/Util.dart';

class AdventureIslandContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = Provider.of<HomeViewModel>(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(2, 2), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: viewModel.adventrueIslandCalendar != null
            ? Column(
                children: [
                  Text(
                    "오늘의 모험섬",
                    style: TextStyle(
                        color: K.appColor.white,
                        fontSize: 15,
                        fontWeight: K.appFont.heavy),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children:
                        viewModel.adventrueIslandCalendar!.todayAdventrueIslands
                            .map((island) => Column(
                                  children: [
                                    AdventureIslandItem(
                                      adventrueIsland: island,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ))
                            .toList(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        // 카오스 게이트
                        children: [
                          Image.network(
                            K.appImage.chaosGateIcon,
                            width: 25,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "카오스 게이트",
                            style: TextStyle(
                                color: K.appColor.white,
                                fontSize: 15,
                                fontWeight: K.appFont.heavy),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          viewModel.adventrueIslandCalendar!.isOnChaosGateDay
                              ? Icon(
                                  // 있는 날
                                  Icons.circle_outlined,
                                  color: K.appColor.blue,
                                  size: 20,
                                )
                              : Icon(
                                  // 없는 날
                                  Icons.clear_sharp,
                                  color: K.appColor.red,
                                  size: 25,
                                )
                        ],
                      ),
                      Row(
                        // 카오스 게이트
                        children: [
                          Image.network(
                            K.appImage.fieldBossIcon,
                            width: 25,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "필드보스",
                            style: TextStyle(
                                color: K.appColor.white,
                                fontSize: 15,
                                fontWeight: K.appFont.heavy),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          viewModel.adventrueIslandCalendar!.isOnFieldBossDay
                              ? Icon(
                                  // 있는 날
                                  Icons.circle_outlined,
                                  color: K.appColor.blue,
                                  size: 20,
                                )
                              : Icon(
                                  // 없는 날
                                  Icons.clear_sharp,
                                  color: K.appColor.red,
                                  size: 25,
                                )
                        ],
                      )
                    ],
                  ),
                ],
              )
            : Text(
                "일정 가져오기를 실패하였습니다",
                style: TextStyle(
                    color: K.appColor.white,
                    fontSize: 15,
                    fontWeight: K.appFont.heavy),
              ),
      ),
    );
  }
}

class AdventureIslandItem extends StatelessWidget {
  final AdventrueIsland adventrueIsland;

  const AdventureIslandItem({required this.adventrueIsland});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          adventrueIsland.contentsIcon,
          width: 45,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  adventrueIsland.contentsName,
                  style: TextStyle(
                      color: K.appColor.white,
                      fontSize: 15,
                      fontWeight: K.appFont.heavy),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.network(
                  adventrueIsland.mainRewardType.icon,
                  width: 20,
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: adventrueIsland.todayStartTime
                  .map(
                    (time) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        Utils.getTimeData(time),
                        style: TextStyle(
                            decoration: Utils.isBeforeNow(time)
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            decorationThickness: 2,
                            decorationColor: K.appColor.white,
                            color: K.appColor.white,
                            fontSize: 12,
                            fontWeight: K.appFont.heavy),
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        )
      ],
    );
  }
}
