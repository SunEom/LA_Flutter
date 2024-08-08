// Main Tab
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Model/Equipment.dart';
import 'package:sample_project/Model/Gem.dart';
import 'package:sample_project/Model/Profile.dart';
import 'package:sample_project/Screen/Detail/detail_view_model.dart';

class MainInfoContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatsContent(),
        const SizedBox(
          height: 10,
        ),
        EquipmentContent(),
        const SizedBox(
          height: 10,
        ),
        CharacterGemContents(),
        const SizedBox(
          height: 10,
        ),
        CardContents()
      ],
    );
  }
}

//Engraving & Stats
class StatItem extends StatelessWidget {
  final Stats item;

  const StatItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Row(
        children: [
          Text(
            item.typeString,
            style: TextStyle(
                color: K.appColor.white,
                fontSize: 15,
                fontWeight: K.appFont.heavy),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            item.value,
            style: TextStyle(
                color: K.appColor.white,
                fontSize: 14,
                fontWeight: K.appFont.heavy),
          )
        ],
      ),
    );
  }
}

class StatsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DetailViewModel>(context);
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: K.appColor.gray, width: 2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //각인 정보
              Text(
                "각인",
                style: TextStyle(
                    color: K.appColor.white,
                    fontSize: 20,
                    fontWeight: K.appFont.heavy),
              ),
              const SizedBox(
                height: 10,
              ),
              //활성화 각인 목록

              viewModel.info!.armoryProfile.arkPassive.isArkpassive
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 아크패시브 각인 목록
                        viewModel.info!.armoryEngraving != null &&
                                viewModel.info!.armoryEngraving!
                                        .arkPassiveEffects !=
                                    null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: viewModel
                                    .info!.armoryEngraving!.arkPassiveEffects!
                                    .map((e) => Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "- ${e.name}",
                                              style: TextStyle(
                                                  color: K.appColor.white,
                                                  fontSize: 14,
                                                  fontWeight: K.appFont.heavy),
                                            ),
                                            Text(
                                              " ${e.level}",
                                              style: TextStyle(
                                                  color: K.appColor
                                                      .getGradeColor(e.grade),
                                                  fontSize: 14,
                                                  fontWeight: K.appFont.heavy),
                                            ),
                                            Text(
                                              e.abilityStoneLevel != null
                                                  ? " +${e.abilityStoneLevel!}"
                                                  : "",
                                              style: TextStyle(
                                                  color: K.appColor.blue,
                                                  fontSize: 14,
                                                  fontWeight: K.appFont.heavy),
                                            )
                                          ],
                                        ))
                                    .toList(),
                              )
                            : const SizedBox.shrink(),
                        Column(
                          // 아크패시브 포인트 정보
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/game/ico_arkpassive.png",
                                  width: 30,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "아크패시브 포인트",
                                  style: TextStyle(
                                      color: K.appColor.white,
                                      fontSize: 14,
                                      fontWeight: K.appFont.heavy),
                                )
                              ],
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: viewModel
                                    .info!.armoryProfile.arkPassive.points
                                    .map((e) => Text(
                                          "- ${e.name} : ${e.value}",
                                          style: TextStyle(
                                              color: K.appColor.white,
                                              fontSize: 13,
                                              fontWeight: K.appFont.heavy),
                                        ))
                                    .toList())
                          ],
                        )
                      ],
                    )
                  : viewModel.info!.armoryEngraving != null &&
                          viewModel.info!.armoryEngraving!.effects != null
                      ? Wrap(
                          children: viewModel.info!.armoryEngraving!.effects!
                              .map((engraving) => Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        ClipOval(
                                          child: Image.network(
                                            engraving.icon,
                                            width: 35,
                                          ),
                                        ),
                                        Text(
                                          engraving.items[1],
                                          style: TextStyle(
                                              color: K.appColor.white,
                                              shadows: [
                                                const Shadow(
                                                  offset: Offset(0.0,
                                                      0.0), // 그림자의 x, y 오프셋
                                                  blurRadius:
                                                      15.0, // 그림자의 흐림 정도
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0), // 그림자의 색상
                                                )
                                              ],
                                              fontSize: 15,
                                              fontWeight: K.appFont.heavy),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList())
                      : Text(
                          "활성화된 각인이 없습니다.",
                          style: TextStyle(
                              color: K.appColor.white,
                              fontSize: 12,
                              fontWeight: K.appFont.heavy),
                        ),
              const SizedBox(
                height: 20,
              ),

              //특성 정보
              Text(
                "특성",
                style: TextStyle(
                    color: K.appColor.white,
                    fontSize: 20,
                    fontWeight: K.appFont.heavy),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // 치명 특화 신속
                children: [
                  ...[
                    StatsType.critical,
                    StatsType.specialization,
                    StatsType.speed
                  ].map((type) {
                    Stats item = viewModel.info!.armoryProfile.stats
                        .where((s) => s.type == type)
                        .first;
                    return StatItem(item: item);
                  })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // 인내 숙련 제압
                children: [
                  ...[StatsType.endurance, StatsType.mastery, StatsType.subdue]
                      .map((type) {
                    Stats item = viewModel.info!.armoryProfile.stats
                        .where((s) => s.type == type)
                        .first;
                    return StatItem(item: item);
                  })
                ],
              )
            ],
          ),
        ));
  }
}

