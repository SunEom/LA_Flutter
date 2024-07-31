import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Screen/Detail/detail_view.dart';
import 'package:sample_project/Screen/Detail/detail_view_model.dart';
import 'package:sample_project/Screen/Home/home_view_model.dart';

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
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: "가니잇",
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
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider.value(
                            value: DetailViewModel(viewModel.nickname),
                            child: DetailView(),
                          )));
            },
            icon: const Icon(Icons.search))
      ],
    );
  }
}

class SearchContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return Container(
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
    );
  }
}

class FavoriteCharacterContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
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
        ));
  }
}
