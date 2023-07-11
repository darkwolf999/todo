import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/bloc/error_bloc/error_bloc.dart';

import 'package:todo/l10n/locale_keys.g.dart';
import 'package:todo/constants.dart' as Constants;

import '../../domain/bloc/all_tasks_screen/all_tasks_screen_bloc.dart';

class SomethingWentWrong extends StatelessWidget {
  final VoidCallback onPressed;

  const SomethingWentWrong({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errBloc = context.read<ErrorBloc>();
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            //Что-то пошло не так
            LocaleKeys.smthgWentWrong.tr(),
            style: const TextStyle(
              fontSize: Constants.bodyFontSize,
            ),
          ),
          const SizedBox(height: 8),
          BlocBuilder<AllTasksScreenBloc, AllTasksScreenState>(
            builder: (context, state) {
              return Text(
                errBloc.state.errorMsg ?? 'Неизвестная ошибка',
                textAlign: TextAlign.center,
              );
            },
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              //Обновить страницу
              LocaleKeys.refreshPage.tr(),
              style: const TextStyle(
                color: Color(Constants.lightColorBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
