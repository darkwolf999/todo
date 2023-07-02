import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/l10n/locale_keys.g.dart';
import 'package:todo/domain/bloc/task_detail_screen/task_detail_screen_bloc.dart';
import 'package:todo/domain/bloc/all_tasks_screen/all_tasks_screen_bloc.dart';
import 'package:todo/constants.dart' as Constants;
import 'package:todo/presentation/screens/all_tasks/widgets/add_new_task_button.dart';
import 'package:todo/presentation/screens/all_tasks/widgets/custom_sliver_appbar.dart';
import 'package:todo/presentation/screens/all_tasks/widgets/custom_slivertobox_adapter.dart';
import 'package:todo/presentation/screens/all_tasks/widgets/language_button.dart';
import 'package:todo/presentation/screens/all_tasks/widgets/tasks_listview.dart';
import 'package:todo/data/repositories/tasks_repository_impl.dart';
import 'package:todo/presentation/widgets/something_went_wrong.dart';

import '../../../navigation/tasks_router_delegate.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AllTasksScreenBloc>(
        create: (context) => AllTasksScreenBloc(
          context.read<TasksRepositoryImpl>(),
        )..add(const SubscribeStreamEvent()),
      ),
    ], child: const AllTasksScreenContent());
  }
}

class AllTasksScreenContent extends StatelessWidget {
  const AllTasksScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AllTasksScreenBloc>();
    ScrollController scrollController = ScrollController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(Constants.lightBackPrimary),
      body: BlocBuilder<AllTasksScreenBloc, AllTasksScreenState>(
        builder: (context, state) {
          switch (state.status) {
            case AllTasksScreenStatus.initial:
              return const Center(child: CircularProgressIndicator());
            case AllTasksScreenStatus.failure:
              return SomethingWentWrong(
                onPressed: () {
                  bloc.add(const SubscribeStreamEvent());
                },
              );
            case AllTasksScreenStatus.success:
              return RefreshIndicator(
                color: const Color(Constants.lightColorBlue),
                edgeOffset: 150,
                onRefresh: () async {
                  bloc.add(const SubscribeStreamEvent());
                },
                child: CustomScrollView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  slivers: <Widget>[
                    CustomSliverAppbar(),
                    CustomSliverToBoxAdapter(),
                    SliverPadding(
                      padding: const EdgeInsets.only(
                        left: 4.0,
                        right: 4.0,
                        bottom: 3.0,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Card(
                              color: const Color(Constants.lightBackSecondary),
                              semanticContainer: false,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              elevation: 4.0,
                              child: Column(
                                children: [
                                  TasksListview(),
                                  AddNewTaskButton(
                                    onTap: () {
                                      addNewTask(scrollController, context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          childCount: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          LanguageButton(
            onTap: () {
              context.locale == const Locale('ru')
                  ? context.setLocale(const Locale('en'))
                  : context.setLocale(const Locale('ru'));
            },
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: () {
              addNewTask(scrollController, context);
            },
            backgroundColor: const Color(Constants.lightColorBlue),
            tooltip: LocaleKeys.addTask.tr(), //'Добавить дело',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  void addNewTask(
    ScrollController scrollController,
    BuildContext context,
  ) async {
    final animateScrollTop = true;
    context.read<TaskDetailScreenBloc>().add(StartEditingTaskEvent());
    (Router.of(context).routerDelegate as TasksRouterDelegate).gotoTask(null);
    if (animateScrollTop) {
      scrollController.animateTo(
        0,
        duration: const Duration(
          milliseconds: 500,
        ),
        curve: Curves.linear,
      );
    }
  }
}
