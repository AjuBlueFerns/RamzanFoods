import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get screenWidth => size.width;
  double get screenHeight => size.height;
  void pop() {
    return Navigator.pop(this);
  }

  Color get primaryColor => Theme.of(this).primaryColor;
  double get bottomInsets => MediaQuery.of(this).viewInsets.bottom;
  bool get isKeyboardOpen => bottomInsets != 0;
  bool get isFirst => ModalRoute.of(this)!.isFirst;
}
