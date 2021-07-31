import 'package:flutter/material.dart';
import 'package:stockmanager/theme/CustomTheme.dart';

class ProfilePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: CustomTheme.navbarPadding,
        right: CustomTheme.navbarPadding,
      ),
      child: Text("ProfilePicture"),
    );
  }
}
