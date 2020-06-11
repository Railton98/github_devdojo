import 'package:flutter/material.dart';

class WidgetCallSafe extends StatelessWidget {
  final bool Function() checkIfNull;
  final Widget Function() success;
  final Widget Function() fail;

  const WidgetCallSafe({
    Key key,
    this.checkIfNull,
    this.success,
    this.fail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isTrue = checkIfNull();
    if (isTrue) {
      return success();
    }
    return fail();
  }
}
