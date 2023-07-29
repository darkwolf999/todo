import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/domain/bloc/firebase/remote_config/remote_config_bloc.dart';
import 'package:todo/extensions/build_context_ext.dart';

import 'package:todo/l10n/locale_keys.g.dart';
import 'package:todo/constants.dart' as Constants;
import 'package:todo/domain/models/task_model.dart';
import 'package:todo/domain/bloc/task_detail_screen/task_detail_screen_bloc.dart';
import 'package:todo/helpers/format_date.dart';
import 'package:todo/presentation/screens/task_detail/widgets/material_textfield.dart';
import 'package:todo/presentation/screens/task_detail/widgets/delete_button/delete_button.dart';
import 'package:todo/presentation/screens/task_detail//widgets/delete_button/inkwell_delete_button.dart';
import 'package:todo/domain/repository/tasks_repository.dart';
import 'package:todo/navigation/manager/tasks_navigation.dart';
import 'package:todo/presentation/screens/all_tasks/widgets/tasks_listview.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel? task;

  const TaskDetailScreen({
    Key? key,
    this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskDetailScreenBloc>(
      create: (context) => TaskDetailScreenBloc(
        tasksRepository: context.read<TasksRepository>(),
        analyticsProvider: GetIt.I.get(),
        deviceModel: GetIt.I.get(instanceName: 'deviceModel'),
        editedTask: task,
      ),
      child: const TaskDetailScreenContent(),
    );
    //return TaskDetailScreenContent(task: task);
  }
}

class TaskDetailScreenContent extends StatelessWidget {
  final TaskModel? task;
  final int? taskIndex;

  const TaskDetailScreenContent({
    Key? key,
    this.task,
    this.taskIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskDetailScreenBloc>();
    //final router = Router.of(context).routerDelegate as TasksRouterDelegate;
    final router = context.read<TasksNavigation>();

    Priority? priority = bloc.state.priority;
    DateTime? deadline = bloc.state.deadline;
    bool isSwitchEnabled = bloc.state.deadline != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.backPrimary,
        elevation: 0,
        scrolledUnderElevation: 5.0,
        leading: IconButton(
          splashRadius: 24.0,
          onPressed: () {
            router.pop(true);
          },
          icon: Icon(
            Icons.close,
            color: context.colors.labelPrimary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Center(
              child: TextButton(
                onPressed: () {
                  bloc.add(const EditAcceptedEvent());
                  if (bloc.state.isNewTask) {
                    listKey.currentState?.insertItem(
                      0,
                      duration: const Duration(milliseconds: 500),
                    );
                  }
                  router.pop(true);
                },
                child: Text(
                  //СОХРАНИТЬ
                  LocaleKeys.SAVE.tr(),
                  style: context.textStyles.button.copyWith(
                    color: context.colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ], // default is 56
      ),
      body: BlocBuilder<TaskDetailScreenBloc, TaskDetailScreenState>(
        builder: (context, state) {
          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Constants.maxWidth,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                          style: context.textStyles.button.copyWith(
                            color: context.colors.labelTertiary,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            enabled: false,
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: context.colors.supportSeparator,
                                width: 0.5,
                                style: BorderStyle.solid,
                              ),
                            ),
                            contentPadding:
                                const EdgeInsets.only(bottom: 16.0, top: 16.0),
                            //Важность
                            labelText: LocaleKeys.importance.tr(),
                            labelStyle: context.textStyles.body.copyWith(
                              color: context.colors.labelPrimary,
                              fontSize: 22.0,
                            ),
                          ),
                          iconSize: 0,
                          hint: Text(
                            //Нет
                            LocaleKeys.no.tr(),
                            style: context.textStyles.button.copyWith(
                              color: context.colors.labelTertiary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          items: <DropdownMenuItem>[
                            DropdownMenuItem(
                              value: Priority.no,
                              child: Text(
                                //Нет
                                LocaleKeys.no.tr(),
                                style: context.textStyles.body.copyWith(
                                  color: context.colors.labelPrimary,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: Priority.low,
                              child: Text(
                                //Низкий
                                LocaleKeys.low.tr(),
                                style: context.textStyles.body.copyWith(
                                  color: context.colors.labelPrimary,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: Priority.high,
                              child: BlocBuilder<RemoteConfigBloc,
                                  RemoteConfigState>(
                                builder: (context, state) {
                                  return Text(
                                    //!! Высокий
                                    '!! ${LocaleKeys.high.tr()}',
                                    style: context.textStyles.body.copyWith(
                                      color: state.highPriorityColor != null
                                          ? Color(state.highPriorityColor!)
                                          : context.colors.red,
                                    ),
                                  );
                                },
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
                                style: context.textStyles.body.copyWith(
                                  color: context.colors.labelPrimary,
                                ),
                              ),
                              Visibility(
                                visible: isSwitchEnabled != false,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    isSwitchEnabled != false && deadline != null
                                        ? FormatDate.toDmmmmyyyy(
                                            deadline!,
                                            Localizations.localeOf(context)
                                                .toString(),
                                          )
                                        : '',
                                    style: context.textStyles.button.copyWith(
                                      color: context.colors.blue,
                                      height: 0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            inactiveThumbColor: context.colors.backElevated,
                            inactiveTrackColor: context.colors.supportOverlay,
                            activeColor: context.colors.blue,
                            value: bloc.state.deadline != null,
                            onChanged: (bool value) async {
                              bloc.state.deadline != null
                                  ? {
                                      deadline = null,
                                      isSwitchEnabled = false,
                                      bloc.add(const DeadlineChangedEvent(null))
                                    }
                                  : {
                                      deadline =
                                          await pickDeadlineDate(context),
                                      isSwitchEnabled = true,
                                      bloc.add(DeadlineChangedEvent(deadline))
                                    };
                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Divider(
                      height: 0,
                      thickness: 0.5,
                      color: context.colors.supportSeparator,
                    ),
                    const SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: bloc.state.isNewTask
                          ? DeleteButton(
                              icon: Icons.delete,
                              textColor: context.colors.labelDisable,
                            )
                          : InkWellDeleteButton(
                              icon: Icons.delete,
                              textColor: context.colors.red,
                              onTap: () {
                                bloc.add(
                                  DeleteTaskEvent(bloc.state.editedTask!.uuid),
                                );
                                listKey.currentState?.removeItem(taskIndex ?? 0,
                                    (context, animation) {
                                  return Container();
                                });
                                router.pop(true);
                              },
                            ),
                    ),
                    const SizedBox(height: 12.0),
                  ],
                ),
              ),
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
          dialogBackgroundColor: context.colors.backSecondary,
          colorScheme: ColorScheme.light(
            primary: context.colors.blue,
            onSurface: context.colors.labelPrimary,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: context.colors.blue,
            ),
          ),
        ),
        child: child!,
      );
    },
  );
}
