import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmanager/States/DatabaseStateModel.dart';
import 'package:stockmanager/models/DatabaseInfo.dart';
import 'package:stockmanager/theme/CustomColors.dart';
import 'package:stockmanager/theme/CustomTheme.dart';

class DatabaseSelector extends StatefulWidget {
  @override
  State<DatabaseSelector> createState() => DatabaseSelectorState();
}

class DatabaseSelectorState extends State<DatabaseSelector> {
  String selectedDatabase = "local";

  @override
  Widget build(BuildContext context) {
    return Consumer2<DatabaseStateModel, DatabaseListStateModel>(
      builder: (context, databaseState, databaseList, child) {
        return Padding(
          padding: EdgeInsets.only(
            left: CustomTheme.navbarPadding,
            right: CustomTheme.navbarPadding,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: CustomColors.accentLight,
                width: 1.5,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: DropdownButton(
                value: databaseState.database,
                underline: SizedBox(),
                iconEnabledColor: CustomColors.accentLight,
                dropdownColor: CustomColors.darkContrastLight,
                style:
                    TextStyle(color: CustomColors.accentLight, fontSize: 25.0),
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: 40,
                ),
                items: databaseList.databases
                    .map(
                      (DatabaseInfo db) => DropdownMenuItem(
                        value: db.displayName,
                        child: Text(db.displayName),
                      ),
                    )
                    .toList(),
                onChanged: (String? newValue) {
                  databaseState.setDatabase(newValue!);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
