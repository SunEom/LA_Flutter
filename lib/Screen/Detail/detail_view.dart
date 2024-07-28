import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Components/top_bar.dart';
import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Model/Equipment.dart';
import 'package:sample_project/Model/Profile.dart';
import 'package:sample_project/Model/Sibling.dart';
import 'package:sample_project/Model/Skills.dart';
import 'package:sample_project/Screen/Detail/detail_view_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:sample_project/Screen/Home/home_view_model.dart';

//Skill Tab
class SkillContents extends StatelessWidget {
  final DetailViewModel viewModel;
  const SkillContents({required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: viewModel.info!.armorySkills != null
          ? viewModel.info!.armorySkills!.skills
              .map((skill) => SkillItem(viewModel: viewModel, skill: skill))
              .toList()
          : [],
    );
  }
}

class SkillItem extends StatelessWidget {
  final DetailViewModel viewModel;
  final Skill skill;

  const SkillItem({required this.viewModel, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          //스킬 이미지, 이름, 레벨
          Container(
            width: 70,
            child: Column(
              children: [
                Image.network(
                  skill.icon,
                  width: 40,
                ),
                const SizedBox(
                  height: 5,
                ),
                AutoSizeText(
                  skill.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  minFontSize: 10,
                  maxFontSize: 15,
                  style: TextStyle(
                      color: K.appColor.white, fontWeight: K.appFont.heavy),
                ),
                Text(
                  "Lv ${skill.level}",
                  style: TextStyle(
                      fontSize: 14,
                      color: K.appColor.white,
                      fontWeight: K.appFont.heavy),
                )
              ],
            ),
          ),

          //트라이포드 정보
          Row(
            children: skill.usedTripod
                .map((t) => Row(
                      children: [
                        Container(
                          width: 60,
                          child: Column(
                            children: [
                              //트라이포드 이미지 및 슬롯 번호
                              Stack(
                                children: [
                                  Image.network(
                                    t.icon,
                                    width: 40,
                                  ),
                                  Text(
                                    "${t.slot}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: K.appColor.white,
                                      fontWeight: K.appFont.superHeavy,
                                      shadows: [
                                        const Shadow(
                                          offset:
                                              Offset(0.0, 0.0), // 그림자의 x, y 오프셋
                                          blurRadius: 15.0, // 그림자의 흐림 정도
                                          color: Color.fromARGB(
                                              255, 0, 0, 0), // 그림자의 색상
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // 트라이포드 이름
                              AutoSizeText(
                                t.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                minFontSize: 10,
                                maxFontSize: 12,
                                style: TextStyle(
                                    color: K.appColor.white,
                                    fontWeight: K.appFont.heavy),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ))
                .toList(),
          ),
          Column(
            children: [
              // 룬 정보
              skill.rune != null
                  ? Row(
                      children: [
                        Image.network(
                          skill.rune!.icon,
                          width: 25,
                        ),

                        // 룬 이름
                        AutoSizeText(
                          skill.rune!.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          minFontSize: 11,
                          maxFontSize: 15,
                          style: TextStyle(
                              color:
                                  K.appColor.getGradeColor(skill.rune!.grade),
                              fontWeight: K.appFont.superHeavy),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),

              //보석 정보
              viewModel.info!.armoryGem.gems != null
                  ? Column(
                      children: viewModel.info!.armoryGem.gems!
                          .where((gem) => gem.tooltip.contains(skill.name))
                          .map((gem) => Row(
                                children: [
                                  Image.network(
                                    gem.icon,
                                    width: 25,
                                  ),

                                  // 보석 타입 (멸, 홍, 겁, 작)
                                  AutoSizeText(
                                    gem.type,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    minFontSize: 11,
                                    maxFontSize: 15,
                                    style: TextStyle(
                                        color: K.appColor.white,
                                        fontWeight: K.appFont.superHeavy),
                                  ),
                                ],
                              ))
                          .toList())
                  : const SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }
}

//ArmorySibling Tab

class ArmorySiblingContents extends StatelessWidget {
  final DetailViewModel viewModel;
  const ArmorySiblingContents({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    ScrollController controller = PrimaryScrollController.of(context);

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: (viewModel.armorySiblings != null &&
                viewModel.armorySiblings!.sibling.isNotEmpty)
            ? viewModel.armorySiblings!.serverList
                .map((server) => Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //서버 이름
                          Text(
                            server,
                            style: TextStyle(
                                color: K.appColor.white,
                                fontSize: 20,
                                fontWeight: K.appFont.heavy),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          //캐릭터 목록
                          ...viewModel.armorySiblings!.siblingPerServer[server]!
                              .map((sibling) => Column(
                                    children: [
                                      ArmorySiblingItem(
                                        sibling: sibling,
                                        viewModel: viewModel,
                                        scrollController: controller,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      )
                                    ],
                                  ))
                        ],
                      ),
                    ))
                .toList()
            : [],
      ),
    );
  }
}

class ArmorySiblingItem extends StatelessWidget {
  final Sibling sibling;
  final DetailViewModel viewModel;
  final ScrollController scrollController;

  const ArmorySiblingItem(
      {required this.sibling,
      required this.viewModel,
      required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: K.appColor.gray),
          borderRadius: BorderRadius.circular(10)),
      child: TextButton(
          onPressed: () {
            scrollController.animateTo(
              //화면 상단으로 이동
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            // 선택된 캐릭터 정보 요청
            viewModel.fetchAnotherUserDetail(sibling.characterName);
          },
          style: const ButtonStyle(
            backgroundColor: WidgetStateColor.transparent,
            overlayColor: WidgetStateColor.transparent,
          ),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // 클래스 이름
                    sibling.characterClassName,
                    style: TextStyle(
                        color: K.appColor.white,
                        fontSize: 11,
                        fontWeight: K.appFont.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // 닉네임
                        sibling.characterName,
                        style: TextStyle(
                            color: K.appColor.white,
                            fontSize: 14,
                            fontWeight: K.appFont.heavy),
                      ),
                      Text(
                        // 아이템 레벨
                        sibling.itemAvgLevel,
                        style: TextStyle(
                            color: K.appColor.white,
                            fontSize: 12,
                            fontWeight: K.appFont.bold),
                      )
                    ],
                  )
                ],
              ))),
    );
  }
}

class DetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DetailViewModel>(context);

// 캐릭터를 찾을 수 없음
    Widget characterNotFoundView() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              viewModel.nickname,
              style: TextStyle(
                  color: K.appColor.white,
                  fontSize: 14,
                  fontWeight: K.appFont.heavy),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "해당 유저가 존재하지 않거나",
              style: TextStyle(
                  color: K.appColor.white,
                  fontSize: 14,
                  fontWeight: K.appFont.bold),
            ),
            Text(
              "오랜시간 접속하지 않은 유저입니다.",
              style: TextStyle(
                  color: K.appColor.white,
                  fontSize: 14,
                  fontWeight: K.appFont.bold),
            ),
          ],
        ),
      );
    }

// Main Contents

