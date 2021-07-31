import 'package:flutter/cupertino.dart';
import 'package:stockmanager/theme/CustomColors.dart';
import 'package:stockmanager/theme/CustomTheme.dart';

class DatabaseName extends StatefulWidget {
  String name = "DatabaseName";

  DatabaseName(String name) {
    this.name = name;
  }

  @override
  State<StatefulWidget> createState() => _DatabaseNameState(this.name);
}

class _DatabaseNameState extends State<DatabaseName> {
  String name = "DatabaseName";

  _DatabaseNameState(String name) {
    this.name = name;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: CustomTheme.databaseNamePadding,
      ),
      child: Text(
        this.name,
        style: TextStyle(
          fontSize: CustomTheme.databaseNameFontSize,
          fontFamily: "Roboto",
          decoration: TextDecoration.underline,
          color: CustomColors.secondaryLight,
        ),
      ),
    );
  }
}
