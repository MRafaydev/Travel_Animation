import 'package:flutter/material.dart';
import 'package:flutter_application_555/Animation/Page_Offset.dart';
import 'package:flutter_application_555/Animation/Small_Animal_Icon_Label.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../Main_page.dart';

class MapVultures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MapAnimationNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * (notifier.value - 3 / 4));
        return Positioned(
          top: topMargin(context) + 32 + 16 + 4 + 2 * oneThird(context),
          right: 50,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: SmallAnimalIconLabel(
        isVulture: true,
        showLine: false,
      ),
    );
  }
}
