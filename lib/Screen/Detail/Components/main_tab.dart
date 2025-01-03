// Main Tab
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Model/Equipment.dart';
import 'package:sample_project/Model/Profile.dart';
import 'package:sample_project/Screen/Components/network_image.dart';
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            item.typeString,
            style: TextStyle(
                color: K.appColor.white,
                fontSize: 16,
                fontWeight: K.appFont.heavy),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            item.value,
            style: TextStyle(
                color: K.appColor.white,
                fontSize: 16,
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
      decoration: BoxDecoration(
        border: Border.all(color: K.appColor.gray, width: 2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //각인 정보
                  Text(
                    "각인",
                    style: TextStyle(
                      color: K.appColor.white,
                      fontSize: 20,
                      fontWeight: K.appFont.heavy,
                    ),
                  ),
                  const SizedBox(height: 10),
                  //활성화 각인 목록
                  viewModel.info!.arkPassive.isArkpassive
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 아크패시브 각인 목록
                            if (viewModel.info!.armoryEngraving != null &&
                                viewModel.info!.armoryEngraving!
                                        .arkPassiveEffects !=
                                    null)
                              Column(
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
                                                fontWeight: K.appFont.heavy,
                                              ),
                                            ),
                                            Text(
                                              " ${e.level}",
                                              style: TextStyle(
                                                color: K.appColor
                                                    .getGradeColor(e.grade),
                                                fontSize: 14,
                                                fontWeight: K.appFont.heavy,
                                              ),
                                            ),
                                            Text(
                                              e.abilityStoneLevel != null
                                                  ? " +${e.abilityStoneLevel!}"
                                                  : "",
                                              style: TextStyle(
                                                color: K.appColor.blue,
                                                fontSize: 14,
                                                fontWeight: K.appFont.heavy,
                                              ),
                                            )
                                          ],
                                        ))
                                    .toList(),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Divider(
                                color: K.appColor.white.withAlpha(50),
                              ),
                            ),
                            Column(
                              // 아크패시브 포인트 정보
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "아크패시브 포인트",
                                  style: TextStyle(
                                    color: K.appColor.white,
                                    fontSize: 15,
                                    fontWeight: K.appFont.heavy,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: viewModel.info!.arkPassive.points
                                      .map((e) => Text(
                                            "- ${e.name} : ${e.value}",
                                            style: TextStyle(
                                              color: K.appColor.white,
                                              fontSize: 13,
                                              fontWeight: K.appFont.heavy,
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ],
                        )
                      : viewModel.info!.armoryEngraving != null &&
                              viewModel.info!.armoryEngraving!.effects != null
                          ? Column(
                              children: viewModel
                                  .info!.armoryEngraving!.effects!
                                  .map((engraving) => Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10, right: 10),
                                        child: Row(
                                          children: [
                                            Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                ClipOval(
                                                  child: NImage(
                                                    url: engraving.icon,
                                                    width: 25,
                                                  ),
                                                ),
                                                Text(
                                                  engraving.items[1],
                                                  style: TextStyle(
                                                    color: K.appColor.white,
                                                    shadows: [
                                                      Shadow(
                                                        offset: const Offset(
                                                            0.0, 0.0),
                                                        blurRadius: 15.0,
                                                        color: K.appColor.black,
                                                      ),
                                                    ],
                                                    fontSize: 16,
                                                    fontWeight: K.appFont.heavy,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              engraving.nameWithoutLevel,
                                              style: TextStyle(
                                                color: K.appColor.white,
                                                fontSize: 14,
                                                fontWeight: K.appFont.heavy,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            )
                          : Text(
                              "활성화된 각인이 없습니다.",
                              style: TextStyle(
                                color: K.appColor.white,
                                fontSize: 12,
                                fontWeight: K.appFont.heavy,
                              ),
                            ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "특성",
                      style: TextStyle(
                        color: K.appColor.white,
                        fontSize: 20,
                        fontWeight: K.appFont.heavy,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: viewModel.info!.armoryProfile.mainStats
                          .map((stat) => StatItem(item: stat))
                          .toList(),
                    ),
                    Divider(
                      color: K.appColor.white.withAlpha(50),
                    ),
                    Column(
                      children: viewModel.info!.armoryProfile.subStats
                          .map((stat) => StatItem(item: stat))
                          .toList(),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
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
                equipType.displayName,
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
      return SizedBox(
        width: 280,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NImage(
              // 아이템 이미지
              url: equipment.icon,
              width: 50,
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
                      width: 5,
                    ),
                    ClipRRect(
                      //품질
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                          color: equipment.tooltip.itemTitle?[0].value
                                  .getQualityColor() ??
                              Colors.transparent,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                "${equipment.tooltip.itemTitle?[0].value.quality ?? ""}",
                                style: TextStyle(
                                    color: K.appColor.white,
                                    fontSize: 12,
                                    fontWeight: K.appFont.bold),
                              ))),
                    ),
                    const SizedBox(
                      width: 5,
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
                          equipment.tooltip.advancedUpgrade != null
                              ? "(상재 +${equipment.tooltip.advancedUpgrade})"
                              : "",
                          style: TextStyle(
                            color: K.appColor.advancedUpgradeColor,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    )
                  ],
                ),
                if (equipment.tooltip.transcendence != null)
                  // 초월
                  Row(
                    children: [
                      SizedBox(
                          width: 20,
                          height: 20,
                          child: NImage(
                              url: K.lostArkAPI.transcendenceImage, width: 20)),
                      Text(
                        "${equipment.tooltip.transcendence?[0]}단계 총 ${equipment.tooltip.transcendence?[1]}",
                        style: TextStyle(
                            color: K.appColor.transcendenceColor,
                            fontSize: 12,
                            fontWeight: K.appFont.heavy),
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
                      color: K.appColor.getGradeColor(equipment.grade),
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
                accessoryType.displayName,
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
            NImage(
              // 악세사리 이미지
              url: accessory.icon,
              width: 50,
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
                      accessoryType.displayName,
                      style: TextStyle(
                          color: K.appColor.white,
                          fontSize: 13,
                          fontWeight: K.appFont.heavy),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (accessoryType != AccessoryType.bracelet &&
                        accessoryType != AccessoryType.abilityStone)
                      ClipRRect(
                        //품질
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                            color: accessory.tooltip.itemTitle?[0].value
                                    .getQualityColor() ??
                                Colors.transparent,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: accessoryType == AccessoryType.bracelet
                                  ? null
                                  : Text(
                                      "${accessory.tooltip.itemTitle?[0].value.quality ?? ""}",
                                      style: TextStyle(
                                          color: K.appColor.white,
                                          fontSize: 12,
                                          fontWeight: K.appFont.bold),
                                    ),
                            )),
                      ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      //악세사리 스텟
                      accessory.tooltip.stats ?? "",
                      style: TextStyle(
                          color: K.appColor.white,
                          fontSize: 12,
                          fontWeight: K.appFont.heavy),
                    ),
                    //아크패시브 수치
                    if (accessory.tooltip.arkPassivePoint != null)
                      Text(
                        "${accessory.tooltip.arkPassivePoint!.name} +${accessory.tooltip.arkPassivePoint!.value}",
                        style: TextStyle(
                            color: K.appColor.white,
                            fontSize: 12,
                            fontWeight: K.appFont.heavy),
                      ),
                  ],
                ),

                // 장신구 연마 옵션 (4티어)
                if (accessory.tooltip.accessoryGrindingEffect != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: accessory.tooltip.accessoryGrindingEffect!
                        .map((effect) => Text(
                              "- ${effect.option} ",
                              style: TextStyle(
                                  color: effect.grade.gradeColor,
                                  fontSize: 13,
                                  fontWeight: K.appFont.heavy),
                            ))
                        .toList(),
                  ),

                //팔찌 옵션
                if (accessoryType == AccessoryType.bracelet &&
                    accessory.tooltip.braceletOption != null)
                  Row(
                    children: [
                      ...accessory.tooltip.braceletOption!.map((option) => Text(
                            "$option ",
                            style: TextStyle(
                                color: K.appColor.braceletOptionColor,
                                fontSize: 13,
                                fontWeight: K.appFont.heavy),
                          ))
                    ],
                  ),

                //어빌리티 스톤 옵션
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (accessoryType == AccessoryType.abilityStone &&
                        accessory.tooltip.buffAbilityStoneOption.isNotEmpty)
                      Row(
                          // 증가 능력
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: accessory.tooltip.buffAbilityStoneOption
                              .map(
                                (option) => Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              .toList()),
                    if (accessoryType == AccessoryType.abilityStone &&
                        accessory.tooltip.debuffAbilityStoneOption.isNotEmpty)
                      Row(
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
                              .toList()),
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
                  if (viewModel.info!.armoryEquipment.totalElixirLevel !=
                      0) // 엘릭서 요약
                    Row(
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
                              viewModel.info!.armoryEquipment
                                      .getEquipment(EquipType.headGear)
                                      ?.tooltip
                                      .elixirAddtionalEffect ??
                                  "추가 효과 없음",
                              style: TextStyle(
                                  color: K.appColor.white,
                                  fontSize: 12,
                                  fontWeight: K.appFont.heavy),
                            )
                          ],
                        )
                      ],
                    ),
                  if (viewModel.info!.armoryEquipment.totalTranscendence !=
                      0) // 초월 요약
                    Row(
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
            padding: const EdgeInsets.all(30),
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
                                  NImage(
                                    url: card.icon,
                                    width: 35,
                                  ),
                                  Text(
                                    card.awakeCount.toString(),
                                    style: TextStyle(
                                        color: K.appColor.white,
                                        shadows: [
                                          Shadow(
                                            offset: const Offset(
                                                0.0, 0.0), // 그림자의 x, y 오프셋
                                            blurRadius: 15.0, // 그림자의 흐림 정도
                                            color: K.appColor.black, // 그림자의 색상
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
                                  const SizedBox(
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
                          const SizedBox(
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
            padding: const EdgeInsets.all(30),
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
                                        NImage(
                                          url: gem.icon,
                                          width: 35,
                                        ),
                                        Text(
                                          "${gem.level}",
                                          style: TextStyle(
                                              color: K.appColor.white,
                                              shadows: [
                                                Shadow(
                                                  offset: const Offset(0.0,
                                                      0.0), // 그림자의 x, y 오프셋
                                                  blurRadius:
                                                      15.0, // 그림자의 흐림 정도
                                                  color: K.appColor
                                                      .black, // 그림자의 색상
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
                                              offset: const Offset(
                                                  0.0, 0.0), // 그림자의 x, y 오프셋
                                              blurRadius: 15.0, // 그림자의 흐림 정도
                                              color:
                                                  K.appColor.black, // 그림자의 색상
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
