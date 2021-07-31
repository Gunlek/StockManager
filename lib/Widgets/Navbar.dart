import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stockmanager/Widgets/DatabaseSelector.dart';
import 'package:stockmanager/Widgets/ProfilePicture.dart';
import 'package:stockmanager/theme/CustomColors.dart';
import 'package:stockmanager/theme/CustomTheme.dart';

class Navbar extends StatelessWidget {
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