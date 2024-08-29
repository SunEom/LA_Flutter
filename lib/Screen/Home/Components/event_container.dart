import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Screen/Components/info_badge.dart';
import 'package:sample_project/Screen/Components/network_image.dart';
import 'package:sample_project/Screen/Home/home_view_model.dart';
import 'package:sample_project/Screen/Web/web_view.dart';
import 'package:sample_project/Util/datetime_util.dart';

class EventContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = Provider.of<HomeViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "진행중인 이벤트",
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
                    msg: '진행중인 이벤트는 주 1회 갱신됩니다 🥲',
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
        ),
        if (viewModel.eventList != null)
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: true, enlargeCenterPage: true, enlargeFactor: 0.35),
            items: viewModel.eventList?.map((event) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebView(url: event.link),
                          ),
                        );
                      },
                      child: NImage(
                        url: event.thumbnail,
                      ));
                },
              );
            }).toList(),
          ),
      ],
    );
  }
}
