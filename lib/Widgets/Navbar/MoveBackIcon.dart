import 'package:flutter/material.dart';
import 'package:stockmanager/States/RouterStateModel.dart';
import 'package:stockmanager/theme/CustomColors.dart';

class MoveBackIcon extends StatelessWidget {
  final RouterStateModel router;

  MoveBackIcon({required this.router});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        router.setRoute("listing");
      },
      child: Icon(
        Icons.arrow_back,
        color: CustomColors.lightContrastLight,
        size: 40,
      ),
    );
  }
}
