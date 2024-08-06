import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Model/notice.dart';
import 'package:sample_project/Screen/Home/home_view_model.dart';
import 'package:sample_project/Screen/Web/web_view.dart';

class NoticeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = Provider.of<HomeViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "공지사항",
          style: TextStyle(
              color: K.appColor.white,
              fontSize: 19,
              fontWeight: K.appFont.heavy),
        ),
        SizedBox(
          height: 5,
        ),
        viewModel.noticeList != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: viewModel.noticeList!
                    .sublist(0, 5)
                    .map((notice) => NoticeItem(notice: notice))
                    .toList(),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}

class NoticeItem extends StatelessWidget {
  final Notice notice;
  const NoticeItem({required this.notice});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebView(url: notice.link),
          ),
        );
      },
      child: Row(
        children: [
          Flexible(
            child: Text(
              "- ${notice.title}",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  color: K.appColor.white,
                  fontSize: 15,
                  fontWeight: K.appFont.heavy),
            ),
          ),
          if (notice.isNew) // Notice가 새로운 경우에만 Container를 표시
            Container(
              width: 16,
              height: 16,
              margin: EdgeInsets.only(left: 4), // 왼쪽 간격을 조정
              decoration: BoxDecoration(
                  color: K.appColor.red,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "N",
                  style: TextStyle(
                      color: K.appColor.white,
                      fontSize: 12,
                      fontWeight: K.appFont.heavy),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
