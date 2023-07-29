import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:todo/extensions/build_context_ext.dart';

class CustomSysUiOverlayStyle extends StatelessWidget {
  final Widget child;

  const CustomSysUiOverlayStyle({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: context.colors.backPrimary,
        systemNavigationBarIconBrightness: context.brightness,
      ),
      child: child,
    );
  }
}
