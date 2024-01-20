import 'package:flutter/cupertino.dart';
import 'package:flutter_steps_tracker/design/screens/bottom_nav_bar/bottom_navbar.dart';
import 'package:flutter_steps_tracker/routes/routes.dart';
import 'package:flutter_steps_tracker/design/screens/steper_tracker/step_tracker_view.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.homePageRoute:
      return CupertinoPageRoute(
        builder: (_) => const BottomNavbar(),
        settings: settings,
      );
    case AppRoutes.stepTrackerViewRoute:
    default:
      return CupertinoPageRoute(
        builder: (_) => const StepTrackerView(),
        settings: settings,
      );
  }
}
