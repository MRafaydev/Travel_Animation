import 'package:flutter/material.dart';
import 'package:flutter_application_555/Animation/Page_Offset.dart';

import '../widgets/Leopard_Discription_Label.dart';
import '../widgets/The_72_Text.dart';
import '../widgets/Travel_Discription_Label.dart';

class LeopardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: topMargin(context)),
        The72Text(),
        SizedBox(height: 32),
        TravelDescriptionLabel(),
        SizedBox(height: 32),
        LeopardDescription(),
      ],
    );
  }
}
