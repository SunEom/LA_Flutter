import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/Components/top_bar.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Model/adventrue_island.dart';
import 'package:sample_project/Model/assignment_character.dart';
import 'package:sample_project/Screen/Assignment/Components/AssignmentCharacterSearch/assignment_character_search_view.dart';
import 'package:sample_project/Screen/Assignment/Components/AssignmentCharacterSearch/assignment_character_search_view_model.dart';
import 'package:sample_project/Screen/Assignment/Components/AssignmentList/assignment_list_view.dart';
import 'package:sample_project/Screen/Assignment/Components/AssignmentList/assignment_list_view_model.dart';
import 'package:sample_project/Screen/Assignment/assignment_view_model.dart';
import 'package:sample_project/Screen/Components/character_image_view.dart';
import 'package:sample_project/Screen/Components/loading_view.dart';
import 'package:sample_project/Screen/Components/network_image.dart';
import 'package:sample_project/Util/number_util.dart';

class AssignmentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AssignmentViewModel>(context);

    return Scaffold(
      backgroundColor: K.appColor.mainBackgroundColor,
      appBar: TopBar(
        title: '숙제 리스트',
      ),
      body: viewModel.isLoading
          ? const LoadingView(title: "숙제 정보를 가져오는 중 입니다!")
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50, left: 15, right: 15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    WeeklyGoldCard(
                      viewModel: viewModel,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("캐릭터 목록",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: K.appColor.white)),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "숙제 초기화",
                                    style: TextStyle(
                                        color: K.appColor.white,
                                        fontSize: 14,
                                        fontWeight: K.appFont.heavy),
                                  ),
                                  content: Text(
                                    '모든 숙제 목록을 초기화하시겠습니까?',
                                    style: TextStyle(
                                        color: K.appColor.white,
                                        fontSize: 13,
                                        fontWeight: K.appFont.bold),
                                  ),
                                  backgroundColor:
                                      K.appColor.mainBackgroundColor,
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: Text('취소',
                                          style: TextStyle(
                                              fontWeight: K.appFont.heavy)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: K.appColor.deepPurple,
                                      ),
                                      child: Text(
                                        '확인',
                                        style: TextStyle(
                                            color: K.appColor.white,
                                            fontWeight: K.appFont.heavy),
                                      ),
                                      onPressed: () {
                                        viewModel
                                            .onClickResetAllAssignmentButton();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.refresh_outlined,
                                color: K.appColor.white,
                                size: 30,
                              ),
                              Text(
                                "A",
                                style: TextStyle(
                                    color: K.appColor.white,
                                    fontWeight: K.appFont.superHeavy,
                                    fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChangeNotifierProvider.value(
                                    value: AssignmentCharacterSearchViewModel(),
                                    child: AssignmentCharacterSearchView(),
                                  ),
                                ),
                              ).whenComplete(() {
                                viewModel.refreshData();
                              });
                            },
                            icon: Icon(
                              Icons.person_add_alt_outlined,
                              color: K.appColor.white,
                              size: 23,
                            ))
                      ],
                    ),
                    if (viewModel.assignmentCharacters.isNotEmpty)
                      ...viewModel.assignmentCharacters.map((character) =>
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child:
                                AssignmentCharacterItem(character: character),
                          )),
                  ],
                ),
              ),
            ),
    );
  }
}

class AssignmentCharacterItem extends StatelessWidget {
  final AssignmentCharacter character;

