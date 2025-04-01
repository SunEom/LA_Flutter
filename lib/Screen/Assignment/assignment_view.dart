import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Components/top_bar.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Model/adventrue_island.dart';
import 'package:sample_project/Model/assignment_character.dart';
import 'package:sample_project/Screen/Assignment/Components/AssignmentCharacterSearch/assignment_character_search_view.dart';
import 'package:sample_project/Screen/Assignment/Components/AssignmentCharacterSearch/assignment_character_search_view_model.dart';
import 'package:sample_project/Screen/Assignment/Components/AssignmentList/assignment_list_view.dart';
import 'package:sample_project/Screen/Assignment/Components/AssignmentList/assignment_list_view_model.dart';
import 'package:sample_project/Screen/Assignment/assignment_view_model.dart';
import 'package:sample_project/Screen/Components/character_image_view.dart';
import 'package:sample_project/Screen/Components/loading_view.dart';
import 'package:sample_project/Screen/Components/network_image.dart';
import 'package:sample_project/Util/number_util.dart';

class AssignmentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AssignmentViewModel>(context);

    return Scaffold(
      backgroundColor: K.appColor.mainBackgroundColor,
      appBar: TopBar(
        title: '숙제 리스트',
      ),
      body: viewModel.isLoading
          ? const LoadingView(title: "숙제 정보를 가져오는 중 입니다!")
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text("캐릭터 목록",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: K.appColor.white)),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider.value(
                                      value:
                                          AssignmentCharacterSearchViewModel(),
                                      child: AssignmentCharacterSearchView(),
                                    ),
                                  ),
                                ).whenComplete(() {
                                  viewModel.refreshData();
                                });
                              },
                              icon: Icon(
                                Icons.person_add_alt_outlined,
                                color: K.appColor.white,
                                size: 23,
                              ))
                        ],
                      ),
                    ),
                    if (viewModel.assignmentCharacters.isNotEmpty)
                      ...viewModel.assignmentCharacters
                          .map((character) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: AssignmentCharacterItem(
                                    character: character),
                              )),
                  ],
                ),
              ),
            ),
    );
  }
}

class AssignmentCharacterItem extends StatelessWidget {
  final AssignmentCharacter character;

  const AssignmentCharacterItem({
    required this.character,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AssignmentViewModel>(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: K.appColor.gray,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                ClipOval(
                  child: CharacterImageView(
                    className: character.characterClassName,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            character.serverName,
                            style: TextStyle(
                              color: K.appColor.white,
                              fontSize: 12,
                              fontWeight: K.appFont.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            character.characterClassName,
                            style: TextStyle(
                              color: K.appColor.white,
                              fontSize: 12,
                              fontWeight: K.appFont.bold,
                            ),
                          )
                        ],
                      ),
                      Text(
                        character.characterName,
                        style: TextStyle(
                          color: K.appColor.white,
                          fontSize: 14,
                          fontWeight: K.appFont.heavy,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  color: K.appColor.lightGray,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                          value: AssignmentListViewModel(character),
                          child: AssignmentListView(),
                        ),
                      ),
                    ).whenComplete(() {
                      viewModel.refreshData();
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  color: K.appColor.lightGray,
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "숙제 초기화",
                            style: TextStyle(
                                color: K.appColor.white,
                                fontSize: 14,
                                fontWeight: K.appFont.heavy),
                          ),
                          content: Text(
                            character.characterName + '의 숙제를 초기화 하시겠습니까?',
                            style: TextStyle(
                                color: K.appColor.white,
                                fontSize: 13,
                                fontWeight: K.appFont.bold),
                          ),
                          backgroundColor: K.appColor.mainBackgroundColor,
                          actions: <Widget>[
                            ElevatedButton(
                              child: Text('취소',
                                  style:
                                      TextStyle(fontWeight: K.appFont.heavy)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: K.appColor.deepPurple,
                              ),
                              child: Text(
                                '확인',
                                style: TextStyle(
                                    color: K.appColor.white,
                                    fontWeight: K.appFont.heavy),
                              ),
                              onPressed: () {
                                viewModel.onClickResetCharacterAssignmentButton(
                                    character);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  color: K.appColor.lightGray,
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "숙제 캐릭터 삭제",
                            style: TextStyle(
                                color: K.appColor.red,
                                fontSize: 14,
                                fontWeight: K.appFont.heavy),
                          ),
                          content: Text(
                            character.characterName + '를 숙제 캐릭터 목록에서 삭제하시겠습니까?',
                            style: TextStyle(
                                color: K.appColor.white,
                                fontSize: 13,
                                fontWeight: K.appFont.bold),
                          ),
                          backgroundColor: K.appColor.mainBackgroundColor,
                          actions: <Widget>[
                            ElevatedButton(
                              child: Text('취소',
                                  style:
                                      TextStyle(fontWeight: K.appFont.heavy)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: K.appColor.red,
                              ),
                              child: Text(
                                '삭제',
                                style: TextStyle(
                                    color: K.appColor.white,
                                    fontWeight: K.appFont.heavy),
                              ),
                              onPressed: () {
                                viewModel
                                    .onClickRemoveAssignmentCharacterButton(
                                        character);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
          ...character.assignments.map((assignment) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            assignment.title +
                                ' [' +
                                assignment.difficulty +
                                '] ' +
                                assignment.stage +
                                '관문',
                            style: TextStyle(
                              color: K.appColor.white,
                              fontSize: 14,
                              fontWeight: K.appFont.heavy,
                            )),
                        Row(
                          children: [
                            Text(
                              NumberUtil.getCommaStringNumber(assignment.gold),
                              style: TextStyle(
                                color: K.appColor.yellow,
                                fontSize: 13,
                                fontWeight: K.appFont.heavy,
                              ),
                            ),
                            const SizedBox(width: 3),
                            NImage(url: MainRewardType.gold.icon, width: 15)
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    Checkbox(
                      value: assignment.isCompleted,
                      onChanged: (value) {
                        if (value != null) {
                          viewModel.onClickCheckBox(
                              character, assignment, value);
                        }
                      },
                    ),
                  ],
                ),
              )),
          Divider(
            color: K.appColor.gray,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                "획득 골드",
                style: TextStyle(
                    color: K.appColor.white, fontWeight: K.appFont.heavy),
              ),
              const Spacer(),
              Text(
                viewModel.getEarnGold(character),
                style: TextStyle(
                  color: K.appColor.yellow,
                  fontSize: 13,
                  fontWeight: K.appFont.heavy,
                ),
              ),
              const SizedBox(width: 3),
              NImage(url: MainRewardType.gold.icon, width: 15),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                "총 골드",
                style: TextStyle(
                    color: K.appColor.white, fontWeight: K.appFont.heavy),
              ),
              const Spacer(),
              Text(
                viewModel.getTotalGold(character.assignments),
                style: TextStyle(
                  color: K.appColor.yellow,
                  fontSize: 13,
                  fontWeight: K.appFont.heavy,
                ),
              ),
              const SizedBox(width: 3),
              NImage(url: MainRewardType.gold.icon, width: 15),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
