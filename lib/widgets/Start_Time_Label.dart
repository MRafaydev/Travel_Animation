import 'package:flutter/material.dart';
import 'package:flutter_application_555/Animation/Page_Offset.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../styles.dart';
import 'Map_Hider.dart';

class StartTimeLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * notifier.page - 3);
        return Positioned(
          top: topMargin(context) + mainSquareSize(context) + 32 + 16 + 32 + 40,
          width: (MediaQuery.of(context).size.width - 48) / 3,
          left: opacity * 24.0,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: MapHider(
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            '02:40 pm',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w300, color: lighterGrey),
          ),
        ),
      ),
    );
  }
}
