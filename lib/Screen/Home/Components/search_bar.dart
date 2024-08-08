import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Model/alert_data.dart';
import 'package:sample_project/Screen/Components/loading_view.dart';
import 'package:sample_project/Screen/Components/network_image.dart';
import 'package:sample_project/Screen/Detail/detail_view.dart';
import 'package:sample_project/Screen/Detail/detail_view_model.dart';
import 'package:sample_project/Screen/Home/home_view_model.dart';
import 'package:sample_project/Util/alert_util.dart';
import 'package:widget_visibility_detector/widget_visibility_detector.dart';

class SearchContainerTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "유저 검색",
      style: TextStyle(
          color: K.appColor.white, fontSize: 15, fontWeight: K.appFont.heavy),
    );
  }
}

class SearchBar extends StatelessWidget {
  final HomeViewModel viewModel;

  const SearchBar({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: BorderDirectional(
              bottom: BorderSide(color: K.appColor.gray, width: 2))),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              keyboardAppearance: MediaQuery.of(context).platformBrightness,
              onChanged: (value) {
                viewModel.nicknameChanged(value);
              },
              onFieldSubmitted: (value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                              value: DetailViewModel(viewModel.nickname),
                              child: DetailView(),
                            )));
              },
              style: TextStyle(color: K.appColor.white, fontSize: 15),
              decoration: InputDecoration(
                hintText: '닉네임을 입력하세요.',
                hintStyle: TextStyle(color: K.appColor.lightGray, fontSize: 15),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                if (viewModel.nickname == "") {
                  AlertUtil.showAlertDialogWithOneButton(context,
                      const AlertData(title: "알림", body: "닉네임을 입력해주세요!"));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider.value(
                                value: DetailViewModel(viewModel.nickname),
                                child: DetailView(),
                              )));
                }
              },
              icon: Icon(
                Icons.search,
                color: K.appColor.lightGray,
              ))
        ],
      ),
    );
  }
}

class SearchContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return WidgetVisibilityDetector(
        onAppear: () {
          viewModel.fetchFavoriteCharacter();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(2, 2), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                SearchContainerTitle(),
                SearchBar(
                  viewModel: viewModel,
                ),
                const SizedBox(
                  height: 10,
                ),
                FavoriteCharacterContainer(),
              ],
            ),
          ),
        ));
  }
}

class FavoriteCharacterContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = Provider.of<HomeViewModel>(context);

    if (viewModel.favoriteCharacterLoading) {
      return const Padding(
          padding: EdgeInsets.only(top: 20),
          child: LoadingView(title: "유저 정보를 가져오는 중입니다!"));
    } else {
      return viewModel.favoriteCharacter == null
          ? DottedBorder(
              // 즐겨찾기한 캐릭터가 없는 경우
              dashPattern: const [6, 6],
              strokeWidth: 2,
              color: K.appColor.lightGray,
              padding: const EdgeInsets.all(30),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "캐릭터를 검색하고",
                          style: TextStyle(
                              color: K.appColor.white,
                              fontSize: 14,
                              fontWeight: K.appFont.heavy),
                        ),
                        Icon(
                          Icons.star,
                          color: K.appColor.yellow,
                        ),
                        Text(
                          "버튼을 눌러",
                          style: TextStyle(
                              color: K.appColor.white,
                              fontSize: 14,
                              fontWeight: K.appFont.heavy),
                        )
                      ],
                    ),
                    Text(
                      "즐겨찾기에 등록해보세요.",
                      style: TextStyle(
                          color: K.appColor.white,
                          fontSize: 14,
                          fontWeight: K.appFont.heavy),
                    )
                  ],
                ),
              ))
          : GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                              value: DetailViewModel(
                                  viewModel.favoriteCharacter!.name),
                              child: DetailView(),
                            )));
              },
              child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: K.appColor.gray),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 20, 10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: K.appColor.yellow,
                              size: 17,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                "즐겨찾기",
                                style: TextStyle(
                                    color: K.appColor.white,
                                    fontSize: 14,
                                    fontWeight: K.appFont.heavy),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                viewModel.removeFavButtonTap();
                              },
                              child: Icon(
                                Icons.close,
                                color: K.appColor.lightGray,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            NImage(
                              url: K.appImage.getClassImage(
                                  viewModel.favoriteCharacter!.className),
                              width: 40,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                              viewModel.favoriteCharacter!
                                                  .serverName,
                                              style: TextStyle(
                                                  color: K.appColor.white,
                                                  fontSize: 13,
                                                  fontWeight:
                                                      K.appFont.heavy))),
                                      Text(
                                          viewModel
                                              .favoriteCharacter!.className,
                                          style: TextStyle(
                                              color: K.appColor.white,
                                              fontSize: 13,
                                              fontWeight: K.appFont.heavy)),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Text(
                                              viewModel.favoriteCharacter!.name,
                                              style: TextStyle(
                                                  color: K.appColor.white,
                                                  fontSize: 17,
                                                  fontWeight:
                                                      K.appFont.heavy))),
                                      Text(
                                          viewModel
                                              .favoriteCharacter!.itemAvgLevel
                                              .split(".")
                                              .first,
                                          style: TextStyle(
                                              color: K.appColor.white,
                                              fontSize: 14,
                                              fontWeight: K.appFont.heavy)),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                          ],
                        )
                      ],
                    ),
                  )),
            );
    }
  }
}
