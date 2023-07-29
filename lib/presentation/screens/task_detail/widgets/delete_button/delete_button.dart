import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:todo/extensions/build_context_ext.dart';
import 'package:todo/l10n/locale_keys.g.dart';

class DeleteButton extends StatelessWidget {
  final IconData icon;
  final Color textColor;

  const DeleteButton({
    Key? key,
    required this.icon,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, right: 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor),
          const SizedBox(width: 12.0),
          Text(
            //Удалить
            LocaleKeys.delete.tr(),
            style: context.textStyles.body.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
