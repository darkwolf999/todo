// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "appTitle": "My tasks",
  "completed": "Completed",
  "newTask": "New",
  "addTask": "Add task",
  "SAVE": "SAVE",
  "whatToDo": "What need to do...",
  "importance": "Importance",
  "no": "No",
  "low": "Low",
  "high": "High",
  "deadline": "Deadline",
  "delete": "Delete",
  "DONE": "DONE",
  "emptyTask": "Empty task",
  "smthgWentWrong": "Something went wrong...",
  "refreshPage": "Refresh screen"
};
static const Map<String,dynamic> ru = {
  "appTitle": "Мои дела",
  "completed": "Выполнено",
  "newTask": "Новое",
  "addTask": "Добавить дело",
  "SAVE": "СОХРАНИТЬ",
  "whatToDo": "Что надо сделать...",
  "importance": "Важность",
  "no": "Нет",
  "low": "Низкий",
  "high": "Высокий",
  "deadline": "Сделать до",
  "delete": "Удалить",
  "DONE": "ГОТОВО",
  "emptyTask": "Пустая задача",
  "smthgWentWrong": "Что-то пошло не так...",
  "refreshPage": "Обновить страницу"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ru": ru};
}
