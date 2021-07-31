import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmanager/States/DatabaseStateModel.dart';
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
    return Consumer<DatabaseStateModel>(
      builder: (context, databaseState, child) {
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
                items: [
                  DropdownMenuItem(
                    child: Text("Local"),
                    value: "local",
                  ),
                  DropdownMenuItem(
                    child: Text("db_1"),
                    value: "db_1",
                  ),
                ],
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
