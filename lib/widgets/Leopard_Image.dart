import 'package:flutter/material.dart';
import 'package:flutter_application_555/Animation/Page_Offset.dart';
import 'package:provider/provider.dart';

import 'Map_Hider.dart';

class LeopardImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        return Positioned(
          left: -0.85 * notifier.offset,
          width: MediaQuery.of(context).size.width * 1.6,
          child: Transform.scale(
            alignment: Alignment(0.6, 0),
            scale: 1 - 0.1 * animation.value,
            child: Opacity(
              opacity: 1 - 0.6 * animation.value,
              child: child,
            ),
          ),
        );
      },
      child: MapHider(
        child: IgnorePointer(
          child: Image.asset('assets/leopard.png'),
        ),
      ),
    );
  }
}
