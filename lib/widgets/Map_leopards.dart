import 'package:flutter/material.dart';
import 'package:flutter_application_555/Animation/Page_Offset.dart';
import 'package:flutter_application_555/Animation/Small_Animal_Icon_Label.dart';
import 'package:provider/provider.dart';

import '../Main_page.dart';
import 'dart:math' as math;

class MapLeopards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MapAnimationNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * (notifier.value - 3 / 4));
        return Positioned(
          top: topMargin(context) + 32 + 16 + 4 + oneThird(context),
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: SmallAnimalIconLabel(
          isVulture: false,
          showLine: false,
        ),
      ),
    );
  }
}
