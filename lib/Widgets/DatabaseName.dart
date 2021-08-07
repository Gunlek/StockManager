import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:stockmanager/States/DatabaseStateModel.dart';
import 'package:stockmanager/theme/CustomColors.dart';
import 'package:stockmanager/theme/CustomTheme.dart';

class DatabaseName extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DatabaseNameState();
}

class _DatabaseNameState extends State<DatabaseName> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseStateModel>(
      builder: (context, databaseState, child) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: CustomTheme.databaseNamePadding,
          ),
          child: Text(
            databaseState.database.displayName,
            style: TextStyle(
              fontSize: CustomTheme.databaseNameFontSize,
              fontFamily: "Roboto",
              decoration: TextDecoration.underline,
              color: CustomColors.secondaryLight,
            ),
          ),
        );
      },
    );
  }
}
