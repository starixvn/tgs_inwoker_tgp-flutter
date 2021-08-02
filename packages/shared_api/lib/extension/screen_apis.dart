import 'package:flutter/cupertino.dart';
import 'package:shared_api/extension/screen_util.dart';

extension ContextExtension on BuildContext{
  double get screenWidth => MediaQuery
      .of(this)
      .copyWith()
      .size
      .width;

  double get screenHeight => MediaQuery
      .of(this)
      .copyWith()
      .size
      .height;
}
extension DoubleExtension on double{
  double get auto => ScreenUtil.getInstance().getWidth(this);
}
extension IntExtension on int{
  double get auto => ScreenUtil.getInstance().getWidth(this.toDouble());
}
