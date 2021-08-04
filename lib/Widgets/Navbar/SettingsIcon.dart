import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stockmanager/States/RouterStateModel.dart';
import 'package:stockmanager/theme/CustomColors.dart';

class SettingsIcon extends StatelessWidget {
  final RouterStateModel router;

  SettingsIcon({required this.router});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print("test");
        this.router.setRoute("settings");
      },
      child: Icon(
        Icons.settings,
        color: CustomColors.lightContrastLight,
        size: 40,
      ),
    );
  }
}
