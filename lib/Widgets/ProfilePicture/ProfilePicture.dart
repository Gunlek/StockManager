import 'package:flutter/material.dart';
import 'package:stockmanager/Widgets/ProfilePicture/ProfilePictureClipper.dart';
import 'package:stockmanager/theme/CustomTheme.dart';

class ProfilePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: CustomTheme.navbarPadding,
        right: CustomTheme.navbarPadding,
        top: 5,
        bottom: 5,
      ),
      child: ClipPath(
        clipper: ProfilePictureClipper(),
        child: Image.network("https://picsum.photos/200/200"),
      ),
    );
  }
}
