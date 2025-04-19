import 'package:flutter/cupertino.dart';

extension ResponsiveExtensions on BuildContext {
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double rs(double size) => (size / 1000) * MediaQuery.sizeOf(this).height;
}
