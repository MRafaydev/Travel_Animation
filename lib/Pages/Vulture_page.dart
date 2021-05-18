import 'package:flutter/material.dart';
import 'package:flutter_application_555/widgets/Map_Hider.dart';
import 'package:flutter_application_555/widgets/widgets.dart';

class VulturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MapHider(
        child: VultureCircle(),
      ),
    );
  }
}
