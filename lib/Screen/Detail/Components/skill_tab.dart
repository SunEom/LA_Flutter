//Skill Tab
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Model/Skills.dart';
import 'package:sample_project/Screen/Detail/detail_view_model.dart';

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
