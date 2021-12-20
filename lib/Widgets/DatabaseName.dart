import 'package:flutter/cupertino.dart';
import 'package:stockmanager/States/DatabaseStateModel.dart';
import 'package:stockmanager/theme/CustomColors.dart';
import 'package:stockmanager/theme/CustomTheme.dart';

class DatabaseName extends StatefulWidget {
  final DatabaseStateModel databaseState;

  DatabaseName({required this.databaseState});

  @override
  State<StatefulWidget> createState() => _DatabaseNameState(this.databaseState);
}

class _DatabaseNameState extends State<DatabaseName> {
  DatabaseStateModel databaseState;

  _DatabaseNameState(this.databaseState);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: CustomTheme.databaseNamePadding,
      ),
      child: Text(
        this.databaseState.database.displayName,
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
