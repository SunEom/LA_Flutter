import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Components/top_bar.dart';
import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Screen/Detail/detail_view.dart';
import 'package:sample_project/Screen/Detail/detail_view_model.dart';
import 'package:sample_project/Screen/Home/home_view_model.dart';
import 'package:sample_project/Screen/Search/search.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    Widget searchContainerTitle() {
      return Text(
        "유저 검색",
        style: TextStyle(color: Colors.white, fontSize: 15),
      );
    }

    Widget searchBar() {
      return Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: "가니잇",
              onChanged: (value) {
                viewModel.nicknameChanged(value);
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: '닉네임을 입력하세요.',
                hintStyle: TextStyle(color: Colors.white54),
                border: UnderlineInputBorder(),
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
              icon: Icon(Icons.search))
        ],
      );
    }

    Widget searchContainer() {
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
          padding: EdgeInsets.all(30),
          child: Column(
            children: [searchContainerTitle(), searchBar()],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: TopBar(),
      body: Center(
          child: Container(
        width: 1000,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: searchContainer(),
            )
          ],
        ),
      )),
      backgroundColor: K.appColor.mainBackgroundColor,
    );
  }
}
