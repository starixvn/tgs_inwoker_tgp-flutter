import 'package:flutter/material.dart';
import 'package:tgp_flutter/src/custom_color.dart';

BoxDecoration gradientDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      CustomColor.theme_bar_gradient_1,
      CustomColor.theme_bar_gradient_2
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  ),
);


BoxDecoration roundGradientDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      CustomColor.theme_bar_gradient_1,
      CustomColor.theme_bar_gradient_2
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  ),
    borderRadius: BorderRadius.all(Radius.circular(45))
);

BoxDecoration roundButtonGradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        CustomColor.theme_bar_gradient_1,
        CustomColor.theme_bar_gradient_2
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ),
    borderRadius: BorderRadius.all(Radius.circular(10))
);