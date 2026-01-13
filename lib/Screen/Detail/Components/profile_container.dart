// Profile
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Screen/Components/network_image.dart';
import 'package:sample_project/Screen/Detail/detail_view_model.dart';

class CharacterImage extends StatelessWidget {
  final String? imageUrl;

  const CharacterImage({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? NImage(
            url: imageUrl!,
            width: 150,
          )
        : const SizedBox(
            width: 150,
            child: Text('Image not available'),
          );
  }
}

class ProfileItem extends StatelessWidget {
  final String title;
  final String content;

  const ProfileItem({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white70),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(title,
                style: TextStyle(color: K.appColor.white, fontSize: 14))),
        const SizedBox(width: 10),
        SizedBox(
          width: 80,
          child: AutoSizeText(
            content,
            maxLines: 1,
            minFontSize: 5,
            maxFontSize: 15,
            overflow: TextOverflow.ellipsis,
            style:
                TextStyle(color: K.appColor.white, fontWeight: K.appFont.heavy),
            textAlign: TextAlign.left,
          ),
        )
      ],
    );
  }
}

class ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DetailViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        ProfileItem(
            title: "서버",
            content: "${viewModel.info?.armoryProfile.serverName}"),
        const SizedBox(height: 5),
        ProfileItem(
            title: "길드",
            content: "${viewModel.info?.armoryProfile.guildName ?? "-"}"),
        const SizedBox(height: 5),
        ProfileItem(
            title: "클래스",
            content: "${viewModel.info?.armoryProfile.characterClassName}"),
        const SizedBox(height: 5),
        ProfileItem(
            title: "칭호",
            content: "${viewModel.info?.armoryProfile.title ?? "-"}"),
        const SizedBox(height: 5),
        ProfileItem(
            title: "전투 Lv",
            content: "${viewModel.info?.armoryProfile.characterLevel}"),
        const SizedBox(height: 5),
        ProfileItem(
            title: "아이템 Lv",
            content: "${viewModel.info?.armoryProfile.itemAvgLevel}"),
        const SizedBox(height: 5),
        ProfileItem(
            title: "전투력",
            content: "${viewModel.info?.armoryProfile.combatPower}"),
        const SizedBox(height: 5),
        ProfileItem(
            title: "원정대 Lv",
            content: "${viewModel.info?.armoryProfile.expeditionLevel}"),
      ],
    );
  }
}

class ProfileContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DetailViewModel>(context);

    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: K.appColor.gray, width: 2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        viewModel.info!.armoryProfile.characterName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: K.appColor.white,
                            fontWeight: K.appFont.heavy,
                            fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                      IconButton(
                          onPressed: viewModel.favButtonTap,
                          icon: Icon(
                            Icons.star,
                            size: 23,
                            color: viewModel.isFavCharacter
                                ? K.appColor.yellow
                                : K.appColor.gray,
                          ))
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileInfo(),
                    CharacterImage(
                        imageUrl: viewModel.info?.armoryProfile.characterImage),
                  ],
                ),
              ],
            )));
  }
}
