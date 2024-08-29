import 'package:flutter/material.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Model/notice.dart';
import 'package:sample_project/Screen/Components/info_badge.dart';
import 'package:sample_project/Screen/Home/home_view_model.dart';
import 'package:sample_project/Screen/Components/new_badge.dart';
import 'package:sample_project/Screen/Notice/notice_view.dart';
import 'package:sample_project/Screen/Notice/notice_view_model.dart';
import 'package:sample_project/Screen/Web/web_view.dart';

class NoticeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = Provider.of<HomeViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  "공지사항",
                  style: TextStyle(
                      color: K.appColor.white,
                      fontSize: 19,
                      fontWeight: K.appFont.heavy),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Dialogs.materialDialog(
                      msg: '진행중인 이벤트는 하루 1회 갱신됩니다 🥲',
                      title: "알림",
                      color: K.appColor.mainBackgroundColor,
                      context: context,
                      titleStyle: TextStyle(color: K.appColor.white),
                      msgStyle: TextStyle(color: K.appColor.white),
                    );
                  },
                  child: InfoBadge(),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                              value: NoticeViewModel(),
                              child: NoticeView(),
                            )));
              },
              child: Text(
                "더보기",
                style: TextStyle(
                    color: K.appColor.white,
                    fontSize: 14,
                    fontWeight: K.appFont.heavy),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        if (viewModel.noticeList != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: viewModel.noticeList!
                .sublist(0, 5)
                .map((notice) => NoticeItem(notice: notice))
                .toList(),
          )
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
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                NewBadge()
              ],
            ),
        ],
      ),
    );
  }
}