  const AssignmentCharacterItem({
    required this.character,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AssignmentViewModel>(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: K.appColor.gray,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                ClipOval(
                  child: CharacterImageView(
                    className: character.characterClassName,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            character.serverName,
                            style: TextStyle(
                              color: K.appColor.white,
                              fontSize: 12,
                              fontWeight: K.appFont.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            character.characterClassName,
                            style: TextStyle(
                              color: K.appColor.white,
                              fontSize: 12,
                              fontWeight: K.appFont.bold,
                            ),
                          )
                        ],
                      ),
                      Text(
                        character.characterName,
                        style: TextStyle(
                          color: K.appColor.white,
                          fontSize: 14,
                          fontWeight: K.appFont.heavy,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  color: K.appColor.lightGray,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                          value: AssignmentListViewModel(character),
                          child: AssignmentListView(),
                        ),
                      ),
                    ).whenComplete(() {
                      viewModel.refreshData();
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  color: K.appColor.lightGray,
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "숙제 초기화",
                            style: TextStyle(
                                color: K.appColor.white,
                                fontSize: 14,
                                fontWeight: K.appFont.heavy),
                          ),
                          content: Text(
                            character.characterName + '의 숙제를 초기화 하시겠습니까?',
                            style: TextStyle(
                                color: K.appColor.white,
                                fontSize: 13,
                                fontWeight: K.appFont.bold),
                          ),
                          backgroundColor: K.appColor.mainBackgroundColor,
                          actions: <Widget>[
                            ElevatedButton(
                              child: Text('취소',
                                  style:
                                      TextStyle(fontWeight: K.appFont.heavy)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: K.appColor.deepPurple,
                              ),
                              child: Text(
                                '확인',
                                style: TextStyle(
                                    color: K.appColor.white,
                                    fontWeight: K.appFont.heavy),
                              ),
                              onPressed: () {
                                viewModel.onClickResetCharacterAssignmentButton(
                                    character);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  color: K.appColor.lightGray,
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "숙제 캐릭터 삭제",
                            style: TextStyle(
                                color: K.appColor.red,
                                fontSize: 14,
                                fontWeight: K.appFont.heavy),
                          ),
                          content: Text(
                            character.characterName + '를 숙제 캐릭터 목록에서 삭제하시겠습니까?',
                            style: TextStyle(
                                color: K.appColor.white,
                                fontSize: 13,
                                fontWeight: K.appFont.bold),
                          ),
                          backgroundColor: K.appColor.mainBackgroundColor,
                          actions: <Widget>[
                            ElevatedButton(
                              child: Text('취소',
                                  style:
                                      TextStyle(fontWeight: K.appFont.heavy)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: K.appColor.red,
                              ),
                              child: Text(
                                '삭제',
                                style: TextStyle(
                                    color: K.appColor.white,
                                    fontWeight: K.appFont.heavy),
                              ),
                              onPressed: () {
                                viewModel
                                    .onClickRemoveAssignmentCharacterButton(
                                        character);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
          ...character.assignments.map((assignment) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
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
                    const Spacer(),
                    Checkbox(
                      value: assignment.isCompleted,
                      onChanged: (value) {
                        if (value != null) {
                          viewModel.onClickCheckBox(
                              character, assignment, value);
                        }
                      },
                    ),
                  ],
                ),
              )),
          Divider(
            color: K.appColor.gray,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                "획득 골드",
                style: TextStyle(
                    color: K.appColor.white, fontWeight: K.appFont.heavy),
              ),
              const Spacer(),
              Text(
                viewModel.getEarnGold(character),
                style: TextStyle(
                  color: K.appColor.yellow,
                  fontSize: 13,
                  fontWeight: K.appFont.heavy,
                ),
              ),
              const SizedBox(width: 3),
              NImage(url: MainRewardType.gold.icon, width: 15),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                "총 골드",
                style: TextStyle(
                    color: K.appColor.white, fontWeight: K.appFont.heavy),
              ),
              const Spacer(),
              Text(
                viewModel.getTotalGold(character.assignments),
                style: TextStyle(
                  color: K.appColor.yellow,
                  fontSize: 13,
                  fontWeight: K.appFont.heavy,
                ),
              ),
              const SizedBox(width: 3),
              NImage(url: MainRewardType.gold.icon, width: 15),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}

class WeeklyGoldCard extends StatefulWidget {
  final AssignmentViewModel viewModel;

  const WeeklyGoldCard({super.key, required this.viewModel});

  @override
  State<WeeklyGoldCard> createState() => _WeeklyGoldCardState();
}

class _WeeklyGoldCardState extends State<WeeklyGoldCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: widget.viewModel.weeklyProgress,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    widget.viewModel.addListener(_onViewModelUpdated);
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.viewModel.removeListener(_onViewModelUpdated);
    super.dispose();
  }

  void _onViewModelUpdated() {
    _animation = Tween<double>(
      begin: _animation.value,
      end: widget.viewModel.weeklyProgress,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final vm = widget.viewModel;

    return Center(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 16,
              spreadRadius: 4,
              offset: const Offset(0, 8),
            ),
          ],
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(30, 33, 38, 1),
              Color.fromRGBO(21, 24, 29, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Card(
          color: Colors.transparent,
          elevation: 12,
          shadowColor: Colors.black.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.auto_awesome,
                        color: Colors.amberAccent, size: 32),
                    const SizedBox(width: 8),
                    Text(
                      '이번 주 골드',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent.shade200,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.amberAccent.withOpacity(0.7),
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  '${NumberUtil.getCommaNumber(vm.weeklyEarnedGold)} / ${NumberUtil.getCommaNumber(vm.weeklyTotalGold)} 골드',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: K.appFont.heavy,
                    color: K.appColor.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${(vm.weeklyProgress * 100).toStringAsFixed(1)}% 달성 🎯',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: K.appFont.heavy,
                      color: K.appColor.white),
                ),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value: _animation.value,
                        minHeight: 12,
                        backgroundColor: K.appColor.lightGray,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.amberAccent.shade200),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '목표까지 ${NumberUtil.getCommaNumber(vm.weeklyTotalGold - vm.weeklyEarnedGold)} 골드 남음',
                    style: TextStyle(fontSize: 12, color: K.appColor.lightGray),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
