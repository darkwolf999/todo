import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/all_tasks_screen/all_tasks_screen_bloc.dart';

import 'package:todo/constants.dart' as Constants;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/data/models/taskModel.dart';
import 'package:todo/presentation/models/tasks_filter.dart';
import 'package:todo/presentation/screens/task_detail.dart';
import 'package:todo/presentation/widgets/check_button.dart';
import 'package:todo/presentation/widgets/svg.dart';
import 'dart:developer' as developer;

import 'package:todo/repositories/tasks_repository.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllTasksScreenBloc>(
      create: (context) =>
      AllTasksScreenBloc(
        context.read<TasksRepository>(),
      )
        ..add(const SubscribeStreamEvent()),
      child: const AllTasksScreenContent(),
    );
  }
}

class AllTasksScreenContent extends StatelessWidget {
  const AllTasksScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AllTasksScreenBloc>();
    return Scaffold(
      backgroundColor: const Color(Constants.lightBackPrimary),
      body: BlocBuilder<AllTasksScreenBloc, AllTasksScreenState>(
        builder: (context, state) {
          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                snap: false,
                floating: true,
                expandedHeight: 88.0,
                //actions: [],
                flexibleSpace: FlexibleSpaceBar(
                title: Text(
                    'Мои дела',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Color(Constants.lightLabelPrimary),
                      fontSize: Constants.titleFontSize,
                      height: Constants.titleFontHeight,
                    ),
                  ),
                  // background: Container(
                  //   height: 80,
                  //   //color: Colors.redAccent,
                  //   child: const Center(
                  //     child:  Text(
                  //       'Categories Page',
                  //       style: TextStyle(
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 20),
                  //     ),
                  //   ),
                  // ),
                ),
                // flexibleSpace: FlexibleSpaceBar(
                //   //titlePadding:
                //   //EdgeInsets.only(left: 16.0, top: 48.0, bottom: 16.0),
                //   title: Text(
                //     'Мои дела',
                //     style: TextStyle(
                //       fontFamily: 'Roboto',
                //       color: Color(Constants.lightLabelPrimary),
                //       fontSize: Constants.titleFontSize,
                //       height: Constants.titleFontHeight,
                //     ),
                //   ),
                // ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 60.0, top: 2.0, bottom: 16.0),
                  child: SizedBox(
                    height: 24,
                    child: Text(
                      'Выполнено — ${bloc.state.completedTasksCount}',
                      style: TextStyle(
                        color: Color(Constants.lightLabelTertiary),
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Card(
                        color: Color(Constants.lightBackSecondary),
                        //color: Colors.amberAccent,
                        semanticContainer: false,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        elevation: 4,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                              child: ListView.builder(
                                //padding: EdgeInsets.only(top: 8),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                //itemCount: _theList.length,
                                itemCount: bloc.state.filteredTasks.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Dismissible(
                                    key: Key(
                                      bloc.state.filteredTasks[index].uuid,
                                    ),
                                    confirmDismiss: (direction) =>
                                      confirmDismissing(direction, bloc, index),
                                    onDismissed: (_) =>
                                      bloc.add(
                                        DeleteTaskEvent(
                                          bloc.state.filteredTasks?[index].uuid ?? '0'
                                        ),
                                      ),
                                    background: Container(
                                      color: Color((bloc.state.filteredTasks?[index].isDone ?? false) ? Constants.lightColorGrayLight : Constants.lightColorGreen),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(left: 24.0),
                                        child: SvgPicture.asset(
                                          Constants.check,
                                          semanticsLabel: 'delete',
                                          alignment: Alignment.centerLeft,
                                          fit: BoxFit.scaleDown,
                                          colorFilter: ColorFilter.mode(
                                            Color(Constants.lightColorWhite),
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                    secondaryBackground: Container(
                                      color:
                                      const Color(Constants.lightColorRed),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(right: 24.0),
                                        child: SvgPicture.asset(
                                          Constants.delete,
                                          semanticsLabel: 'check',
                                          alignment: Alignment.centerRight,
                                          fit: BoxFit.scaleDown,
                                          colorFilter: ColorFilter.mode(
                                              Color(Constants.lightColorWhite),
                                              BlendMode.srcIn),
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      //color: index.isOdd ? Colors.black26 : Colors.black12,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 16,
                                          top: index == 0 ? 20 : 12,
                                          right: 16,
                                          bottom: 12,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            if (bloc.state.filteredTasks?[index]
                                                .isDone ?? false) ...[
                                              CheckButton(
                                                imagePath: Constants.checkboxChecked,
                                                color: Constants.lightColorGreen,
                                                onTap: () {
                                                  bloc.add(CompleteTaskEvent(bloc.state.filteredTasks![index]));
                                                },
                                              ),
                                            ] else ...[
                                              if(bloc.state.filteredTasks?[index].priority == Priority.high) ...[
                                                CheckButton(
                                                  imagePath: Constants.checkboxUncheckedHigh,
                                                  color: Constants.lightColorRed,
                                                  onTap: () {
                                                    bloc.add(CompleteTaskEvent(bloc.state.filteredTasks[index]));
                                                    },
                                                ),
                                              ] else ...[
                                                CheckButton(
                                                  imagePath: Constants.checkboxUncheckedNormal,
                                                  onTap: () {
                                                    bloc.add(CompleteTaskEvent(bloc.state.filteredTasks[index]));
                                                  },
                                                ),
                                              ]
                                            ],
                                            const SizedBox(width: 12),
                                            Visibility(
                                              visible: !(bloc.state.filteredTasks?[index].isDone ?? false) && (bloc.state.filteredTasks?[index].priority == Priority.high || bloc.state.filteredTasks?[index].priority == Priority.low),
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 3.0),
                                                child: bloc.state.filteredTasks?[index].priority == Priority.high
                                                    ?  SVG(
                                                    imagePath: Constants.priorityHigh,
                                                  color: Constants.lightColorRed,)
                                                    : SVG(
                                                  imagePath: Constants.priorityLow,
                                                  color: Constants.lightColorGray,
                                                ),
                                              ),
                                            ),

                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  if(bloc.state.filteredTasks?[index]
                                                      .isDone ?? false) ...[

                                                      //Text('${bloc.state.filteredTasks?[index].uuid ?? 0} ${bloc.state.filteredTasks?[index].title ?? '-'}',
                                                      Text('${bloc.state.filteredTasks?[index].title ?? '-'}',
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          color: Color(Constants.lightLabelTertiary),
                                                          decoration: TextDecoration
                                                              .lineThrough,
                                                          fontSize:
                                                          Constants.bodyFontSize,
                                                          height:
                                                          Constants.bodyFontHeight,
                                                        ),
                                                      ),

                                                  ] else
                                                    ...[

                                                        //Text('${bloc.state.filteredTasks?[index].uuid ?? 0} ${bloc.state.filteredTasks?[index].title ?? '-'}',
                                                        Text('${bloc.state.filteredTasks?[index].title ?? '-'}',
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                            color: Color(Constants.lightLabelPrimary),
                                                            decoration: TextDecoration.none,
                                                            fontSize:
                                                            Constants.bodyFontSize,
                                                            height:
                                                            Constants.bodyFontHeight,
                                                          ),
                                                        ),

                                                    ],
                                                  Visibility(
                                                    visible: bloc.state.filteredTasks?[index].deadline != null,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 4.0),
                                                        child: Text(
                                                          bloc.state.filteredTasks?[index].deadline.toString() ?? 'Дата',
                                                          style: TextStyle(
                                                            decoration: (bloc.state.filteredTasks?[index].isDone ?? false) ? TextDecoration.lineThrough : TextDecoration.none,
                                                            color: const Color(Constants.lightLabelTertiary),
                                                          ),
                                                        ),
                                                      ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => TaskDetailScreen(task: bloc.state.filteredTasks?[index])));
                                              },
                                              padding: EdgeInsets.zero,
                                              constraints: const BoxConstraints(),
                                              icon: const SVG(imagePath: Constants.infoOutlined, color: Constants.lightLabelTertiary),
                                            )
                                            // SvgPicture.asset(
                                            //   Constants.infoOutlined,
                                            //   semanticsLabel: 'infoOutline',
                                            //   fit: BoxFit.scaleDown,
                                            //   colorFilter: ColorFilter.mode(
                                            //       Color(
                                            //         Constants
                                            //             .lightLabelTertiary,
                                            //       ),
                                            //       BlendMode.srcIn),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                developer.log('adding new task');
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TaskDetailScreen(task: TaskModel(title: '', isDone: false))));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  bottom: 8,
                                  top: bloc.state.filteredTasks.isEmpty ? 8 : 0,
                                ),
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Color(Constants.lightBackSecondary),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Row(
                                      children: [
                                        SVG(imagePath: Constants.add,
                                            color: Constants.lightLabelTertiary
                                        ),
                                        SizedBox(width: 12.0),
                                        Text(
                                          'Новое',
                                          style: TextStyle(
                                            fontSize: Constants.bodyFontSize,
                                            height: Constants.bodyFontHeight,
                                            color: Color(
                                              Constants.lightLabelTertiary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                bloc.add(const ChangeFilterEvent(TasksFilter.showAll));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  bottom: 8,
                                  top: bloc.state.filteredTasks.isEmpty ? 8 : 0,
                                ),
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Color(Constants.lightBackSecondary),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Row(
                                      children: [
                                        SVG(imagePath: Constants.add,
                                            color: Constants.lightLabelTertiary
                                        ),
                                        SizedBox(width: 12.0),
                                        Text(
                                          'Все',
                                          style: TextStyle(
                                            fontSize: Constants.bodyFontSize,
                                            height: Constants.bodyFontHeight,
                                            color: Color(
                                              Constants.lightLabelTertiary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                bloc.add(const ChangeFilterEvent(TasksFilter.showOnlyActive));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  bottom: 8,
                                  top: bloc.state.filteredTasks.isEmpty ? 8 : 0,
                                ),
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Color(Constants.lightBackSecondary),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Row(
                                      children: [
                                        SVG(imagePath: Constants.add,
                                            color: Constants.lightLabelTertiary
                                        ),
                                        SizedBox(width: 12.0),
                                        Text(
                                          'Актив',
                                          style: TextStyle(
                                            fontSize: Constants.bodyFontSize,
                                            height: Constants.bodyFontHeight,
                                            color: Color(
                                              Constants.lightLabelTertiary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 3.0)),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          // onPressed: () {
          //   developer.log('adding new task');
          //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
          //       TaskDetailScreen(task: TaskModel(title: '', isDone: false)),),);
          // },
        onPressed: () {
          String r = Random().nextInt(1000).toString();
          String c = '108';
          developer.log(r);
          bloc.add(
            AddTaskEvent(
              TaskModel(
                //uuid: r,
                //uuid: c,
                //title: '$r Купить что-то, где-то, зачем-то, но зачем не очень понятно, но точно чтобы показать как обр…',
                //title: '${r} Купить что-то',
                title: '111',
                //title: '$c Купить чjkhkjhkjh-тоj',
                isDone: false,
                priority: Priority.low,
                deadline: DateTime.now(),
              ),
            ),
          );
        },
        backgroundColor: Color(Constants.lightColorBlue),
        tooltip: 'Добавить дело',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<bool> confirmDismissing(DismissDirection direction,
      AllTasksScreenBloc bloc,
      int index,) async {
    print(
      bloc.state.filteredTasks?[index].uuid ?? '0',
    );

    if(direction == DismissDirection.startToEnd)
    {
      bloc.add(
        CompleteTaskEvent(
          bloc.state.filteredTasks[index],
        ),
      );
    }

    return direction == DismissDirection.endToStart;
  }
}
