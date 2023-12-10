import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../size_config.dart';

double screenWidth = SizeConfig.screenWidth!;
double screenHeight = SizeConfig.screenHeight!;
height(double height) {
  return ScreenUtil().setHeight(height);
}

width(double width) {
  return ScreenUtil().setWidth(width);
}

radius(double radius) {
  return ScreenUtil().radius(radius);
}

sp(double sp) {
  return ScreenUtil().setSp(sp);
}
