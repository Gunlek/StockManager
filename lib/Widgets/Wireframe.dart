import 'package:flutter/material.dart';
import 'package:stockmanager/theme/CustomColors.dart';
import 'package:stockmanager/theme/CustomTheme.dart';

import 'Navbar/Navbar.dart';

class Wireframe extends StatelessWidget {
  final Widget child;

  Wireframe({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.lightContrastLight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Navbar(),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(
                  CustomTheme.mainPadding,
                ),
                child: child,
              ),
            )
          ],
        ),
      ),
    );
  }
}