    Widget characterImage() {
      return viewModel.info != null &&
              viewModel.info!.armoryProfile.characterImage != null
          ? Image.network(viewModel.info!.armoryProfile.characterImage!,
              width: 150)
          : const SizedBox(
              width: 150,
              child: Text('Image not available'),
            );
    }

    Widget profileItem(String title, String content) {
      return Row(
        children: [
          Container(
              width: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white70),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(title,
                  style: TextStyle(color: K.appColor.white, fontSize: 14))),
          const SizedBox(width: 10),
          SizedBox(
            width: 80,
            child: AutoSizeText(
              content,
              maxLines: 1,
              minFontSize: 5,
              maxFontSize: 15,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: K.appColor.white, fontWeight: K.appFont.heavy),
              textAlign: TextAlign.left,
            ),
          )
        ],
      );
    }

    Widget profileInfo() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: AutoSizeText(
              viewModel.info!.armoryProfile.characterName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              minFontSize: 14,
              maxFontSize: 18,
              style: TextStyle(
                color: K.appColor.white,
                fontWeight: K.appFont.heavy,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 10),
          profileItem("서버", "${viewModel.info?.armoryProfile.serverName}"),
          const SizedBox(height: 5),
          profileItem(
              "길드", "${viewModel.info?.armoryProfile.guildName ?? "-"}"),
          const SizedBox(height: 5),
          profileItem(
              "클래스", "${viewModel.info?.armoryProfile.characterClassName}"),
          const SizedBox(height: 5),
          profileItem("칭호", "${viewModel.info?.armoryProfile.title ?? "-"}"),
          const SizedBox(height: 5),
          profileItem(
              "전투 Lv", "${viewModel.info?.armoryProfile.characterLevel}"),
          const SizedBox(height: 5),
          profileItem(
              "아이템 Lv", "${viewModel.info?.armoryProfile.itemAvgLevel}"),
          const SizedBox(height: 5),
          profileItem(
              "원정대 Lv", "${viewModel.info?.armoryProfile.expeditionLevel}"),
        ],
      );
    }

    Widget profileContents() {
      return Container(
          decoration: BoxDecoration(
            border: Border.all(color: K.appColor.gray, width: 2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [characterImage(), profileInfo()],
            ),
          ));
    }

