import 'package:flutter/material.dart';
import 'package:todo/presentation/screens/task_detail/widgets/delete_button/delete_button.dart';

class InkWellDeleteButton extends StatelessWidget {
  final String icon;
  final int textColor;
  final VoidCallback onTap;

  const InkWellDeleteButton({
    Key? key,
    required this.icon,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DeleteButton(icon: icon, textColor: textColor),
    );
  }
}
