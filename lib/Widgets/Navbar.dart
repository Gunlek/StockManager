import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stockmanager/Widgets/DatabaseSelector/DatabaseSelector.dart';
import 'package:stockmanager/Widgets/ProfilePicture/ProfilePicture.dart';
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
                ProfilePicture(),
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
                  child: Icon(
                    Icons.settings,
                    color: CustomColors.lightContrastLight,
                    size: 40,
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