//Equipment

class EquipmentItem extends StatelessWidget {
  final EquipType equipType;

  const EquipmentItem({required this.equipType});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DetailViewModel>(context);
    Equipment? equipment =
        viewModel.info!.armoryEquipment.getEquipment(equipType);

    if (equipment == null) {
      return Row(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white60),
                borderRadius: BorderRadius.circular(10)),
            width: 50,
            height: 50,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${equipType.displayName}",
                style: TextStyle(color: K.appColor.white, fontSize: 13),
              ),
              Text(
                "-",
                style: TextStyle(color: K.appColor.white, fontSize: 15),
              ),
            ],
          )
        ],
      );
    } else {
      return Container(
        width: 280,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              // 아이템 이미지
              equipment!.icon,
              width: 50,
              height: 50,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      // 아이템 타입
                      equipType.displayName,
                      style: TextStyle(
                          color: K.appColor.white,
                          fontSize: 13,
                          fontWeight: K.appFont.heavy),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          //아이템 레벨
                          equipment.tooltip.itemTitle?[0].value.itemLevel ?? "",
                          style: TextStyle(
                              color: K.appColor.white,
                              fontSize: 14,
                              fontWeight: K.appFont.bold),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          // 상급재련
                          equipment!.tooltip.advancedUpgrade != null
                              ? "(+${equipment.tooltip.advancedUpgrade})"
                              : "",
                          style: TextStyle(
                            color: K.appColor.advancedUpgradeColor,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        equipment.tooltip.transcendence != null
                            ?
                            // 초월
                            Row(
                                children: [
                                  Container(
                                      width: 20,
                                      height: 20,
                                      child: Image.network(
                                          K.lostArkAPI.transcendenceImage,
                                          width: 20)),
                                  Text(
                                    "${equipment!.tooltip.transcendence?[0]}단계 총 ${equipment!.tooltip.transcendence?[1]}",
                                    style: TextStyle(
                                        color: K.appColor.transcendenceColor,
                                        fontSize: 12,
                                        fontWeight: K.appFont.heavy),
                                  )
                                ],
                              )
                            : const SizedBox.shrink()
                      ],
                    )
                  ],
                ),
                Row(
                  // 엘릭서
                  children: [
                    ...equipment.tooltip.elixir.map(
                      (e) => Row(
                        children: [
                          Text(
                            e[0] ?? "",
                            style: TextStyle(
                                color: K.appColor.white,
                                fontSize: 12,
                                fontWeight: K.appFont.heavy),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            e[1] ?? "",
                            style: TextStyle(
                                color: K.appColor.elixirColor,
                                fontSize: 13,
                                fontWeight: K.appFont.heavy),
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Text(
                  // 아이템 이름
                  equipment.name,
                  style: TextStyle(
                      color: K.appColor.getGradeColor(equipment!.grade),
                      fontSize: 13,
                      fontWeight: K.appFont.heavy),
                ),
              ],
            )
          ],
        ),
      );
    }
  }
}

class AccessoryItem extends StatelessWidget {
  final AccessoryType accessoryType;

  const AccessoryItem({required this.accessoryType});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DetailViewModel>(context);

    Equipment? accessory =
        viewModel.info!.armoryEquipment.getAccessory(accessoryType);

