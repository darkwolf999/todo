
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/constants.dart' as Constants;

import 'package:todo/data/models/taskModel.dart';
import 'package:todo/bloc/task_detail_screen/task_detail_screen_bloc.dart';
import 'package:todo/presentation/widgets/svg.dart';
import 'package:todo/repositories/tasks_repository.dart';


class TaskDetailScreen extends StatelessWidget {
  final TaskModel? task;

  const TaskDetailScreen({Key? key, required this.task,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskDetailScreenBloc>(
      create: (context) =>
      TaskDetailScreenBloc(
        context.read<TasksRepository>(),
      ),
      child: TaskDetailScreenContent(task: task),
    );
  }
}

class TaskDetailScreenContent extends StatelessWidget {
  final TaskModel? task;

  const TaskDetailScreenContent({
    Key? key, required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskDetailScreenBloc>();

    final TextEditingController textController = TextEditingController();
    textController.text = task?.title ?? '';
    Priority priority = task?.priority ?? Priority.no;
    DateTime? pickedDate = task?.deadline;
    //String? lastPickedDate = 'Дата';

    return Scaffold(
      backgroundColor: const Color(Constants.lightBackPrimary),
      appBar: AppBar(
        backgroundColor: const Color(Constants.lightBackPrimary),
        elevation: 0,
        scrolledUnderElevation: 5,
        leading: IconButton(
          splashRadius: 24.0,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SVG(
            imagePath: Constants.close,
            color: Constants.lightLabelPrimary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: TextButton(
                //style: TextButton.styleFrom(),
                onPressed: () {
                  bloc.add(EditAcceptedEvent(
                    TaskModel(
                      uuid: task?.uuid,
                      title: textController.text,
                      isDone: false,
                      priority: priority,
                      deadline: pickedDate,
                    ),
                  ),);
                  Navigator.pop(context);
                },
                child: const Text(
                  'СОХРАНИТЬ',
                  style: TextStyle(
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
        physics: BouncingScrollPhysics(),
        child: Padding(
          //padding: const EdgeInsets.only(top: 8, left: 16.0, right: 16.0),
          padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                  elevation: 2,
                  child: TextField(
                    controller: textController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.all(16.0),
                        labelText: 'Что надо сделать…',
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          fontSize: Constants.bodyFontSize,
                          height: 18.0 / Constants.bodyFontSize,
                          color: Color(Constants.lightLabelTertiary),
                        ),
                        filled: true,
                        fillColor: Color(Constants.lightBackSecondary),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      style: TextStyle(
                          fontSize: Constants.bodyFontSize,
                          height: 18.0 / Constants.bodyFontSize,
                          color: Color(Constants.lightLabelPrimary)
                      ),
                      //keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 5,
                      textInputAction: TextInputAction.done
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: ButtonTheme(
                  //alignedDropdown: true,
                  child: DropdownButtonFormField(
                    value: priority,
                    onChanged: (newPriority) {
                      priority = newPriority;
                      print(priority);
                    },
                    style: TextStyle(
                      fontSize: 14,
                      height: 16.41 / 14,
                      color: Color(Constants.lightLabelTertiary),
                    ),
                    decoration: InputDecoration(
                      enabled: false,
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(Constants.lightSupportSeparator),
                          width: 0.5,
                          style: BorderStyle.solid,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(bottom: 16, top: 16),
                      labelText: 'Важность',
                      labelStyle: TextStyle(
                        fontSize: 22,
                        //height: 18.0 / Constants.bodyFontSize,
                        color: Color(Constants.lightLabelPrimary),
                      ),
                    ),
                    iconSize: 0.0,
                    hint: Text(
                      'Нет',
                      style: TextStyle(
                        fontSize: 14,
                        height: 16.41 / 14,
                        color: Color(Constants.lightLabelTertiary),
                      ),
                    ),
                    items: <DropdownMenuItem>[
                      DropdownMenuItem(child: Text('Нет'), value: Priority.no,),
                      DropdownMenuItem(child: Text("Низкий"), value: Priority.low),
                      DropdownMenuItem(child: Text("!! Высокий",  style: TextStyle(color: Color(Constants.lightColorRed)),), value: Priority.high,),
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
                          'Сделать до',
                          style: TextStyle(
                            fontSize: Constants.bodyFontSize,
                            height: 19.0 / Constants.bodyFontSize,
                            color: Color(Constants.lightLabelPrimary),
                          ),
                        ),
                        //SizedBox(height: 4.0),
                        Visibility(
                          visible: pickedDate != null && bloc.state.hasDeadline,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              pickedDate?.toString() ?? 'Дата',
                              style: TextStyle(
                                fontSize: 14.0,
                                height: 16.0 / 14.0,
                                color: Color(Constants.lightColorBlue),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Switch(
                        value: bloc.state.hasDeadline,
                        onChanged: (bool value) async {
                          bloc.state.hasDeadline
                              ? null
                              : pickedDate = await showDatePicker(
                            helpText: DateTime.now().year.toString(),
                            confirmText: 'ГОТОВО',
                            locale: Locale('ru'),
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Color(Constants.lightColorBlue), // header background color
                                    //onPrimary: Colors.black, // header text color
                                    //onSurface: Colors.green, // body text color
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.red, // button text color
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          //setState(() {
                          //lastPickedDate = pickedDate?.toString();
                          if(pickedDate != null) {
                            bloc.add(DeadlineSwitchedEvent());
                          }
                            //isEnabled = value;
                          //});
                        }
                    )
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              Divider(
                height: 0,
                thickness: 0.5,
                color: Color(Constants.lightSupportSeparator),
              ),
              SizedBox(height: 8.0),
              Container(
                margin: const EdgeInsets.only(left: 16),
                //color: Colors.indigoAccent,
                child: InkWell(
                  onTap: () {

                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, right: 5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SVG(imagePath: Constants.delete, color: Constants.lightColorRed),
                        SizedBox(width: 12),
                        Text(
                          'Удалить',
                          style: TextStyle(
                            fontSize: Constants.bodyFontSize,
                            height: Constants.bodyFontHeight,
                            color: Color(Constants.lightColorRed),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              //Container(width: double.infinity, height: 1200, color: Colors.deepOrange,),
            ],
          ),
        ),
      );
  },
),
    );
  }
}