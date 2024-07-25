import 'package:flutter/material.dart';
import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Screen/Search/search_view_model.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = SearchViewModel();
    return Scaffold(
        appBar: AppBar(
          title: Text("유저 검색"),
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
        ),
        body: contentView(),
        backgroundColor: K.appColor.mainBackgroundColor);
  }

  Widget contentView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: '닉네임을 입력하세요.',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.search))
            ],
          ),
        ],
      ),
    );
  }
}