//Tab Button
    Widget tabButton(DetailViewTab tab) {
      bool isSelectedTab = viewModel.selectedTab == tab;

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

//Engraving & Stats

    Widget statItem(Stats item) {
      return Container(
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

    Widget statsContent() {
      return Container(
          width: 1000,
          decoration: BoxDecoration(
            border: Border.all(color: K.appColor.gray, width: 2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(30),
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
                viewModel.info!.armoryEngraving != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: viewModel.info!.armoryEngraving!.effects
                            .map((engraving) => Stack(
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
                                              offset: Offset(
                                                  0.0, 0.0), // 그림자의 x, y 오프셋
                                              blurRadius: 15.0, // 그림자의 흐림 정도
                                              color: Color.fromARGB(
                                                  255, 0, 0, 0), // 그림자의 색상
                                            )
                                          ],
                                          fontSize: 15,
                                          fontWeight: K.appFont.heavy),
                                    ),
                                  ],
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
                      return statItem(item);
                    })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // 인내 숙련 제압
                  children: [
                    ...[
                      StatsType.endurance,
                      StatsType.mastery,
                      StatsType.subdue
                    ].map((type) {
                      Stats item = viewModel.info!.armoryProfile.stats
                          .where((s) => s.type == type)
                          .first;
                      return statItem(item);
                    })
                  ],
                )
              ],
            ),
          ));
    }

//Equipment

    Widget equipmentItem(EquipType equipType) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // 아이템 타입
                        "${equipType.displayName}",
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
                            "${equipment.tooltip.itemTitle?[0].value.itemLevel ?? ""}",
                            style: TextStyle(
                                color: K.appColor.white,
                                fontSize: 12,
                                fontWeight: K.appFont.bold),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            // 상급재련
                            "${equipment.tooltip.advancedUpgrade != null ? "(+${equipment.tooltip.advancedUpgrade})" : ""}",
                            style: TextStyle(
                              color: K.appColor.advancedUpgradeColor,
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(
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
                                      "${equipment.tooltip.transcendence?[0]}단계 총 ${equipment.tooltip.transcendence?[1]}",
                                      style: TextStyle(
                                          color: K.appColor.transcendenceColor,
                                          fontSize: 12,
                                          fontWeight: K.appFont.heavy),
                                    )
                                  ],
                                )
                              : SizedBox.shrink()
                        ],
                      )
                    ],
                  ),
                  Row(
                    // 엘릭서
                    children: [
                      ...equipment.tooltip.elixir
                          .map(
                            (e) => Row(
                              children: [
                                Text(
                                  e[0] ?? "",
                                  style: TextStyle(
                                      color: K.appColor.white,
                                      fontSize: 12,
                                      fontWeight: K.appFont.heavy),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  e[1] ?? "",
                                  style: TextStyle(
                                      color: K.appColor.elixirColor,
                                      fontSize: 13,
                                      fontWeight: K.appFont.heavy),
                                ),
                                SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          )
                          .toList()
                    ],
                  ),
                  Text(
                    // 아이템 이름
                    "${equipment!.name}",
                    style: TextStyle(
                        color: K.appColor.getGradeColor(equipment!.grade),
                        fontSize: 14,
                        fontWeight: K.appFont.heavy),
                  ),
                ],
              )
            ],
          ),
        );
      }
    }

    Widget accessoryItem(AccessoryType accessoryType) {
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
        return Container(
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
                                  color: accessory.tooltip.itemTitle?[0].value
                                          .getQualityColor() ??
                                      Colors.transparent,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child:
                                        accessoryType == AccessoryType.bracelet
                                            ? null
                                            : Text(
                                                "${accessory.tooltip.itemTitle?[0].value.quality ?? ""}",
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
                        "${accessory.tooltip.stats ?? ""}",
                        style: TextStyle(
                            color: K.appColor.white,
                            fontSize: 12,
                            fontWeight: K.appFont.heavy),
                      ),
                      //어빌리티 스톤 옵션
                      Row(
                        children: [
                          accessoryType == AccessoryType.abilityStone &&
                                  accessory
                                      .tooltip.buffAbilityStoneOption.isNotEmpty
                              ? Row(
                                  // 증가 능력
                                  children: accessory
                                      .tooltip.buffAbilityStoneOption!
                                      .map(
                                        (option) => Row(
                                          children: [
                                            Text(
                                              option[1],
                                              style: TextStyle(
                                                  color: K.appColor.blue,
                                                  fontSize: 12,
                                                  fontWeight: K.appFont.heavy),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList())
                              : SizedBox.shrink(),
                          accessoryType == AccessoryType.abilityStone &&
                                  accessory.tooltip.debuffAbilityStoneOption
                                      .isNotEmpty
                              ? Row(
                                  // 감소 능력
                                  children: accessory
                                      .tooltip.debuffAbilityStoneOption!
                                      .map(
                                        (option) => Row(
                                          children: [
                                            Text(
                                              option[1],
                                              style: TextStyle(
                                                  color: K.appColor.red,
                                                  fontSize: 12,
                                                  fontWeight: K.appFont.heavy),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        ),
                                      )
                                      .toList())
                              : SizedBox.shrink(),
                        ],
                      ),
                    ],
                  ),
                  //팔찌 옵션
                  accessoryType == AccessoryType.bracelet &&
                          accessory.tooltip.braceletOption != null
                      ? Row(
                          children: [
                            ...accessory.tooltip.braceletOption!
                                .map((option) => Text(
                                      "${option} ",
                                      style: TextStyle(
                                          color: K.appColor.braceletOptionColor,
                                          fontSize: 13,
                                          fontWeight: K.appFont.heavy),
                                    ))
                          ],
                        )
                      : SizedBox.shrink(),

                  Text(
                    //악세사리 이름
                    "${accessory!.name}",
                    style: TextStyle(
                        color: K.appColor.getGradeColor(accessory!.grade),
                        fontSize: 14,
                        fontWeight: K.appFont.heavy),
                  ),
                ],
              )
            ],
          ),
        );
      }
    }

    Widget equipemntContent() {
      return Container(
          width: 1000,
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
                                child: equipmentItem(type),
                              ))
                          .toList(),
                    ),
                    Column(
                      // 악세사리
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: AccessoryType.values
                          .map((type) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: accessoryItem(type),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ],
            ),
          ));
    }

