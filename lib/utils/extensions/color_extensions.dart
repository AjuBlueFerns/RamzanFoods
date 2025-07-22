import 'package:flutter/material.dart';

extension ColorExt on Color {
   ColorFilter? get toColorFilter {
      return ColorFilter.mode(this, BlendMode.srcIn);
  }
}