import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:todo/constants.dart' as Constants;

import '../widgets/svg.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({Key? key}) : super(key: key);

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {

  bool isEnabled = false;
  String date = 'Дата';
  DateTime? pickedDate;

  @override
  Widget build(BuildContext context) {
    List<String> _theList = ['1','2','3'];
    return Scaffold(
      backgroundColor: const Color(Constants.lightBackPrimary),
      appBar: AppBar(
        backgroundColor: const Color(Constants.lightBackPrimary),
        elevation: 0,
        scrolledUnderElevation: 5,
        leading: SVG(
          imagePath: Constants.close,
          color: Constants.lightLabelPrimary,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: TextButton(
                //style: TextButton.styleFrom(),
                onPressed: (){},
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
      body: SingleChildScrollView(
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
                      DropdownMenuItem(child: Text("USA"),value: "USA"),
                      DropdownMenuItem(child: Text("Canada"),value: "Canada"),
                      DropdownMenuItem(child: Text("Brazil"),value: "Brazil"),
                      DropdownMenuItem(child: Text("England", style: TextStyle(color: Color(Constants.lightColorRed)),),value: "England"),
                    ],
                    onChanged: (dynamic) {},
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
                          visible: isEnabled,
                          child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              date,
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
                      value: isEnabled,
                      onChanged: (bool value) async {
                        isEnabled
                        ? isEnabled = !isEnabled
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
                        setState(() {
                          date = pickedDate?.toString() ?? 'Дата';
                          isEnabled = value;
                        });
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
                  onTap: (){},
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
      ),
    );
  }
}