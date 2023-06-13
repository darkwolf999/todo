import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/all_tasks_screen/all_tasks_screen_bloc.dart';

import 'package:todo/constants.dart' as Constants;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/data/models/taskModel.dart';
import 'package:todo/presentation/widgets/svg.dart';
import 'dart:developer' as developer;

import 'package:todo/repositories/tasks_repository.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllTasksScreenBloc>(
      create: (context) => AllTasksScreenBloc(
        context.read<TasksRepository>(),
      )..add(const SubscribeStreamEvent()),
      child: const AllTasksScreenContent(),
    );
  }
}

class AllTasksScreenContent extends StatelessWidget {
  const AllTasksScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AllTasksScreenBloc>();

    List<String> _theList = [
      'Купить что-то',
      'Купить что-то',
      'Купить что-то',
      'Купить что-то',
      'Купить что-то, где-то, зачем-то, но зачем не очень понятно',
      'Купить что-то, где-то, зачем-то, но зачем не очень понятно, но точно чтобы показать как обр, но точно чтобы показать как обр показать как обр',
      'Купить что-то',
      'Купить что-то',
      'Купить что-то',
      'Купить что-то',
      'Купить что-то',
      'Купить что-то',
      'Купить что-то',
      'Купить что-то',
      'Купить что-то',
      'Купить что-то',
      'Купить что-то',
      'Купить что-то',
      'Купить что-то',
      'Купить что-то',
      'Купить что-то',
      'Купить что-то',
      'Купить что-то',
      'Купить что-то',
    ];
    //List<String> _theList = ['1','2','3','4','5','6','7','8','9','10','11','12','13',];
    return Scaffold(
      backgroundColor: const Color(Constants.lightBackPrimary),
      body: BlocBuilder<AllTasksScreenBloc, AllTasksScreenState>(
        builder: (context, state) {
          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              const SliverAppBar(
                pinned: true,
                snap: false,
                floating: true,
                expandedHeight: 88.0,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding:
                      EdgeInsets.only(left: 16.0, top: 48.0, bottom: 16.0),
                  title: Text(
                    'Мои дела',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: Constants.titleFontSize,
                      height: Constants.titleFontHeight,
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 60.0, top: 2.0, bottom: 16.0),
                  child: SizedBox(
                    height: 24,
                    child: Text(
                      'Выполнено —',
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
                                itemCount: bloc.state.tasks?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return Dismissible(
                                    //key: Key(_theList[index]),
                                    key: Key(
                                      bloc.state.tasks?[index].uuid ?? '0',
                                    ),
                                    // onDismissed: (DismissDirection direction) {
                                    //   print(
                                    //     bloc.state.tasks?[index].uuid ?? '0',
                                    //   );
                                    //   //_theList.removeAt(index);
                                    //
                                    //   //this.reIndex();
                                    //   direction == DismissDirection.endToStart
                                    //       ? {
                                    //           print("remove"),
                                    //           bloc.add(
                                    //             DeleteTaskEvent(
                                    //               bloc.state.tasks?[index]
                                    //                       .uuid ??
                                    //                   '0',
                                    //             ),
                                    //           ),
                                    //         }
                                    //       : {
                                    //           print("favourite"),
                                    //           bloc.add(
                                    //             CompleteTaskEvent(
                                    //               bloc.state.tasks![index],
                                    //               true,
                                    //             ),
                                    //           ),
                                    //         };
                                    //   //print(_theList);
                                    //   //print(bloc.state.tasks);
                                    // },

                                    confirmDismiss: (direction) =>
                                        promptUser(direction, bloc, index),

                                    onDismissed: (_) => bloc.add(
                                      DeleteTaskEvent(
                                        bloc.state.tasks?[index].uuid ?? '0',
                                      ),
                                    ),

                                    background: Container(
                                      color: const Color(
                                          Constants.lightColorGreen),
                                      // decoration: BoxDecoration(
                                      //   color: const Color(Constants.lightColorRed),
                                      //   borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                                      // ),
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
                                      // child: ListTile(
                                      //   // leading: const Icon(
                                      //   //   Icons.delete,
                                      //   //   color: Colors.white, size: 36.0
                                      //   // )
                                      //   leading: SvgPicture.asset(
                                      //       Constants.delete,
                                      //       semanticsLabel: 'delete',
                                      //       fit: BoxFit.scaleDown,
                                      //       colorFilter: ColorFilter.mode(
                                      //         Color(Constants.lightColorWhite),
                                      //         BlendMode.srcIn
                                      //       ),
                                      //     ),
                                      // )
                                    ),

                                    secondaryBackground: Container(
                                      color:
                                          const Color(Constants.lightColorRed),
                                      // decoration: BoxDecoration(
                                      //   color: const Color(Constants.lightColorGreen),
                                      //   borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                                      // ),
                                      // child: ListTile(
                                      //   // trailing: const Icon(
                                      //   //   Icons.favorite,
                                      //   //   color: Colors.white, size: 36.0)
                                      //   trailing: SvgPicture.asset(
                                      //     Constants.check,
                                      //     semanticsLabel: 'check',
                                      //     fit: BoxFit.scaleDown,
                                      //     colorFilter: ColorFilter.mode(
                                      //         Color(Constants.lightColorWhite),
                                      //         BlendMode.srcIn
                                      //     ),
                                      //   ),
                                      // )
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
                                    // child: ListTile(
                                    //   leading: SvgPicture.asset(
                                    //     Constants.checkboxUncheckedNormal,
                                    //     semanticsLabel: 'checkboxUncheckedNormal',
                                    //     fit: BoxFit.scaleDown,
                                    //     colorFilter: ColorFilter.mode(
                                    //       Color(Constants.lightSupportSeparator),
                                    //       BlendMode.srcIn
                                    //     ),
                                    //   ),
                                    //   title: Text(
                                    //     _theList[index],
                                    //     maxLines: 3,
                                    //     overflow: TextOverflow.ellipsis,
                                    //     style: TextStyle(
                                    //       fontSize: Constants.bodyFontSize,
                                    //       height: Constants.bodyFontHeight,
                                    //     ),
                                    //   ),
                                    //   trailing: SvgPicture.asset(
                                    //     Constants.infoOutlined,
                                    //     semanticsLabel: 'infoOutline',
                                    //     fit: BoxFit.scaleDown,
                                    //     colorFilter: ColorFilter.mode(
                                    //       Color(Constants.lightLabelTertiary),
                                    //       BlendMode.srcIn
                                    //     ),
                                    //   ),
                                    //     //Icons.info_outline_rounded,
                                    //     //color: Colors.white, size: 36.0
                                    //   //minLeadingWidth: 12,
                                    //   horizontalTitleGap: 12,
                                    // ),

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
                                            if (bloc.state.tasks?[index]
                                                    .isDone ??
                                                false)
                                              SvgPicture.asset(
                                                Constants.checkboxChecked,
                                                fit: BoxFit.scaleDown,
                                              )
                                            else
                                              const SVG(
                                                imagePath: Constants
                                                    .checkboxUncheckedNormal,
                                                color: Constants
                                                    .lightSupportSeparator,
                                              ),
                                            // SvgPicture.asset(
                                            //   Constants.checkboxUncheckedNormal,
                                            //   semanticsLabel:
                                            //       'checkboxUncheckedNormal',
                                            //   fit: BoxFit.scaleDown,
                                            //   colorFilter: ColorFilter.mode(
                                            //       Color(Constants
                                            //           .lightSupportSeparator),
                                            //       BlendMode.srcIn),
                                            // ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Text(
                                                //_theList[index],
                                                bloc.state.tasks?[index].uuid ??
                                                    '---',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize:
                                                      Constants.bodyFontSize,
                                                  height:
                                                      Constants.bodyFontHeight,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            SvgPicture.asset(
                                              Constants.infoOutlined,
                                              semanticsLabel: 'infoOutline',
                                              fit: BoxFit.scaleDown,
                                              colorFilter: ColorFilter.mode(
                                                  Color(
                                                    Constants
                                                        .lightLabelTertiary,
                                                  ),
                                                  BlendMode.srcIn),
                                            ),
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
                              },
                              child: Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  height: 48,
                                  color: Colors.blueAccent,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 52.0),
                                      child: Text(
                                        'Новое',
                                        style: TextStyle(
                                          fontSize: Constants.bodyFontSize,
                                          height: Constants.bodyFontHeight,
                                          color: Color(
                                            Constants.lightLabelTertiary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ),
              SliverPadding(padding: EdgeInsets.only(bottom: 3)),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String r = Random().nextInt(1000).toString();
          developer.log(r);
          bloc.add(
            AddTaskEvent(
              TaskModel(
                uuid: r,
                title: 'Купить что-то',
                isDone: false,
              ),
            ),
          );
        },
        tooltip: 'Добавить дело',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<bool> promptUser(
    DismissDirection direction,
    AllTasksScreenBloc bloc,
    int index,
  ) async {
    print(
      bloc.state.tasks?[index].uuid ?? '0',
    );

    direction == DismissDirection.endToStart
        ? {
            print("remove"),
            // bloc.add(
            //   DeleteTaskEvent(
            //     bloc.state.tasks?[index].uuid ?? '0',
            //   ),
            // ),
          }
        : {
            print("favourite"),
            bloc.add(
              CompleteTaskEvent(
                bloc.state.tasks![index],
                true,
              ),
            ),
          };

    return direction == DismissDirection.endToStart;

    // print(
    //   bloc.state.tasks?[index].uuid ?? '0',
    // );
    //
    // direction == DismissDirection.endToStart
    //     ? {
    //   print("remove"),
    //   bloc.add(
    //     DeleteTaskEvent(
    //       bloc.state.tasks?[index]
    //           .uuid ??
    //           '0',
    //     ),
    //   ),
    // }
    //     : {
    //   print("favourite"),
    //   bloc.add(
    //     CompleteTaskEvent(
    //       bloc.state.tasks![index],
    //       true,
    //     ),
    //   ),
    // };
    //
    // return direction ==
    //     DismissDirection.endToStart;
  }
}
