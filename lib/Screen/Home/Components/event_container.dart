import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Screen/Home/home_view_model.dart';
import 'package:sample_project/Screen/Web/web_view.dart';

class EventContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = Provider.of<HomeViewModel>(context);
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "진행중인 이벤트",
            style: TextStyle(
                color: K.appColor.white,
                fontSize: 19,
                fontWeight: K.appFont.heavy),
          ),
          viewModel.eventList != null
              ? CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3),
                  items: viewModel.eventList?.map((event) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WebView(url: event.link),
                                ),
                              );
                            },
                            child: Container(
                              child: Image.network(
                                event.thumbnail,
                              ),
                            ));
                      },
                    );
                  }).toList(),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
