import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:todo/l10n/locale_keys.g.dart';
import 'package:todo/constants.dart' as Constants;

class SomethingWentWrong extends StatelessWidget {
  VoidCallback onPressed;

  SomethingWentWrong({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            //Что-то пошло не так
            LocaleKeys.smthgWentWrong.tr(),
            style: TextStyle(
              fontSize: Constants.bodyFontSize,
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              //Обновить страницу
              LocaleKeys.refreshPage.tr(),
              style: TextStyle(
                color: Color(Constants.lightColorBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
