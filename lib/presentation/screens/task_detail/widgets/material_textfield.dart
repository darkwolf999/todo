import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:todo/l10n/locale_keys.g.dart';
import 'package:todo/constants.dart' as Constants;

class MaterialTextfield extends StatelessWidget {
  final TextEditingController textController;

  const MaterialTextfield({
    Key? key,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8.0),
      elevation: 2,
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.all(16.0),
          //Что надо сделать…
          labelText: LocaleKeys.whatToDo.tr(),
          alignLabelWithHint: true,
          labelStyle: const TextStyle(
            fontSize: Constants.bodyFontSize,
            height: 18.0 / Constants.bodyFontSize,
            color: Color(Constants.lightLabelTertiary),
          ),
          filled: true,
          fillColor: const Color(Constants.lightBackSecondary),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        style: const TextStyle(
          fontSize: Constants.bodyFontSize,
          height: 18.0 / Constants.bodyFontSize,
          color: Color(Constants.lightLabelPrimary),
        ),
        maxLines: null,
        minLines: 5,
      ),
    );
  }
}
