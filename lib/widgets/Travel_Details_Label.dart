import 'package:flutter/material.dart';
import 'package:flutter_application_555/Animation/Page_Offset.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'Map_Hider.dart';

class TravelDetailsLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        return Positioned(
          top: topMargin(context) +
              (1 - animation.value) * (mainSquareSize(context) + 32 - 4),
          left: 24 + MediaQuery.of(context).size.width - notifier.offset,
          child: Opacity(
            opacity: math.max(0, 4 * notifier.page - 3),
            child: child,
          ),
        );
      },
      child: MapHider(
        child: Text(
          'Travel details',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
