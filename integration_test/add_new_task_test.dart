import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intl/intl.dart';
import 'package:todo/domain/models/task_model.dart';
import 'package:todo/presentation/screens/all_tasks/widgets/add_new_task_button.dart';
import 'package:todo/presentation/screens/all_tasks/widgets/task.dart';
import 'package:todo/presentation/screens/all_tasks/widgets/tasks_listview.dart';
import 'package:todo/presentation/screens/task_detail/widgets/material_textfield.dart';
import 'package:uuid/uuid.dart';
import 'package:todo/main_dev.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'create todo test',
    () {
      testWidgets(
        'tap on add button, create todo, check todo on home page',
        (tester) async {
          app.main();

          final uuid = const Uuid().v1().toString();
          final dateNow = DateTime.now();
          final taskModel = TaskModel(
            uuid: uuid,
            title:
                'Привет, походу мы прошли пол пути Школы мобильной разработки Яндекса!!! $uuid',
            isDone: true,
            priority: Priority.no,
            createdAt: dateNow.millisecondsSinceEpoch,
            changedAt: dateNow.millisecondsSinceEpoch,
            lastUpdatedBy: 'lastUpdatedBy',
          );

          await Future<void>.delayed(const Duration(milliseconds: 2000));

          final Finder targetFinder = find.byWidgetPredicate(
            (widget) => widget is Task && widget.task.title == taskModel.title,
          );

          await Future<void>.delayed(const Duration(milliseconds: 3000));

          await tester.pumpAndSettle();
          expect(find.byType(TasksListview), findsOneWidget);
          expect(targetFinder, findsNothing);

          await tester.pumpAndSettle();

          await tester.tap(find.byType(AddNewTaskButton));
          await tester.pumpAndSettle();

          await Future<void>.delayed(const Duration(milliseconds: 1000));

          expect(find.byType(MaterialTextfield), findsOneWidget);
          expect(find.byType(DropdownButtonFormField), findsOneWidget);
          expect(find.byType(Switch), findsOneWidget);

          await tester.enterText(
            find.byType(TextFormField),
            taskModel.title,
          );
          await tester.pumpAndSettle();
          expect(find.text(taskModel.title), findsOneWidget);

          await Future<void>.delayed(const Duration(milliseconds: 3000));

          await tester.tap(
            find.text('Нет', findRichText: true),
          );

          await Future<void>.delayed(const Duration(milliseconds: 1000));

          await tester.pumpAndSettle();
          await tester.tap(find.text('!! Высокий', findRichText: true));
          await tester.pumpAndSettle();
          expect(find.text('!! Высокий', findRichText: true), findsOneWidget);

          await Future<void>.delayed(const Duration(milliseconds: 1000));

          await tester.tap(find.byType(Switch));
          await tester.pumpAndSettle();

          await Future<void>.delayed(const Duration(milliseconds: 1000));

          await tester.tap(find.widgetWithText(TextButton, 'ГОТОВО'));
          await tester.pumpAndSettle();
          expect(
            find.text(DateFormat.yMMMMd().format(DateTime.now())),
            findsNothing,
          );

          await Future<void>.delayed(const Duration(milliseconds: 1000));

          await tester.tap(
            find.text('СОХРАНИТЬ', findRichText: true),
          );
          await tester.pumpAndSettle();
          await tester.pump(const Duration(milliseconds: 3));
          await tester.pumpAndSettle();

          expect(targetFinder, findsOneWidget);

          await Future<void>.delayed(const Duration(milliseconds: 1000));
        },
      );
    },
  );
}
