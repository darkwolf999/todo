import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:todo/extensions/build_context_ext.dart';
import 'package:todo/l10n/locale_keys.g.dart';
import 'package:todo/presentation/screens/all_tasks/widgets/visibility_button.dart';

class CustomSliverAppbar extends StatelessWidget {
  const CustomSliverAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: true,
      elevation: 5.0,
      collapsedHeight: 60.0,
      expandedHeight: 124.0,
      backgroundColor: context.colors.backPrimary,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: VisibilityButton(),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 60.0, bottom: 17.0),
        expandedTitleScale: 1.6,
        title: Text(
          //Мои дела
          LocaleKeys.appTitle.tr(),
          style: context.textStyles.title.copyWith(
            color: context.colors.labelPrimary,
          ),
        ),
      ),
    );
  }
}
