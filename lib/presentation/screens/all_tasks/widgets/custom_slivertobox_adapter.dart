import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/extensions/build_context_ext.dart';

import 'package:todo/l10n/locale_keys.g.dart';
import 'package:todo/domain/bloc/all_tasks_screen/all_tasks_screen_bloc.dart';

class CustomSliverToBoxAdapter extends StatelessWidget {
  const CustomSliverToBoxAdapter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AllTasksScreenBloc>();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 60.0,
          bottom: 18.0,
        ),
        child: SizedBox(
          height: 24.0,
          child: Text(
            //Выполнено
            '${LocaleKeys.completed.tr()} — ${bloc.state.completedTasksCount}',
            style: context.textStyles.body.copyWith(
              color: context.colors.labelTertiary,
            ),
          ),
        ),
      ),
    );
  }
}
