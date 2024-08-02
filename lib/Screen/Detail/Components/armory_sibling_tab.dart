//ArmorySibling Tab

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Model/Sibling.dart';
import 'package:sample_project/Screen/Detail/detail_view_model.dart';

class ArmorySiblingContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController controller = PrimaryScrollController.of(context);
    final viewModel = Provider.of<DetailViewModel>(context);

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
  final ScrollController scrollController;

  const ArmorySiblingItem(
      {required this.sibling, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DetailViewModel>(context);
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
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      K.appImage.getClassImage(sibling.characterClassName),
                      width: 40,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
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
                  ))
                ],
              ))),
    );
  }
}