// Card
    Widget cardContents() {
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

// 기본정보 (각인, 장비, 카드 등)
    Widget mainInfoContents() {
      return Column(
        children: [
          statsContent(),
          const SizedBox(
            height: 10,
          ),
          equipemntContent(),
          const SizedBox(
            height: 10,
          ),
          cardContents()
        ],
      );
    }

    Widget selectedTabView() {
      switch (viewModel.selectedTab) {
        case DetailViewTab.main:
          return mainInfoContents();

        case DetailViewTab.skill:
          return SkillContents(viewModel: viewModel);

        case DetailViewTab.armory:
          return ArmorySiblingContents(viewModel: viewModel);

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

    // 로딩 뷰
    Widget loadingView() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "유저 정보를 가져오는 중입니다!",
              style: TextStyle(
                  color: K.appColor.white,
                  fontSize: 14,
                  fontWeight: K.appFont.bold),
            ),
          ],
        ),
      );
    }

    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      appBar: TopBar(),
      body: viewModel.isLoading
          ? loadingView()
          : PrimaryScrollController(
              controller: _scrollController,
              child: Center(
                child: viewModel.info != null
                    ? Padding(
                        padding: const EdgeInsets.all(20),
                        child: ListView(
                          controller: _scrollController,
                          children: [
                            profileContents(),
                            const SizedBox(
                              height: 10,
                            ),

                            // 탭 버튼
                            SizedBox(
                              width: double.infinity,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: DetailViewTab.defaultOrder
                                      .map((tab) => tabButton(tab))
                                      .toList(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            // 탭에 따라 변경되는 화면
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 150),
                              transitionBuilder: (widget, animation) {
                                const curve = Curves.easeInOut;
                                var tween = Tween<double>(begin: 0.0, end: 1.0)
                                    .chain(CurveTween(curve: curve));
                                var opacityAnimation = animation.drive(tween);
                                return FadeTransition(
                                    opacity: opacityAnimation, child: widget);
                              },
                              child: selectedTabView(),
                            )
                          ],
                        ),
                      )
                    : characterNotFoundView(), // 캐릭터를 찾을 수 없음
              )),
      backgroundColor: K.appColor.mainBackgroundColor,
    );
  }
}
