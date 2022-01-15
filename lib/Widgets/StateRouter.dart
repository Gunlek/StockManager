import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:stockmanager/Screens/ListingScreen.dart';
import 'package:stockmanager/Screens/SettingsScreen.dart';
import 'package:stockmanager/States/RouterStateModel.dart';
import 'package:stockmanager/Widgets/utils/ShiftRightFixer.dart';

class StateRouter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StateRouterState();
}

class _StateRouterState extends State<StateRouter> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RouterStateModel>(
      builder: (context, router, child) {
        if (router.current == LocalRoute.SETTINGS) {
          return ShiftRightFixer(
            child: SettingsScreen(),
          );
        }

        return ShiftRightFixer(
          child: ListingScreen(),
        );
      },
    );
  }
}
