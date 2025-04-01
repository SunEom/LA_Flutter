import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Components/top_bar.dart';
import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Model/adventrue_island.dart';
import 'package:sample_project/Model/assignment.dart';
import 'package:sample_project/Screen/Assignment/Components/AssignmentList/assignment_list_view_model.dart';
import 'package:sample_project/Screen/Components/loading_view.dart';
import 'package:sample_project/Screen/Components/network_image.dart';
import 'package:sample_project/Util/number_util.dart';

class AssignmentListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AssignmentListViewModel>(context);

    return Scaffold(
        appBar: TopBar(title: "레이드 목록"),
        backgroundColor: K.appColor.mainBackgroundColor,
        body: viewModel.isLoading
            ? const LoadingView(title: "레이드 목록을 가져오는 중 입니다!")
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: viewModel.assignments
                      .map((assignment) => Column(
                            children: [
                              AssignmentItem(
                                assignment: assignment,
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ))
                      .toList(),
                ),
              ));
  }
}

class AssignmentItem extends StatelessWidget {
  final Assignment assignment;

  const AssignmentItem({
    required this.assignment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AssignmentListViewModel>(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: viewModel.isContainCurrentAssignmentList(assignment)
              ? K.appColor.green
              : K.appColor.gray,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  assignment.title +
                      ' [' +
                      assignment.difficulty +
                      '] ' +
                      assignment.stage +
                      '관문',
                  style: TextStyle(
                    color: K.appColor.white,
                    fontSize: 14,
                    fontWeight: K.appFont.heavy,
                  )),
              Row(
                children: [
                  Text(
                    NumberUtil.getCommaStringNumber(assignment.gold),
                    style: TextStyle(
                      color: K.appColor.yellow,
                      fontSize: 13,
                      fontWeight: K.appFont.heavy,
                    ),
                  ),
                  const SizedBox(width: 3),
                  NImage(url: MainRewardType.gold.icon, width: 15)
                ],
              )
            ],
          ),
          Checkbox(
              value: viewModel.isContainCurrentAssignmentList(assignment),
              activeColor: K.appColor.green,
              onChanged: (e) {
                if (e != null) {
                  viewModel.onClickCheckBox(e!, assignment);
                }
              })
        ],
      ),
    );
  }
}
