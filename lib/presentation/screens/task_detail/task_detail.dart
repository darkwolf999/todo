import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:todo/l10n/locale_keys.g.dart';
import 'package:todo/constants.dart' as Constants;
import 'package:todo/domain/models/task_model.dart';
import 'package:todo/domain/bloc/task_detail_screen/task_detail_screen_bloc.dart';
import 'package:todo/helpers/format_date.dart';
import 'package:todo/presentation/screens/task_detail/widgets/material_textfield.dart';
import 'package:todo/presentation/screens/task_detail/widgets/delete_button/delete_button.dart';
import 'package:todo/presentation/screens/task_detail//widgets/delete_button/inkwell_delete_button.dart';
import 'package:todo/presentation/widgets/svg.dart';
import 'package:todo/navigation/tasks_router_delegate.dart';

import '../../../data/repositories/tasks_repository_impl.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel? task;

  const TaskDetailScreen({
    Key? key,
    this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return BlocProvider<TaskDetailScreenBloc>(
    //   create: (context) => TaskDetailScreenBloc(
    //     context.read<TasksRepositoryImpl>(),
    //   )..add(StartEditingTaskEvent(task: task)),
    //   child: TaskDetailScreenContent(task: task),
    // );
    return TaskDetailScreenContent(task: task);
  }
}

class TaskDetailScreenContent extends StatelessWidget {
  final TaskModel? task;

  const TaskDetailScreenContent({
    Key? key,
    this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskDetailScreenBloc>();

    Priority? priority = bloc.state.priority;
    DateTime? deadline = bloc.state.deadline;
    bool isSwitchEnabled = bloc.state.deadline != null;

    return Scaffold(
      backgroundColor: const Color(Constants.lightBackPrimary),
      appBar: AppBar(
        backgroundColor: const Color(Constants.lightBackPrimary),
        elevation: 0,
        scrolledUnderElevation: 5.0,
        leading: IconButton(
          splashRadius: 24.0,
          onPressed: () {
            bloc.add(FinishEditingEvent());
            (Router.of(context).routerDelegate as TasksRouterDelegate)
                .pop(true);
          },
          icon: const SVG(
            imagePath: Constants.close,
            color: Constants.lightLabelPrimary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Center(
              child: TextButton(
                onPressed: () {
                  bloc.add(const EditAcceptedEvent());
                  Navigator.pop(context);
                },
                child: Text(
                  //СОХРАНИТЬ
                  LocaleKeys.SAVE.tr(),
                  style: const TextStyle(
                    fontSize: Constants.buttonFontSize,
                    height: Constants.buttonFontHeight,
                    color: Color(Constants.lightColorBlue),
                  ),
                ),
              ),
            ),
          ),
        ], // default is 56
      ),
      body: BlocBuilder<TaskDetailScreenBloc, TaskDetailScreenState>(
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: MaterialTextfield(),
                ),
                const SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: ButtonTheme(
                    child: DropdownButtonFormField(
                      value: priority,
                      onChanged: (newPriority) {
                        bloc.add(PriorityChangedEvent(newPriority));
                      },
                      style: const TextStyle(
                        fontSize: Constants.buttonFontSize,
                        height: Constants.buttonFontHeight,
                        color: Color(Constants.lightLabelTertiary),
                      ),
                      decoration: InputDecoration(
                        enabled: false,
                        disabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(Constants.lightSupportSeparator),
                            width: 0.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.only(bottom: 16.0, top: 16.0),
                        //Важность
                        labelText: LocaleKeys.importance.tr(),
                        labelStyle: const TextStyle(
                          fontSize: 22.0,
                          color: Color(Constants.lightLabelPrimary),
                        ),
                      ),
                      iconSize: 0,
                      hint: Text(
                        //Нет
                        LocaleKeys.no.tr(),
                        style: const TextStyle(
                          fontSize: Constants.buttonFontSize,
                          height: Constants.buttonFontHeight,
                          color: Color(Constants.lightLabelTertiary),
                        ),
                      ),
                      items: <DropdownMenuItem>[
                        DropdownMenuItem(
                          value: Priority.no,
                          child: Text(
                            //Нет
                            LocaleKeys.no.tr(),
                            style: const TextStyle(
                              fontSize: Constants.bodyFontSize,
                              color: Color(Constants.lightLabelPrimary),
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: Priority.low,
                          child: Text(
                            //Низкий
                            LocaleKeys.low.tr(),
                            style: const TextStyle(
                              fontSize: Constants.bodyFontSize,
                              color: Color(Constants.lightLabelPrimary),
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: Priority.high,
                          child: Text(
                            //!! Высокий
                            '!! ${LocaleKeys.high.tr()}',
                            style: const TextStyle(
                              fontSize: Constants.bodyFontSize,
                              color: Color(Constants.lightColorRed),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            //Сделать до
                            LocaleKeys.deadline.tr(),
                            style: const TextStyle(
                              fontSize: Constants.bodyFontSize,
                              height: Constants.bodyFontHeight,
                              color: Color(Constants.lightLabelPrimary),
                            ),
                          ),
                          Visibility(
                            visible: isSwitchEnabled != false,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                deadline != null
                                    ? FormatDate.toDmmmmyyyy(
                                        deadline!,
                                        Localizations.localeOf(context)
                                            .toString(),
                                      )
                                    : '',
                                style: const TextStyle(
                                  fontSize: Constants.buttonFontSize,
                                  color: Color(Constants.lightColorBlue),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: bloc.state.deadline != null,
                        onChanged: (bool value) async {
                          bloc.state.deadline != null
                              ? {
                                  deadline = null,
                                  bloc.add(const DeadlineChangedEvent(null))
                                }
                              : {
                                  deadline = await pickDeadlineDate(context),
                                  bloc.add(DeadlineChangedEvent(deadline))
                                };
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
                const Divider(
                  height: 0,
                  thickness: 0.5,
                  color: Color(Constants.lightSupportSeparator),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: bloc.state.isNewTask ?? false
                      ? const DeleteButton(
                          icon: Constants.deleteDisabled,
                          textColor: Constants.lightLabelDisable,
                        )
                      : InkWellDeleteButton(
                          icon: Constants.delete,
                          textColor: Constants.lightColorRed,
                          onTap: () {
                            bloc.add(
                              DeleteTaskEvent(bloc.state.editedTask!.uuid),
                            );
                            Navigator.pop(context);
                          },
                        ),
                ),
                const SizedBox(height: 12.0),
              ],
            ),
          );
        },
      ),
    );
  }
}

Future<String> getDeviceModel() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  return androidInfo.model;
}

Future<DateTime?> pickDeadlineDate(BuildContext context) {
  return showDatePicker(
    helpText: DateTime.now().year.toString(),
    //ГОТОВО
    confirmText: LocaleKeys.DONE.tr(),
    locale: Localizations.localeOf(context),
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(Constants.lightColorBlue),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(Constants.lightColorBlue),
            ),
          ),
        ),
        child: child!,
      );
    },
  );
}
