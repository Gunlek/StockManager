import 'package:flutter/material.dart';
import 'package:stockmanager/theme/CustomTheme.dart';

class DatabaseSelector extends StatefulWidget {
  @override
  State<DatabaseSelector> createState() => DatabaseSelectorState();
}

class DatabaseSelectorState extends State<DatabaseSelector> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: CustomTheme.navbarPadding,
        right: CustomTheme.navbarPadding,
      ),
      child: Text("DatabaseSelector"),
    );
  }
}
