import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:todo/l10n/locale_keys.g.dart';
import 'package:todo/constants.dart' as Constants;
import 'package:todo/presentation/widgets/svg.dart';

class DeleteButton extends StatelessWidget {
  final String icon;
  final int textColor;

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
          SVG(imagePath: icon),
          const SizedBox(width: 12.0),
          Text(
            //Удалить
            LocaleKeys.delete.tr(),
            style: TextStyle(
              fontSize: Constants.bodyFontSize,
              height: Constants.bodyFontHeight,
              color: Color(textColor),
            ),
          ),
        ],
      ),
    );
  }
}
