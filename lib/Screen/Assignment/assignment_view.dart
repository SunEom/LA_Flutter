import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Components/top_bar.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Screen/Assignment/Components/AssignmentCharacterSearch/assignment_character_search_view.dart';
import 'package:sample_project/Screen/Assignment/Components/AssignmentCharacterSearch/assignment_character_search_view_model.dart';
import 'package:sample_project/Screen/Assignment/assignment_view_model.dart';

class AssignmentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AssignmentViewModel>(context);

    return Scaffold(
      backgroundColor: K.appColor.mainBackgroundColor,
      appBar: TopBar(
        title: '숙제 기록장',
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text("캐릭터 목록",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: K.appColor.white)),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider.value(
                            value: AssignmentCharacterSearchViewModel(),
                            child: AssignmentCharacterSearchView(),
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.person_add_alt_outlined,
                      color: K.appColor.white,
                      size: 23,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