    if (accessory == null) {
      //미착용
      return Row(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white60),
                borderRadius: BorderRadius.circular(10)),
            width: 50,
            height: 50,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${accessoryType.displayName}",
                style: TextStyle(color: K.appColor.white, fontSize: 13),
              ),
              Text(
                "-",
                style: TextStyle(color: K.appColor.white, fontSize: 15),
              ),
            ],
          )
        ],
      );
    } else {
      //착용
      return SizedBox(
        width: 280,
        child: Row(
          children: [
            Image.network(
              // 악세사리 이미지
              accessory!.icon,
              width: 50,
              height: 50,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      //악세사리 타입
                      "${accessoryType.displayName}",
                      style: TextStyle(
                          color: K.appColor.white,
                          fontSize: 13,
                          fontWeight: K.appFont.heavy),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    accessoryType != AccessoryType.bracelet &&
                            accessoryType != AccessoryType.abilityStone
                        ? ClipRRect(
                            //품질
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                                color: accessory!.tooltip.itemTitle?[0].value
                                        .getQualityColor() ??
                                    Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: accessoryType == AccessoryType.bracelet
                                      ? null
                                      : Text(
                                          "${accessory!.tooltip.itemTitle?[0].value.quality ?? ""}",
                                          style: TextStyle(
                                              color: K.appColor.white,
                                              fontSize: 12,
                                              fontWeight: K.appFont.bold),
                                        ),
                                )),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      //악세사리 스텟
                      "${accessory!.tooltip.stats ?? ""}",
                      style: TextStyle(
                          color: K.appColor.white,
                          fontSize: 12,
                          fontWeight: K.appFont.heavy),
                    ),
                    //아크패시브 수치
                    accessory.tooltip.arkPassivePoint != null
                        ? Text(
                            "${accessory.tooltip.arkPassivePoint!.name} +${accessory.tooltip.arkPassivePoint!.value}",
                            style: TextStyle(
                                color: K.appColor.white,
                                fontSize: 12,
                                fontWeight: K.appFont.heavy),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),

                // 장신구 연마 옵션 (4티어)
                accessory!.tooltip.accessoryGrindingEffect != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: accessory!.tooltip.accessoryGrindingEffect!
                            .map((effect) => Text(
                                  "- ${effect.option} ",
                                  style: TextStyle(
                                      color: effect.grade.gradeColor,
                                      fontSize: 13,
                                      fontWeight: K.appFont.heavy),
                                ))
                            .toList(),
                      )
                    : const SizedBox.shrink(),

                //팔찌 옵션
                accessoryType == AccessoryType.bracelet &&
                        accessory!.tooltip.braceletOption != null
                    ? Row(
                        children: [
                          ...accessory!.tooltip.braceletOption!
                              .map((option) => Text(
                                    "$option ",
                                    style: TextStyle(
                                        color: K.appColor.braceletOptionColor,
                                        fontSize: 13,
                                        fontWeight: K.appFont.heavy),
                                  ))
                        ],
                      )
                    : const SizedBox.shrink(),

                //어빌리티 스톤 옵션
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    accessoryType == AccessoryType.abilityStone &&
                            accessory.tooltip.buffAbilityStoneOption.isNotEmpty
                        ? Row(
                            // 증가 능력
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: accessory.tooltip.buffAbilityStoneOption
                                .map(
                                  (option) => Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        option[0],
                                        style: TextStyle(
                                            color: K.appColor.white,
                                            fontSize: 12,
                                            fontWeight: K.appFont.heavy),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        option[1],
                                        style: TextStyle(
                                            color: K.appColor.blue,
                                            fontSize: 13,
                                            fontWeight: K.appFont.heavy),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                )
                                .toList())
                        : const SizedBox.shrink(),
                    accessoryType == AccessoryType.abilityStone &&
                            accessory
                                .tooltip.debuffAbilityStoneOption.isNotEmpty
                        ? Row(
                            // 감소 능력
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: accessory.tooltip.debuffAbilityStoneOption
                                .map(
                                  (option) => Row(
                                    children: [
                                      Text(
                                        option[0],
                                        style: TextStyle(
                                            color: K.appColor.white,
                                            fontSize: 12,
                                            fontWeight: K.appFont.heavy),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        option[1],
                                        style: TextStyle(
                                            color: K.appColor.red,
                                            fontSize: 13,
                                            fontWeight: K.appFont.heavy),
                                      ),
                                    ],
                                  ),
                                )
                                .toList())
                        : const SizedBox.shrink(),
                  ],
                ),
                Text(
                  //악세사리 이름
                  accessory.name,
                  style: TextStyle(
                      color: K.appColor.getGradeColor(accessory.grade),
                      fontSize: 13,
                      fontWeight: K.appFont.heavy),
                ),
              ],
            )
          ],
        ),
      );
    }
  }
}

class EquipmentContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DetailViewModel>(context);
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: K.appColor.gray, width: 2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "장비",
                    style: TextStyle(
                        color: K.appColor.white,
                        fontSize: 20,
                        fontWeight: K.appFont.heavy),
                  ),
                  viewModel.info!.armoryEquipment.totalElixirLevel !=
                          0 // 엘릭서 요약
                      ? Row(
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "엘릭서",
                                  style: TextStyle(
                                      color: K.appColor.white,
                                      fontSize: 13,
                                      fontWeight: K.appFont.heavy),
                                ),
                                Text(
                                  "${viewModel.info!.armoryEquipment.getEquipment(EquipType.headGear)?.tooltip.elixirAddtionalEffect ?? "추가 효과 없음"}",
                                  style: TextStyle(
                                      color: K.appColor.white,
                                      fontSize: 12,
                                      fontWeight: K.appFont.heavy),
                                )
                              ],
                            )
                          ],
                        )
                      : SizedBox.shrink(),
                  viewModel.info!.armoryEquipment.totalTranscendence !=
                          0 // 초월 요약
                      ? Row(
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "초월",
                                  style: TextStyle(
                                      color: K.appColor.white,
                                      fontSize: 13,
                                      fontWeight: K.appFont.heavy),
                                ),
                                Text(
                                  "총 ${viewModel.info!.armoryEquipment.totalTranscendence}단계",
                                  style: TextStyle(
                                      color: K.appColor.white,
                                      fontSize: 12,
                                      fontWeight: K.appFont.heavy),
                                )
                              ],
                            )
                          ],
                        )
                      : SizedBox.shrink()
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Wrap(
                direction: Axis.horizontal, // 방향 설정
                runSpacing: 50,
                children: [
                  Column(
                    // 장비
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: EquipType.values
                        .map((type) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: EquipmentItem(
                                equipType: type,
                              ),
                            ))
                        .toList(),
                  ),
                  Column(
                    // 악세사리
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: AccessoryType.values
                        .map((type) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: AccessoryItem(
                                accessoryType: type,
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

// Card
class CardContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DetailViewModel>(context);

    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: K.appColor.gray, width: 2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "카드",
                  style: TextStyle(
                      color: K.appColor.white,
                      fontSize: 20,
                      fontWeight: K.appFont.heavy),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: viewModel.info!.armoryCard != null
                      ? viewModel.info!.armoryCard!.cards
                          .map((card) => Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Image.network(
                                    card.icon,
                                    width: 35,
                                  ),
                                  Text(
                                    card.awakeCount.toString(),
                                    style: TextStyle(
                                        color: K.appColor.white,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(
                                                0.0, 0.0), // 그림자의 x, y 오프셋
                                            blurRadius: 15.0, // 그림자의 흐림 정도
                                            color: Color.fromARGB(
                                                255, 0, 0, 0), // 그림자의 색상
                                          )
                                        ],
                                        fontSize: 18,
                                        fontWeight: K.appFont.heavy),
                                  ),
                                ],
                              ))
                          .toList()
                      : [
                          Text(
                            "장착중인 카드가 없습니다.",
                            style: TextStyle(
                                color: K.appColor.white,
                                fontSize: 12,
                                fontWeight: K.appFont.heavy),
                          ),
                        ],
                ),
                viewModel.info!.armoryCard?.cardEffects != null &&
                        viewModel.info!.armoryCard!.cardEffects!.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: viewModel.info!.armoryCard!.cardEffects!
                            .map(
                              (effect) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    effect.last.name,
                                    style: TextStyle(
                                        color: K.appColor.white,
                                        fontSize: 12,
                                        fontWeight: K.appFont.heavy),
                                  )
                                ],
                              ),
                            )
                            .toList(),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "적용중인 세트효과가 없습니다.",
                            style: TextStyle(
                                color: K.appColor.white,
                                fontSize: 12,
                                fontWeight: K.appFont.heavy),
                          )
                        ],
                      )
              ],
            )));
  }
}

// Gem
class CharacterGemContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DetailViewModel>(context);

    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: K.appColor.gray, width: 2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "보석",
                  style: TextStyle(
                      color: K.appColor.white,
                      fontSize: 20,
                      fontWeight: K.appFont.heavy),
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  children: viewModel.info!.armoryGem.gems != null
                      ? viewModel.info!.armoryGem.gems!
                          .map((gem) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Image.network(
                                          gem.icon,
                                          width: 35,
                                        ),
                                        Text(
                                          "${gem.level}",
                                          style: TextStyle(
                                              color: K.appColor.white,
                                              shadows: [
                                                const Shadow(
                                                  offset: Offset(0.0,
                                                      0.0), // 그림자의 x, y 오프셋
                                                  blurRadius:
                                                      15.0, // 그림자의 흐림 정도
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0), // 그림자의 색상
                                                )
                                              ],
                                              fontSize: 15,
                                              fontWeight: K.appFont.heavy),
                                        ),
                                      ],
                                    ),
                                    AutoSizeText(
                                      gem.type,
                                      maxLines: 1,
                                      minFontSize: 13,
                                      maxFontSize: 16,
                                      style: TextStyle(
                                          color: K.appColor.white,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(
                                                  0.0, 0.0), // 그림자의 x, y 오프셋
                                              blurRadius: 15.0, // 그림자의 흐림 정도
                                              color: Color.fromARGB(
                                                  255, 0, 0, 0), // 그림자의 색상
                                            )
                                          ],
                                          fontWeight: K.appFont.heavy),
                                    ),
                                  ],
                                ),
                              ))
                          .toList()
                      : [
                          Text(
                            "장착중인 보석이 없습니다.",
                            style: TextStyle(
                                color: K.appColor.white,
                                fontSize: 12,
                                fontWeight: K.appFont.heavy),
                          ),
                        ],
                ),
              ],
            )));
  }
}
