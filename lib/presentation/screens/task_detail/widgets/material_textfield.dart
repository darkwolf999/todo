import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/extensions/build_context_ext.dart';
import 'package:todo/l10n/locale_keys.g.dart';
import 'package:todo/domain/bloc/task_detail_screen/task_detail_screen_bloc.dart';

class MaterialTextfield extends StatelessWidget {
  const MaterialTextfield({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskDetailScreenBloc>();
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8.0),
      elevation: 2,
      child: TextFormField(
        //Если это новая задача, то ее заголовок будет "Пустая задача",
        //и мы не будем отображать данный заголовок в качестве стартового текста
        initialValue: bloc.state.editedTask?.title != LocaleKeys.emptyTask.tr()
            ? bloc.state.editedTask?.title
            : null,
        onChanged: (text) => bloc.add(TitleChangedEvent(text)),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.all(16.0),
          //Что надо сделать…
          labelText: LocaleKeys.whatToDo.tr(),
          alignLabelWithHint: true,
          labelStyle: context.textStyles.body.copyWith(
            color: context.colors.labelTertiary,
          ),
          filled: true,
          fillColor: context.colors.backSecondary,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        style: context.textStyles.body.copyWith(
          color: context.colors.labelPrimary,
          height: 18.0 / 16.0,
        ),
        maxLines: null,
        minLines: 5,
      ),
    );
  }
}
