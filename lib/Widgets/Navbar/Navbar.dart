import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmanager/States/RouterStateModel.dart';
import 'package:stockmanager/Widgets/DatabaseSelector/DatabaseSelector.dart';
import 'package:stockmanager/Widgets/Navbar/MoveBackIcon.dart';
import 'package:stockmanager/Widgets/Navbar/SettingsIcon.dart';
import 'package:stockmanager/theme/CustomColors.dart';
import 'package:stockmanager/theme/CustomTheme.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: CustomColors.primaryLight,
      child: Row(
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                  ),
                ),
                Text(
                  "StockManager",
                  style: TextStyle(
                    fontSize: 30,
                    color: CustomColors.lightContrastLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            flex: 1,
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DatabaseSelector(),
                Padding(
                  padding: EdgeInsets.only(
                    left: CustomTheme.navbarPadding,
                    right: CustomTheme.navbarPadding,
                  ),
                  child: Consumer<RouterStateModel>(
                    builder: (context, router, Widget? child) {
                      return router.current == LocalRoute.LISTING
                          ? SettingsIcon(router: router)
                          : MoveBackIcon(router: router);
                    },
                  ),
                ),
              ],
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
