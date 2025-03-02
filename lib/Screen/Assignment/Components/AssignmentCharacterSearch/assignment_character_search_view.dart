import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Components/top_bar.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Model/sibling.dart';
import 'package:sample_project/Screen/Assignment/Components/AssignmentCharacterSearch/assignment_character_search_view_model.dart';
import 'package:sample_project/Screen/Components/character_image_view.dart';

class AssignmentCharacterSearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AssignmentCharacterSearchViewModel>(context);

    return Scaffold(
      backgroundColor: K.appColor.mainBackgroundColor,
      appBar: TopBar(
        title: '캐릭터 검색',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                viewModel.setNickname(value);
              },
              style: TextStyle(color: K.appColor.white),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                hintText: '캐릭터 이름을 입력하세요',
                hintStyle: TextStyle(color: K.appColor.lightGray),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: K.appColor.white,
                  ),
                  onPressed: () {
                    viewModel.searchCharacter();
                  },
                ),
              ),
            ),
            if (viewModel.characterInfo != null) // 검색한 캐릭터 정보가 있으면
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: AssignmentCharacterItem(
                  sibling: Sibling(
                    // 검색한 캐릭터 정보
                    serverName:
                        viewModel.characterInfo!.armoryProfile.serverName,
                    characterName:
                        viewModel.characterInfo!.armoryProfile.characterName,
                    characterLevel:
                        viewModel.characterInfo!.armoryProfile.characterLevel,
                    characterClassName: viewModel
                        .characterInfo!.armoryProfile.characterClassName,
                    itemAvgLevel:
                        viewModel.characterInfo!.armoryProfile.itemAvgLevel,
                    itemMaxLevel:
                        viewModel.characterInfo!.armoryProfile.itemMaxLevel,
                  ),
                ),
              ),
            if (viewModel.siblings != null &&
                viewModel.siblings!.isNotEmpty) // 숙제 기록중인 캐릭터가 있으면
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Divider(
                      color: K.appColor.gray,
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '원정대 캐릭터',
                          style: TextStyle(
                            color: K.appColor.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer()
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ...viewModel.siblings!.map((sibling) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: AssignmentCharacterItem(
                            sibling: sibling,
                          ),
                        )),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AssignmentCharacterItem extends StatelessWidget {
  final Sibling sibling;

  const AssignmentCharacterItem({
    required this.sibling,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AssignmentCharacterSearchViewModel>(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: viewModel.isAssignmentCharacter(sibling)
              ? K.appColor.green
              : K.appColor.gray,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(
        onPressed: () {
          viewModel.onTapCharacter(sibling);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            children: [
              ClipOval(
                child: CharacterImageView(
                  className: sibling.characterClassName,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          sibling.characterClassName,
                          style: TextStyle(
                            color: K.appColor.white,
                            fontSize: 12,
                            fontWeight: K.appFont.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          sibling.serverName,
                          style: TextStyle(
                            color: K.appColor.white,
                            fontSize: 12,
                            fontWeight: K.appFont.bold,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sibling.characterName,
                          style: TextStyle(
                            color: K.appColor.white,
                            fontSize: 14,
                            fontWeight: K.appFont.heavy,
                          ),
                        ),
                        Text(
                          sibling.itemAvgLevel,
                          style: TextStyle(
                            color: K.appColor.white,
                            fontSize: 12,
                            fontWeight: K.appFont.bold,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
