import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_application_555/Pages/leopard_page.dart';
import 'package:flutter_application_555/widgets/Base_Camp_Label.dart';
import 'package:flutter_application_555/widgets/Base_Time_Label.dart';
import 'package:flutter_application_555/widgets/Start_Camp_Label.dart';
import 'package:flutter_application_555/widgets/Start_Time_Label.dart';
import 'package:flutter_application_555/widgets/Travel_Details_Label.dart';
import 'package:flutter_application_555/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Animation/Page_Offset.dart';
import 'widgets/Horizontal_Travel_Dots.dart';
import 'Pages/Vulture_page.dart';
import 'widgets/Curved_Route.dart';
import 'widgets/DistanceLabel.dart';
import 'widgets/Leopard_Icon_Label.dart';
import 'widgets/Map_Base_Camp.dart';
import 'widgets/Map_Image.dart';
import 'widgets/Map_Vultures.dart';
import 'widgets/Map_leopards.dart';
import 'widgets/Map_start_camp.dart';
import 'widgets/Vertical_Travel_Dots.dart';

class MapAnimationNotifier with ChangeNotifier {
  final AnimationController _animationController;

  MapAnimationNotifier(this._animationController) {
    _animationController.addListener(_onAnimationControllerChanged);
  }

  double get value => _animationController.value;

  void forward() => _animationController.forward();

  void _onAnimationControllerChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _animationController.removeListener(_onAnimationControllerChanged);
    super.dispose();
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _mapAnimationController;
  final PageController _pageController = PageController();

  double get maxHeight => mainSquareSize(context) + 32 + 24;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _mapAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _mapAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaPadding = MediaQuery.of(context).padding;
    return ChangeNotifierProvider(
      create: (_) => PageOffsetNotifier(_pageController),
      child: ListenableProvider.value(
        value: _animationController,
        child: ChangeNotifierProvider(
          create: (_) => MapAnimationNotifier(_mapAnimationController),
          child: Scaffold(
            body: Stack(
              children: <Widget>[
                MapImage(),
                SafeArea(
                  child: GestureDetector(
                    onVerticalDragUpdate: _handleDragUpdate,
                    onVerticalDragEnd: _handleDragEnd,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        PageView(
                          controller: _pageController,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            LeopardPage(),
                            VulturePage(),
                          ],
                        ),
                        AppBar(),
                        LeopardImage(),
                        VultureImage(),
                        ShareButton(),
                        PageIndicator(),
                        ArrowIcon(),
                        TravelDetailsLabel(),
                        StartCampLabel(),
                        StartTimeLabel(),
                        BaseCampLabel(),
                        BaseTimeLabel(),
                        DistanceLabel(),
                        HorizontalTravelDots(),
                        MapButton(),
                        VerticalTravelDots(),
                        VultureIconLabel(),
                        LeopardIconLabel(),
                        CurvedRoute(),
                        MapBaseCamp(),
                        MapLeopards(),
                        MapVultures(),
                        MapStartCamp(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _animationController.value -= details.primaryDelta / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_animationController.isAnimating ||
        _animationController.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0)
      _animationController.fling(velocity: math.max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _animationController.fling(velocity: math.min(-2.0, -flingVelocity));
    else
      _animationController.fling(
          velocity: _animationController.value < 0.5 ? -2.0 : 2.0);
  }
}

class AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Row(
          children: <Widget>[
            Text('< / rafay > ',
                style: GoogleFonts.pacifico(
                  fontSize: 28,
                )),
            Spacer(),
            Icon(Icons.menu),
          ],
        ),
      ),
    );
  }
}

class MapButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 8,
      bottom: 0,
      child: Consumer<PageOffsetNotifier>(
        builder: (context, notifier, child) {
          double opacity = math.max(0, 4 * notifier.page - 3);
          return Opacity(
            opacity: opacity,
            child: child,
          );
        },
        child: TextButton(
          child: Text(
            'ON MAP',
            style: TextStyle(fontSize: 12),
          ),
          onPressed: () {
            final notifier =
                Provider.of<MapAnimationNotifier>(context, listen: false);
            notifier.value == 0
                ? notifier.forward()
                : notifier._animationController.reverse();
          },
        ),
      ),
    );
  }
}
