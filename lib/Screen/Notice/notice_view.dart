import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Components/top_bar.dart';
import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Model/notice.dart';
import 'package:sample_project/Screen/Components/loading_view.dart';
import 'package:sample_project/Screen/Components/new_badge.dart';
import 'package:sample_project/Screen/Notice/notice_view_model.dart';
import 'package:sample_project/Screen/Web/web_view.dart';
import 'package:sprintf/sprintf.dart';

class NoticeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NoticeViewModel viewModel = Provider.of<NoticeViewModel>(context);

    return Scaffold(
      appBar: TopBar(title: "공지사항"),
      body: viewModel.isLoading
          ? const Center(
              child: const LoadingView(
                title: "공지사항을 가져오는 중입니다.",
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DropdownButton<String>(
                          dropdownColor: K.appColor.mainBackgroundColor,
                          underline: const SizedBox.shrink(),
                          value: viewModel.filter,
                          items: ["전체", "공지", "상점", "이벤트", "점검"]
                              .map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                    color: K.appColor.white,
                                    fontSize: 15,
                                    fontWeight: K.appFont.heavy),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? filter) {
                            viewModel.changeFilter(filter!);
                          },
                        )
                      ],
                    ),
                    Column(
                      children: viewModel.noticeList!
                          .map((e) => NoticeItem(notice: e))
                          .toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            disabledColor: K.appColor.gray,
                            color: K.appColor.white,
                            onPressed: viewModel.page == 1
                                ? null
                                : viewModel.firstPageButtonTap,
                            icon: const Icon(
                              Icons.keyboard_double_arrow_left,
                            )),
                        IconButton(
                            disabledColor: K.appColor.gray,
                            color: K.appColor.white,
                            onPressed: viewModel.page == 1
                                ? null
                                : viewModel.prevPageButtonTap,
                            icon: const Icon(
                              Icons.navigate_before,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${viewModel.page}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: K.appColor.white,
                              fontSize: 18,
                              fontWeight: K.appFont.heavy),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            disabledColor: K.appColor.gray,
                            color: K.appColor.white,
                            onPressed: viewModel.page == viewModel.maxPage
                                ? null
                                : viewModel.nextPageButtonTap,
                            icon: const Icon(
                              Icons.navigate_next,
                            )),
                        IconButton(
                            disabledColor: K.appColor.gray,
                            color: K.appColor.white,
                            onPressed: viewModel.page == viewModel.maxPage
                                ? null
                                : viewModel.lastPageButtonTap,
                            icon: const Icon(
                              Icons.keyboard_double_arrow_right,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
      backgroundColor: K.appColor.mainBackgroundColor,
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
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Flexible(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: K.appColor.white),
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(
                    notice.type,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: notice.typeColor,
                        fontSize: 15,
                        fontWeight: K.appFont.superHeavy),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: Text(
                  notice.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: K.appColor.white,
                      fontSize: 15,
                      fontWeight: K.appFont.heavy),
                )),
                if (notice.isNew) // 새로운 공지 뱃지
                  Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      NewBadge()
                    ],
                  ),
                const SizedBox(
                  width: 10,
                ),
              ],
            )),
            Text(
              //공지 날짜
              sprintf(
                  "%.2d.%.2d", [notice.dateTime.month, notice.dateTime.day]),
              style: TextStyle(
                  color: K.appColor.lightGray,
                  fontSize: 13,
                  fontWeight: K.appFont.heavy),
            )
          ],
        ),
      ),
    );
  }
}
