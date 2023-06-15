import 'package:flutter/material.dart';

import 'package:todo/bloc/all_tasks_screen/all_tasks_screen_bloc.dart';

import 'package:todo/constants.dart' as Constants;
import 'package:todo/data/models/task_model.dart';
import 'package:todo/presentation/screens/task_detail/task_detail.dart';
import 'package:todo/presentation/widgets/svg.dart';
import 'package:todo/presentation/widgets/check_button.dart';
import 'package:todo/helpers/format_date.dart';
import 'dart:developer' as developer;

class TasksListview extends StatelessWidget {
  final AllTasksScreenBloc bloc;

  const TasksListview({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
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
                    bloc.state.filteredTasks[index].uuid,
                  ),
                ),
            background: Container(
              color: Color((bloc.state.filteredTasks[index].isDone)
                  ? Constants.lightColorGrayLight
                  : Constants.lightColorGreen,),
              child: const Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SVG(
                    imagePath: Constants.check,
                    color: Constants.lightColorWhite,
                  ),
                ),
              ),
            ),
            secondaryBackground: Container(
              color:
              const Color(Constants.lightColorRed),
              child: const Padding(
                padding:
                EdgeInsets.only(right: 24.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SVG(
                    imagePath: Constants.delete,
                    color: Constants.lightColorWhite,
                  ),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                top: index == 0 ? 20.0 : 12.0,
                right: 16.0,
                bottom: 12.0,
              ),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  if (bloc.state.filteredTasks[index]
                      .isDone) ...[
                    CheckButton(
                      imagePath: Constants.checkboxChecked,
                      color: Constants.lightColorGreen,
                      onTap: () {
                        bloc.add(CompleteTaskEvent(bloc.state.filteredTasks[index]));
                      },
                    ),
                  ] else ...[
                    if(bloc.state.filteredTasks[index].priority == Priority.high) ...[
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
                    visible: !(bloc.state.filteredTasks[index].isDone) && (bloc.state.filteredTasks[index].priority == Priority.high || bloc.state.filteredTasks[index].priority == Priority.low),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 3.0),
                      child: bloc.state.filteredTasks[index].priority == Priority.high
                          ?  const SVG(
                        imagePath: Constants.priorityHigh,
                        color: Constants.lightColorRed,)
                          : const SVG(
                        imagePath: Constants.priorityLow,
                        color: Constants.lightColorGray,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(bloc.state.filteredTasks[index]
                            .isDone) ...[
                          Text(bloc.state.filteredTasks[index].title,
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
                            Text(bloc.state.filteredTasks[index].title,
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
                          visible: bloc.state.filteredTasks[index].deadline != null,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              FormatDate.toDmmmmyyyy(bloc.state.filteredTasks[index].deadline ?? DateTime.now()),
                              style: const TextStyle(
                                color: Color(Constants.lightLabelTertiary),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TaskDetailScreen(task: bloc.state.filteredTasks[index])));
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const SVG(imagePath: Constants.infoOutlined, color: Constants.lightLabelTertiary),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool> confirmDismissing(
      DismissDirection direction,
      AllTasksScreenBloc bloc,
      int index,)
  async {
    developer.log(
      bloc.state.filteredTasks[index].uuid,
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
