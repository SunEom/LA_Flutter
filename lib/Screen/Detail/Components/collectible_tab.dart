import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Model/collectible.dart';
import 'package:sample_project/Screen/Components/network_image.dart';
import 'package:sample_project/Screen/Detail/detail_view_model.dart';
import 'package:sprintf/sprintf.dart';

class CollectibleTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DetailViewModel viewModel = Provider.of<DetailViewModel>(context);
    return Column(
      children: viewModel.info!.collectibles
          .map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CollectibleItem(collectible: e),
              ))
          .toList(),
    );
  }
}

class CollectibleItem extends StatelessWidget {
  final Collectible collectible;
  double get progress => collectible.point / collectible.maxPoint * 100;

  const CollectibleItem({required this.collectible});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NImage(
          url: collectible.icon,
          width: 60,
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              //악세사리 타입
              collectible.type,
              style: TextStyle(
                  color: K.appColor.white,
                  fontSize: 15,
                  fontWeight: K.appFont.heavy),
            ),
            Text(
              //악세사리 타입
              "${collectible.point} / ${collectible.maxPoint}",
              style: TextStyle(
                  color: K.appColor.white,
                  fontSize: 14,
                  fontWeight: K.appFont.heavy),
            ),
          ],
        )),
        Text(
          "진행도: ${sprintf("%.0f", [progress])}%",
          style: TextStyle(
              color: progress == 100 ? K.appColor.yellow : K.appColor.white,
              fontSize: 14,
              fontWeight: K.appFont.heavy),
        ),
      ],
    );
  }
}
